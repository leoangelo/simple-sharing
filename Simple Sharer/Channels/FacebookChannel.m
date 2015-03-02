//
//  FacebookChannel.m
//  Simple Sharing
//
//  Created by Leo Angelo Quigao on 3/2/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import <Social/Social.h>
#import "FacebookChannel.h"

@implementation FacebookChannel

- (id)init
{
    self = [super init];
    if (self) {
        self.socialType = SLServiceTypeFacebook;
    }
    return self;
}

- (NSString *)localizedTitle
{
    return NSLocalizedString(@"Facebook", nil);
}

@end
