//
//  LotteryManager.m
//  MLottery
//
//  Created by Jack on 4/13/15.
//  Copyright (c) 2015 Jack. All rights reserved.
//

#import "LotteryManager.h"

@implementation LotteryManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static LotteryManager* instance;
    dispatch_once(&onceToken, ^{
        instance = [LotteryManager new];
    });
    return instance;
}

@end
