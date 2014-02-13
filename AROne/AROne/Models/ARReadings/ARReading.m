//
//  ARReading.m
//  AROne
//
//  Created by Chenchen Zheng on 2/12/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARReading.h"

@implementation ARReading

-(id) init
{
  if((self = [super init]))
  {
  }
  return self;
}

-(id) initWithHeader:(ARHeader *)header andData:(NSMutableData *)data
{
  // override this
  return self;
}

// All AMReading classes are presented with a complete, reassembled PDU. ie the pdu
// data is present in its entirety, and we do not expect any additional bytes. A packet
// length exception therefore indicates a bytestream corruption, and we should remove
// as much data as is practical to return to a sane state.

// AMReadings expect a 'minimum' number of bytes in the stream to form a valid PDU. If
// a leading '\r\n' is found it is stripped, but minimum must still hold for the remaining data.

// The AMReading may consume more than minimum bytes from the stream; it will scan forwards
// up to and including the terminating '\r\n'. A byte-stream that is not '\r\n' terminated is
// therefore an error.

// If the bytestream is not '\r\n' terminated, all bytes are dropped.
// If the portion of the bytestream up to '\r\n' is not >minimum, it is dropped leaving the
// remaining data intact.
-(NSData *) dequeue:(NSMutableData *)stream minimum:(NSUInteger)min
{
  NSData *pdu = nil;
  NSRange r = NSMakeRange(0, 0);
  const uint8_t bytes[2] = {0xEE, 0xEE};
  NSData *ender = [NSData dataWithBytes:bytes length:sizeof(bytes)];
  
  if(stream)
  {
    if([stream length] >= 2)
    {
      r = [stream rangeOfData:ender options:NSDataSearchAnchored range:NSMakeRange(0, 2)];
    }
    
    if(r.length)
    {
      [stream replaceBytesInRange:NSMakeRange(0, 2) withBytes:nil length:0];
    }
    
    r = [stream rangeOfData:ender options:0 range:NSMakeRange(0, [stream length])];
    
    if(r.length)
    {
      r = NSMakeRange(0, r.location + 2);
      
      pdu = [stream subdataWithRange:r];
      
      if([pdu length] < min)
      {
        pdu = nil;
      }
    }
    else
    {
      // ditch everything
      r = NSMakeRange(0, [stream length]);
    }
    
    [stream replaceBytesInRange:r withBytes:nil length:0];
  }
  return pdu;
}

-(NSString *)toString
{
  return @"Override me AMReading";
}

//- (NSString *)toStringNoUnit
//{
//  return @"Overried me AMReading";
//}
//
//- (NSString *)toStringUnit
//{
//  return @"Overried me AMReading";
//}

+(id) withHeader:(ARHeader *)header andData:(NSMutableData *)data
{
  return [[self alloc] initWithHeader:header andData:data];
}

+(id) withHeader:(ARHeader *)header andBytes:(const void *)bytes andLength:(NSUInteger)length
{
  if(bytes && (length > 0))
  {
    return [[self alloc] initWithHeader:header andData:[NSMutableData dataWithBytes:bytes length:length]];
  }
  return nil;
}

@end
