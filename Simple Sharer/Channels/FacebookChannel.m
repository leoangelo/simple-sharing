//
//  FacebookChannel.m
//  Simple Sharing
//
//  Created by Leo Angelo Quigao on 3/2/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import "FacebookChannel.h"
#import "FacebookIntegration.h"

@implementation FacebookChannel

- (NSString *)localizedTitle
{
    return NSLocalizedString(@"Facebook", nil);
}


- (void)invokeAction
{
    if ([FacebookIntegration isAllowedPermission:eFacebookPermissionTypeWrite] && [FacebookIntegration hasActiveSession]) {
        [self callShareAPI];
    }
    else {
        // request for write permissions first
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callShareAPI) name:kFacebookNotificationSessionOpened object:nil];
        [FacebookIntegration requestPermission:eFacebookPermissionTypeWrite];
    }
}

- (void)callShareAPI
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [self dictionary:params insertValue:self.sharedData.shareTitle witKey:@"name"];
    [self dictionary:params insertValue:self.sharedData.shareCaption witKey:@"caption"];
    [self dictionary:params insertValue:self.sharedData.shareDescription witKey:@"description"];
    [self dictionary:params insertValue:self.sharedData.link.absoluteString witKey:@"link"];
    [self dictionary:params insertValue:self.sharedData.imageLink.absoluteString witKey:@"picture"];
    
    // Make the request
    [FBRequestConnection startWithGraphPath:@"/me/feed"
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  // Link posted successfully to Facebook
                                  NSLog(@"result: %@", result);
                              } else {
                                  // An error occurred, we need to handle the error
                                  // See: https://developers.facebook.com/docs/ios/errors
                                  NSLog(@"%@", error.description);
                              }
                          }];
    
    // after we're done, remove the notification observer to clean up
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFacebookNotificationSessionOpened object:nil];
}

- (void)dictionary:(NSMutableDictionary *)dictionary insertValue:(id)value witKey:(NSString *)key
{
    if (value) {
        dictionary[key] = value;
    }
}

@end
