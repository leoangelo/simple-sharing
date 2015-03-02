//
//  SharingChannel.h
//  Simple Sharing
//
//  Created by Leo Angelo Quigao on 3/2/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharingDataWrapper.h"

@protocol SharingChannelDelegate;

@interface SharingChannel : NSObject

@property (nonatomic, strong) SharingDataWrapper *sharedData;
@property (nonatomic, weak) UIViewController *parentViewController;
@property (nonatomic, weak) id<SharingChannelDelegate> delegate;

- (NSString *)localizedTitle;
- (BOOL)canShareOnChannel;
- (void)invokeAction;

@end

@protocol SharingChannelDelegate <NSObject>

- (void)sharingComplete:(SharingChannel *)channel;

@end