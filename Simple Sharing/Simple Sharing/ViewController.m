//
//  ViewController.m
//  Simple Sharing
//
//  Created by Leo Angelo Quigao on 3/2/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import "ViewController.h"
#import "SimpleSharer.h"

@interface ViewController ()

@property (nonatomic, strong) SimpleSharer *sharer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
    data.link = [NSURL URLWithString:@"http://staging-landing.nofomo.com/venue/gotham/atlantic-bar-grill-5506"];
    
    [self.sharer setSharedData:data];
    [self.sharer setParentViewController:self];
    [self.sharer launchSharer];
}

@end
