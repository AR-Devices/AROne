//
//  ARDevice.h
//  AROne
//
//  Created by Chenchen Zheng on 2/12/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  ARDeviceGoggle,
  ARDeviceWearable
} ARDeviceType;


typedef enum {
  ARDeviceIDHeavenly001           = 0x0101,
  ARDeviceIDNorthstar001         = 0x02fe
} ARDeviceID;

@interface ARDevice : NSObject

@property (nonatomic, assign) ARDeviceID deviceID;
@property (nonatomic, assign) ARDeviceType deviceType;

- (id)initWithData:(NSData *)data;
- (id)initWithData:(NSData *)data atOffset:(NSUInteger)offset;
- (id)initWithBytes:(const void *)bytes andLength:(NSUInteger)length;

- (NSString *)deviceName;

+ (id)withData:(NSData *)data;
+ (id)withData:(NSData *)data atOffset:(NSUInteger)offset;
+ (id)withBytes:(const void *)bytes andLength:(NSUInteger)length;

@end
