//
//  EmailChannel.m
//  Simple Sharing
//
//  Created by Leo Angelo Quigao on 3/2/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "EmailChannel.h"

@implementation EmailChannel

- (NSString *)localizedTitle
{
    return NSLocalizedString(@"E-mail", nil);
}

- (void)invokeAction
{
    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
    [mailComposeViewController setSubject:self.sharedData.initialText];
    
    
    
    [mailComposeViewController setMessageBody:self.sharedData.emailBody
                                       isHTML:NO];
    [mailComposeViewController addAttachmentData:UIImageJPEGRepresentation(self.self.sharedData.image, 1.0) mimeType:@"image/jpeg" fileName:@"attachment.jpeg"];
    [self.parentViewController presentViewController:mailComposeViewController animated:YES completion:nil];
}

- (BOOL)canShareOnChannel
{
    return [MFMailComposeViewController canSendMail];
}

@end
