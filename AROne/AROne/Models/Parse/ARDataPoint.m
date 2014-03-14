//
//  ARDataPoint.m
//  AROne
//
//  Created by Chenchen Zheng on 3/8/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARDataPoint.h"
#import <Parse/PFObject+Subclass.h>

@implementation ARDataPoint
@dynamic acceleration;
@dynamic speed;
@dynamic verticalDrop;
@dynamic dateRecord;
@dynamic timeRecord;
@dynamic player;

+ (NSString *)parseClassName {
  return @"DataPoint3";
}

@end
