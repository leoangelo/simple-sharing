//
//  FacebookIntegration.m
//  Simple Sharing
//
//  Created by Leo Angelo Quigao on 3/3/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import "FacebookIntegration.h"

NSString * const kFacebookNotificationSessionOpened = @"kFacebookNotificationSessionOpened";

@implementation FacebookIntegration

+ (void)initializeFacebookSession
{
    // Whenever a person opens app, check for a cached session
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // Call this method EACH time the session state changes,
                                          //  NOT just when the session open
                                          [self sessionStateChanged:session state:state error:error];
                                      }];
    }
}

+ (void)requestPermission:(eFacebookPermissionType)type
{
    if (type == eFacebookPermissionTypeRead) {
        if ([self hasActiveSession] && ![self isAllowedPermission:type]) {
            FBSession *activeSession = FBSession.activeSession;
            [activeSession requestNewReadPermissions:@[@"public_profile"] completionHandler:^(FBSession *session, NSError *error) {
                [self sessionStateChanged:session state:session.state error:error];
            }];
        }
        else if (![self hasActiveSession]) {
            // Open a session showing the user the login UI
            // You must ALWAYS ask for public_profile permissions when opening a session
            [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                               allowLoginUI:YES
                                          completionHandler:
             ^(FBSession *session, FBSessionState state, NSError *error) {
                 [self sessionStateChanged:session state:state error:error];
             }];
        }
    }
    else if (type == eFacebookPermissionTypeWrite) {
        if ([self hasActiveSession] && ![self isAllowedPermission:type]) {
            FBSession *activeSession = FBSession.activeSession;
            [activeSession requestNewPublishPermissions:@[@"publish_actions"] defaultAudience:FBSessionDefaultAudienceFriends completionHandler:^(FBSession *session, NSError *error) {
                [self sessionStateChanged:session state:session.state error:error];
            }];
        }
        else if (![self hasActiveSession]) {
            [FBSession openActiveSessionWithPublishPermissions:@[@"publish_actions"] defaultAudience:FBSessionDefaultAudienceFriends allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                [self sessionStateChanged:session state:status error:error];
            }];
        }
    }
}



+ (void)logOut
{
    // If the session state is any of the two "open" states when the button is clicked
    if (FB_ISSESSIONOPENWITHSTATE(FBSession.activeSession.state)) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    }
}

+ (BOOL)hasActiveSession
{
    FBSession *activeSession = FBSession.activeSession;
    return FB_ISSESSIONOPENWITHSTATE(activeSession.state);
}

+ (BOOL)isAllowedPermission:(eFacebookPermissionType)type
{
    FBSession *activeSession = FBSession.activeSession;
    if (type == eFacebookPermissionTypeRead ) {
        return [activeSession hasGranted:@"public_profile"];
    }
    else if (type == eFacebookPermissionTypeWrite) {
        return [activeSession hasGranted:@"publish_actions"];
    }
    return NO;
}

+ (BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
{
    // Note this handler block should be the exact same as the handler passed to any open calls.
    [FBSession.activeSession setStateChangeHandler:
     ^(FBSession *session, FBSessionState state, NSError *error) {         
         [self sessionStateChanged:session state:state error:error];
     }];
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}


+ (void)handleDidBecomeActive
{
    [FBAppCall handleDidBecomeActive];
}

// Handles session state changes in the app
+ (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && FB_ISSESSIONOPENWITHSTATE(state)) {
        NSLog(@"Session opened");
        [[NSNotificationCenter defaultCenter] postNotificationName:kFacebookNotificationSessionOpened object:nil];
        return;
    }
    if (FB_ISSESSIONSTATETERMINAL(state)){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            [self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                [self showMessage:alertText withTitle:alertTitle];
                // Here we will handle all other errors with a generic error message.
                // We recommend you check our Handling Errors guide for more information
                // https://developers.facebook.com/docs/ios/errors/
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                [self showMessage:alertText withTitle:alertTitle];
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
}

+ (void)userLoggedOut
{
    NSLog(@"You have logged out!");
}

+ (void)showMessage:(NSString *)alertText withTitle:(NSString *)alertTitle
{
    NSLog(@"%@: %@", alertTitle, alertText);
}


@end
