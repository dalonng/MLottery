//
//  UserViewModel.m
//  MLottery
//
//  Created by Jack on 4/13/15.
//  Copyright (c) 2015 Jack. All rights reserved.
//

#import "UserViewModel.h"
#import "User.h"
@import UIKit;
@import MagicalRecord;

@implementation UserViewModel

- (NSUInteger)numberOfUsers {
    NSArray* users = [User MR_findAll];
    return users.count;
}

- (NSString *)nameWithIndexPath:(NSIndexPath *)indexPath {
    User* user = [User MR_findAll][indexPath.row];
    return user.name;
}

- (void)addUserWithName:(NSString *)name completion:(void (^)(BOOL success))completion {
    NSArray* users = [User MR_findByAttribute:@"name" withValue:name];
    if (users && users.firstObject) {
        if (completion) {
            completion(NO);
            return;
        }
    }
    [MagicalRecord saveUsingCurrentThreadContextWithBlock:^(NSManagedObjectContext *localContext) {
        User *userManagedObject = [User MR_createEntity];
        userManagedObject.name = name;
    } completion:^(BOOL success, NSError *error) {
        if (completion) {
            completion(error ? NO : YES);
        }
    }];
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
