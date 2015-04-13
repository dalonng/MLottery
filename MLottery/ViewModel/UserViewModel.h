//
//  UserViewModel.h
//  MLottery
//
//  Created by Jack on 4/13/15.
//  Copyright (c) 2015 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserViewModel : NSObject

- (NSUInteger)numberOfUsers;
- (NSString *)nameWithIndexPath:(NSIndexPath *)indexPath;

- (void)addUserWithName:(NSString *)name completion:(void (^)(BOOL success))completion;

@end
