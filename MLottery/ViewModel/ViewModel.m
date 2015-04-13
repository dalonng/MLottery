//
//  ViewModel.m
//  MLottery
//
//  Created by Jack on 4/13/15.
//  Copyright (c) 2015 Jack. All rights reserved.
//

#import "ViewModel.h"
#import "User.h"
@import MagicalRecord;
@import UIKit;

@implementation ViewModel

- (NSUInteger)numberOfUsers {
    return [User MR_findAll].count;
}

- (NSString *)nameWithIndexPath:(NSIndexPath *)indexPath {
    User* user = [User MR_findAll][indexPath.row];
    return user.name;
}

@end
