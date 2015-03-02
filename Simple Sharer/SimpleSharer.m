//
//  SimpleSharer.m
//  Simple Sharing
//
//  Created by Leo Angelo Quigao on 3/2/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import "SimpleSharer.h"
#import "SharingChannel.h"

@interface SimpleSharer () <UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *channels;

@end

@implementation SimpleSharer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sharerTitle = NSLocalizedString(@"Share to...", nil);
        _cancelButtonString = NSLocalizedString(@"Cancel", nil);
        
        // create the array
        self.channels = [[NSMutableArray alloc] init];
        
        // register the channels
        [self registerChannels];
    }
    return self;
}

- (void)registerChannels
{
    // The order here determines the order they will show up in the action sheet
    // Prefixes of the classes, i.e. EmailChannel
    [self registerChannel:@"Facebook"];
    [self registerChannel:@"Twitter"];
    [self registerChannel:@"Email"];
    [self registerChannel:@"SMS"];
}

- (void)launchSharer
{
    if (!self.parentViewController) {
        NSLog(@"Missing view controller");
        return;
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:self.sharerTitle delegate:self cancelButtonTitle:self.cancelButtonString destructiveButtonTitle:nil otherButtonTitles:nil];
    
    [self.channels enumerateObjectsUsingBlock:^(SharingChannel *obj, NSUInteger idx, BOOL *stop) {
        [obj setSharedData:self.sharedData];
        [obj setParentViewController:self.parentViewController];
        [actionSheet addButtonWithTitle:[obj localizedTitle]];
    }];
    
    [actionSheet showInView:self.parentViewController.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 0 is the cancel button's index
    if (buttonIndex > 0) {
        SharingChannel *channel = self.channels[buttonIndex-1];
        [channel invokeAction];
    }
}

- (void)registerChannel:(NSString *)prefix
{
    NSString *aChannelString = [NSString stringWithFormat:@"%@Channel", prefix];
    Class aClass = NSClassFromString(aChannelString);
    if (aClass != nil) {
        SharingChannel *aChannel = (SharingChannel *)[[aClass alloc] init];
        
        // check first if option is possible
        if ([aChannel canShareOnChannel]) {
            [self.channels addObject:aChannel];
        }
    }
    else {
        NSLog(@"Invalid class name %@", aChannelString);
    }
}

@end
