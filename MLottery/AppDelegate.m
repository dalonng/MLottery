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
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil];
    LaunchScreenViewController* launchScreenViewController = [storyBoard instantiateInitialViewController];
    self.window.rootViewController = launchScreenViewController;
    [self.window makeKeyAndVisible];
    
    int64_t delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.window.rootViewController = [storyBoard instantiateInitialViewController];
        [self.window makeKeyAndVisible];
    });
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
