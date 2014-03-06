//
//  ARUser.h
//  AROne
//
//  Created by Chenchen Zheng on 3/5/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <Parse/Parse.h>

@interface ARUser : PFObject

@property NSString *username;
@property NSString *email;
@property NSString *name;
@property UIImage *userIcon;

+ (NSString *)parseClassName;

@end
