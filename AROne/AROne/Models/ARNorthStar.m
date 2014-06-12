//
//  ARNorthStar.m
//  BLE2
//
//  Created by Chenchen Zheng on 6/5/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARNorthStar.h"
#import "ARBLEConstants.h"

@implementation ARNorthStar

@synthesize measurementID = _measurementID;
@synthesize measurementTime = _measurementTime;
@synthesize measurementReceivedTime = _measurementReceivedTime;
@synthesize WSWeight = _WSWeight;
@synthesize units = _units;
@synthesize bmi = _bmi;

#pragma mark - private methods

-(id)initWithDevice:(ARDevice *)device
{
  self = [super init];
  if (self) {
    self.activePeripheral = device.activePeripheral;
    self.CM = device.CM;
    self.peripherials = device.peripherials;
    self.delegate = device.delegate;
  }
  return self;
}

- (void)readMeasurement
{
  NSLog(@"AR readMeasurment");
  [self notification:[CBUUID UUIDWithString:ARService]
  characteristicUUID:[CBUUID UUIDWithString:ARNotify]
                   p:self.activePeripheral
                  on:YES];
}

- (void) pair
{
  
}

@end


