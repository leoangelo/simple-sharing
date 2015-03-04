//
//  FacebookIntegration.h
//  Simple Sharing
//
//  Created by Leo Angelo Quigao on 3/3/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    eFacebookPermissionTypeRead,
    eFacebookPermissionTypeWrite
} eFacebookPermissionType;

extern NSString * const kFacebookNotificationSessionOpened;

// Integration code taken entirely from https://developers.facebook.com/docs/facebook-login/ios/v2.2
@interface FacebookIntegration : NSObject

+ (void)initializeFacebookSession;

// Returns yes if already allowed in the first place
+ (void)requestPermission:(eFacebookPermissionType)type;
+ (BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;
+ (void)handleDidBecomeActive;

+ (BOOL)hasActiveSession;
+ (BOOL)isAllowedPermission:(eFacebookPermissionType)type;

@end
