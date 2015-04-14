//
//  AppDelegate.m
//  MLottery
//
//  Created by Jack on 4/13/15.
//  Copyright (c) 2015 Jack. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchScreenViewController.h"

@import MagicalRecord;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [MagicalRecord setupAutoMigratingCoreDataStack];
    return YES;
}

@end
