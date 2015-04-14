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
    NSArray* users = [User MR_findAll];
    return users.count;
}

- (NSString *)nameWithIndexPath:(NSIndexPath *)indexPath {
    User* user = [User MR_findAll][indexPath.row];
    return user.name;
}

- (void)deleteUserWithName:(NSString *)name completion:(void (^)(BOOL success))completion {
    [MagicalRecord saveUsingCurrentThreadContextWithBlock:^(NSManagedObjectContext *localContext) {
        NSArray* users = [User MR_findByAttribute:@"name" withValue:name];
        for (User* user in users) {
            [user MR_deleteEntity];
        }
    } completion:^(BOOL success, NSError *error) {
        if (completion) {
            completion(error ? NO : YES);
        }
    }];
}

@end
