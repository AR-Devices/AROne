//
//  ARDevice.m
//  AROne
//
//  Created by Chenchen Zheng on 2/12/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARDevice.h"

@implementation ARDevice

- (id) initWithData:(NSData *)data
{
  return [self initWithBytes:[data bytes] andLength:[data length]];
}


- (id) initWithData:(NSData *)data atOffset:(NSUInteger)offset
{
  return [self initWithBytes:([data bytes] + offset) andLength:([data length] - offset)];
}

- (id) initWithBytes:(const void *)bytes andLength:(NSUInteger)length
{
  const char *ptr = bytes;
  
  if(ptr && (length >= 2))
  {
    self.deviceID = (ptr[0] & 0xff) | ((ptr[1] & 0xff) << 8);
    
    switch(self.deviceID)
    {
      case ARDeviceIDHeavenly001:
        self.deviceType = ARDeviceGoggle;
        break;
      case ARDeviceIDNorthstar001:
        self.deviceType = ARDeviceWearable;
        break;
      default:
        NSLog(@"Unrecognised device type 0x%x", (unsigned int) self.deviceID);
        self = nil;
        break;
    }
  }
  else
  {
    self = nil;
  }
  return self;
}

- (NSString *)deviceName
{
  switch(self.deviceType)
  {
    case ARDeviceGoggle:
      return @"Goggle";
      break;
      
    case ARDeviceWearable:
      return @"Wearable";
      break;
  }
  return @"Unknown";
}

+ (id) withData:(NSData *)data
{
  return [[ARDevice alloc] initWithData:data];
}

+ (id) withData:(NSData *)data atOffset:(NSUInteger)offset
{
  return [[ARDevice alloc] initWithData:data atOffset:offset];
}

+ (id) withBytes:(const void *)bytes andLength:(NSUInteger)length
{
  return [[ARDevice alloc] initWithBytes:bytes andLength:length];
}

@end
