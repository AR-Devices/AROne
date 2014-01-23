//
//  TrailPoint.h
//  TrailSummary
//
//  Created by Chenchen Zheng on 12/16/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrailPoint : NSObject

@property (nonatomic) double northDegree;
@property (nonatomic) double northMinute;
@property (nonatomic) double northSecond;
@property (nonatomic) double westDegree;
@property (nonatomic) double westMinute;
@property (nonatomic) double westSecond;
@property (nonatomic) int    elevation;

- (TrailPoint *)initWithNorth:(double)north west:(double)west;
- (TrailPoint *)initWithNorthDegree:(double)northDegree
          NorthMinute:(double)northMinute
          NorthSecond:(double)northSecond
           WestDegree:(double)westDegree
           WestMinute:(double)westMinute
           WestSecond:(double)westSecond
            Elevation:(int)elevation;


@end
