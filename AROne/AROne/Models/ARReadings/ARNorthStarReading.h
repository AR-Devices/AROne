//
//  ARNorthStarReading.h
//  AROne
//
//  Created by Chenchen Zheng on 2/12/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARReading.h"

typedef enum {
  ARNorthStarReadingValid = 'A',
  ARNorthStarReadingInvalid = 'V'
} ARReadingValidity;

@interface ARNorthStarReading : ARReading

@property (nonatomic) ARReadingValidity validity;
@property (nonatomic, strong) NSNumber *speed;
@property (nonatomic, strong) NSString *direction;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSDate *measuredDateTime;
@property (nonatomic, strong) NSNumber *altitude;

@end
