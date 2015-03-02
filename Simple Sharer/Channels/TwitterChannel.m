//
//  TwitterChannel.m
//  Simple Sharing
//
//  Created by Leo Angelo Quigao on 3/2/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import <Social/Social.h>
#import "TwitterChannel.h"

@implementation TwitterChannel

- (id)init
{
    self = [super init];
    if (self) {
        self.socialType = SLServiceTypeTwitter;
    }
    return self;
}

- (NSString *)localizedTitle
{
    return NSLocalizedString(@"Twitter", nil);
}

@end
