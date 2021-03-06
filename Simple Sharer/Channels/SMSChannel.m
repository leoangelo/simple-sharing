//
//  SMSChannel.m
//  Simple Sharing
//
//  Created by Leo Angelo Quigao on 3/2/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "SMSChannel.h"

@interface SMSChannel ()

@end

@implementation SMSChannel

- (NSString *)localizedTitle
{
    return NSLocalizedString(@"SMS", nil);
}

- (void)invokeAction
{
    MFMessageComposeViewController *messageComposeViewController = [[MFMessageComposeViewController alloc] init];
    messageComposeViewController.body = @"SMS Shit";
    [self.parentViewController presentViewController:messageComposeViewController animated:YES completion:^{
        
    }];
}

- (BOOL)canShareOnChannel
{
    return [MFMessageComposeViewController canSendText];
}

@end
