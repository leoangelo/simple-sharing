//
//  ViewController.m
//  Simple Sharing
//
//  Created by Leo Angelo Quigao on 3/2/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import "FacebookIntegration.h"
#import "ViewController.h"
#import "SimpleSharer.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIButton *facebookButton;
@property (nonatomic, strong) SimpleSharer *sharer;

@end

@implementation ViewController


- (void)dealloc
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sharePressed:(id)sender
{
    if (!self.sharer) {
        self.sharer = [[SimpleSharer alloc] init];
    }
    
    SharingDataWrapper *data = [SharingDataWrapper new];
    data.shareTitle = @"Atlantic bar grill";
    data.shareDescription = @"Check this out!";
    data.link = [NSURL URLWithString:@"http://staging-landing.nofomo.com/venue/gotham/atlantic-bar-grill-5506"];
    data.imageLink = [NSURL URLWithString:@"http://nofomo.com/images/final-pin-1_360.png"];
    data.shareCaption = @"From nofomo.com";
    
    [self.sharer setSharedData:data];
    [self.sharer setParentViewController:self];
    [self.sharer launchSharer];
}

@end
