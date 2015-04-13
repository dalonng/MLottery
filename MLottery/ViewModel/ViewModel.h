//
//  ViewModel.h
//  MLottery
//
//  Created by Jack on 4/13/15.
//  Copyright (c) 2015 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModel : NSObject

@property (nonatomic, strong) NSArray* users;

- (NSUInteger)numberOfUsers;
- (NSString *)nameWithIndexPath:(NSIndexPath *)indexPath;

@end
