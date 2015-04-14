//
//  User.m
//  
//
//  Created by Jack on 4/13/15.
//
//

#import "User.h"


@implementation User

@dynamic name;

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> name: %@", NSStringFromClass([self class]), self, self.name];
}

@end
