//
//  ARSummary.h
//  AROne
//
//  Created by Chenchen Zheng on 2/28/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <Parse/Parse.h>

@interface ARSummary : PFObject <PFSubclassing>

@property (retain) NSString *displayName;

@property NSString *date;
@property double maxSpeed;
@property double maxAcceleration;
@property int verticalDrop;
@property PFUser *player;


+ (NSString *)parseClassName;

@end
