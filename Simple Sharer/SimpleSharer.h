//
//  SimpleSharer.h
//  Simple Sharing
//
//  Created by Leo Angelo Quigao on 3/2/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharingDataWrapper.h"

@interface SimpleSharer : NSObject

@property (nonatomic, strong) NSString *sharerTitle;
@property (nonatomic, strong) NSString *cancelButtonString;

@property (nonatomic, strong) SharingDataWrapper *sharedData;
@property (nonatomic, weak) UIViewController *parentViewController;

- (void)launchSharer;

@end
