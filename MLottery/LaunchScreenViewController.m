//
//  LaunchScreenViewController.m
//  MLottery
//
//  Created by Jack on 4/14/15.
//  Copyright (c) 2015 Jack. All rights reserved.
//

#import "LaunchScreenViewController.h"

@import MLPSpotlight;

@interface LaunchScreenViewController ()

@property (nonatomic, strong) IBOutlet UILabel* spotlightLabel;

@end

@implementation LaunchScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MLPSpotlight addSpotlightInView:self.view atPoint:self.spotlightLabel.center];
}

@end
