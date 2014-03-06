//
//  ARUser.m
//  AROne
//
//  Created by Chenchen Zheng on 3/5/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARUser.h"

@implementation ARUser
@dynamic userIcon;
@dynamic username;
@dynamic name;
@dynamic email;

+ (NSString *)parseClassName {
  return @"User";
}

@end
