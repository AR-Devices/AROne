//
//  ARHeader.m
//  AROne
//
//  Created by Chenchen Zheng on 2/12/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARHeader.h"

@implementation ARHeader

- (id) initWithData:(NSData *)data
{
  return [self initWithBytes:[data bytes] andLength:[data length]];
}

- (id) initWithData:(NSData *)data atOffset:(NSUInteger)offset
{
  return [self initWithBytes:([data bytes] + offset) andLength:([data length] - offset)];
}

//main function, initWithData: and initWithData:atOffset: uses it
//- (id) initWithBytes:(const void *)bytes andLength:(NSUInteger)len
- (id) initWithBytes:(const uint8_t *)bytes andLength:(NSUInteger)len
{
  //const unsigned char *ptr = bytes;
  const uint8_t *ptr = bytes;
  //header is 60 bytes
  if(ptr && (len >= 60))
  {
    //alwasy equal to 2
    NSUInteger packetType = (ptr[0] & 0xff) | ((ptr[1] & 0xff) << 8);
    
    if(packetType == 0x02)
    {
      ptr += 2;
      self.length = (ptr[0] & 0xff)            |
      ((ptr[1] & 0xff) << 8)     |
      ((ptr[2] & 0xff) << 16)    |
      ((ptr[3] & 0xff) << 24);
      ptr += 4;
      
      self.device = [ARDevice withBytes:ptr andLength:2];
      
      ptr += 3; // one extra for Flag byte
      
      NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
      
      NSDateComponents *date1 = [[NSDateComponents alloc] init];
      date1.year = (ptr[0] & 0xff) | ((ptr[1] & 0xff) << 8);
      date1.month = ptr[2];
      date1.day = ptr[3];
      date1.hour = ptr[4];
      date1.minute = ptr[5];
      date1.second = ptr[6];
      self.measurementDate = [gregorian dateFromComponents:date1];

      ptr += 7;
      
      
      self.bluetoothID = [NSData dataWithBytes:ptr length:6];
      
      ptr += 6;
      
      NSMutableData *d = [NSMutableData dataWithBytes:ptr length:6];
      
      ptr += 6;
      
      NSData *tmp = [NSData dataWithBytes:ptr length:12];
      self.serialNumber =[[NSString alloc] initWithData:tmp encoding:NSUTF8StringEncoding];
      ptr += 12;
      
      NSData *d2 = [NSData dataWithBytes:ptr length:10];
      [d appendData:d2];
      self.deviceName = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
      
      ptr += 10;
      
      float f;
      
      if(self.device.deviceType == ARDeviceGoggle)
      {
        f = ((float)ptr[0]) * 0.03 + 2.3;
      }
      else
      {
        f = ((float)ptr[0]) * 0.02 + 1.9;
      }
      
      self.batteryVoltage = [NSNumber numberWithFloat:f];
      
      ptr += 2;
      
      self.firmwareVersion = ptr[0] >> 5;
      self.hardwareVersion = ptr[0] & 7;
    }
    else
    {
      self = nil;
    }
  }
  else
  {
    self = nil;
  }
  return self;
}


//Class Method for other fundction to use
+ (id) withData:(NSData *)data
{
  return [[ARHeader alloc] initWithData:data];
}

+ (id) withData:(NSData *)data atOffset:(NSUInteger)offset
{
  return [[ARHeader alloc] initWithData:data atOffset:offset];
}

+ (id) withBytes:(const void *)bytes andLength:(NSUInteger)length
{
  return [[ARHeader alloc] initWithBytes:bytes andLength:length];
}

@end
