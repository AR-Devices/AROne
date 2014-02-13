//
//  ARNorthStarReading.m
//  AROne
//
//  Created by Chenchen Zheng on 2/12/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARNorthStarReading.h"
#import "ARCommon.h"

@interface ARNorthStarReading()
//wenfeng data structure
@property (nonatomic) NSUInteger hour;
@property (nonatomic) NSUInteger minute;
@property (nonatomic) NSUInteger data_validity;
@property (nonatomic) NSUInteger latitude_direction;
@property (nonatomic) NSUInteger longitude_direction;
@property (nonatomic) NSUInteger speed_int;
@property (nonatomic) NSUInteger speed_dec;
@property (nonatomic) NSUInteger day;
@property (nonatomic) NSUInteger month;
@property (nonatomic) NSUInteger year;
@property (nonatomic) NSUInteger altitude_int;
@property (nonatomic) NSUInteger altitude_dec;

@end
@implementation ARNorthStarReading


- (id)initWithHeader:(ARHeader *)header andData:(NSMutableData *)data
{
  const u_int8_t bytes[2] = {0xEE, 0xEE};
  
  // a blood-pressure reading without an ID is the only reading that isn't CRLF
  // terminated; append an extra one just in case
  [data appendBytes:bytes length:2];
  
  NSData *pdu = [self dequeue:data minimum:24];//FIXME 24 could be wrong since there is no longtitude
  
  if(pdu)
  {
    const unsigned char *ptr = [pdu bytes];
    //what's header byte?
    if(*ptr++ == '8')
    {
      self.hour = HEX8(ptr);
      self.minute = HEX8(ptr+2);
      ptr = ptr+4;
      self.data_validity = *ptr++;
      self.latitude_direction = *ptr++;
      self.longitude_direction = *ptr++;
      self.speed_int = HEX8(ptr);
      self.speed_dec = HEX8(ptr+2);
      ptr = ptr+4;
      self.day = HEX8(ptr);
      self.month = HEX8(ptr + 2);
      self.year = HEX8(ptr + 4);
      ptr = ptr+6;
      
    }
    else
    {
      pdu = nil;
    }
  }
  
  if(!pdu)
  {
    self = nil;
  }
  return self;
}

- (bool) isValid
{
  return (self.validity == ARNorthStarReadingValid);
}

- (NSString *)toString
{
//  return [NSString stringWithFormat:@"%lu/%lu, %lu ppm, %lu map ", (unsigned long)self.systolic, (unsigned long)self.diastolic, (unsigned long)self.pulseRate, (unsigned long)self.meanArterialPressure];
  return nil;
}

@end
