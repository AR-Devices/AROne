//
//  ARNorthStar.h
//  AROne
//
//  Created by Chenchen Zheng on 6/12/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARDevice.h"

typedef NS_ENUM(NSInteger, ARNS) {
  AR_DESC,
  AR_ASC
};

@interface ARNorthStar : ARDevice

@property (nonatomic, strong) NSNumber *measurementID;
@property (nonatomic, strong) NSString *measurementTime;
@property (nonatomic, strong) NSString *measurementReceivedTime;
/**
 * Weight in NSnumber
 */
@property (nonatomic, strong) NSNumber *WSWeight;
@property (nonatomic, strong) NSString *units;
@property (nonatomic, strong) NSNumber *bmi;
@property (nonatomic, strong) NSNumber *userID;
@property (nonatomic, strong) NSNumber *isManualInput;

- (id)initWithDevice:(ARDevice *)device;
- (void)pair;
- (void)readMeasurement;
@end
