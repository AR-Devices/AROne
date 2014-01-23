//
//  TrailPoint.m
//  TrailSummary
//
//  Created by Chenchen Zheng on 12/16/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "TrailPoint.h"

@implementation TrailPoint

- (TrailPoint *) initWithNorth:(double)north west:(double)west
{
    
    self = [super init];
    //do calculation here...
    _northDegree = north;
    _westDegree = west;
    return self;
    
}
- (TrailPoint *)initWithNorthDegree:(double)northDegree NorthMinute:(double)northMinute NorthSecond:(double)northSecond WestDegree:(double)westDegree WestMinute:(double)westMinute WestSecond:(double)westSecond Elevation:(int)elevation
{
    
    self = [super init];
    _northDegree = northDegree;
    _northMinute = northMinute;
    _northSecond = northSecond;
    _westDegree = westDegree;
    _westMinute = westMinute;
    _westSecond = westSecond;
    _elevation = elevation;
    
    return self;
}

@end
