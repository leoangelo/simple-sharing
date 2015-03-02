//
//  SocialFrameworkChannel.m
//  Simple Sharing
//
//  Created by Leo Angelo Quigao on 3/2/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import <Social/Social.h>
#import "SocialFrameworkChannel.h"

@implementation SocialFrameworkChannel

- (void)invokeAction
{
    SLComposeViewController *viewController = [SLComposeViewController composeViewControllerForServiceType:self.socialType];
    
    [viewController setInitialText:self.sharedData.initialText];
    [viewController addURL:self.sharedData.link];
    [viewController addImage:self.sharedData.image];
    
    __block SharingChannel *blockSelf = self;
    [viewController setCompletionHandler:^(SLComposeViewControllerResult result) {
        if (result == SLComposeViewControllerResultDone) {
            [self.delegate sharingComplete:blockSelf];
        }
    }];
    
    [self.parentViewController presentViewController:viewController
                                            animated:YES
                                          completion:nil];
}

@end
