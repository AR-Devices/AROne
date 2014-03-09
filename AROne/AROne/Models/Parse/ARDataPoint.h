//
//  ARDataPoint.h
//  AROne
//
//  Created by Chenchen Zheng on 3/8/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <Parse/Parse.h>

@interface ARDataPoint : PFObject <PFSubclassing>

@property NSString *dateRecord;
@property NSString *timeRecord;
@property double speed;
@property double acceleration;
@property int verticalDrop;
@property PFUser *player;

+ (NSString *)parseClassName;

@end
