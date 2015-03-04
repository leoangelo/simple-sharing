//
//  SharingDataWrapper.h
//  Simple Sharing
//
//  Created by Leo Angelo Quigao on 3/2/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharingDataWrapper : NSObject

@property (nonatomic, strong) NSString *shareTitle;
@property (nonatomic, strong) NSString *shareCaption;
@property (nonatomic, strong) NSString *shareDescription;
@property (nonatomic, strong) NSString *initialText;
@property (nonatomic, strong) NSURL *link;
@property (nonatomic, strong) NSURL *imageLink;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *emailBody;

@end
