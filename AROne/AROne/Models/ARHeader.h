//
//  ARHeader.h
//  AROne
//
//  Created by Chenchen Zheng on 2/12/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARDevice.h"

@interface ARHeader : NSObject

@property (nonatomic, assign) NSUInteger length;
@property (nonatomic, strong) ARDevice *device;
@property (nonatomic, strong) NSDate *measurementDate;
@property (nonatomic, strong) NSData *bluetoothID;
@property (nonatomic, strong) NSString *deviceName;
@property (nonatomic, strong) NSString *serialNumber;
@property (nonatomic, strong) NSNumber *batteryVoltage;
@property (nonatomic, assign) NSUInteger firmwareVersion;
@property (nonatomic, assign) NSUInteger hardwareVersion;

- (id) initWithData:(NSData *)data;
- (id) initWithData:(NSData *)data atOffset:(NSUInteger)offset;
//- (id) initWithBytes:(const void *)bytes andLength:(NSUInteger)length;
- (id) initWithBytes:(const uint8_t *)bytes andLength:(NSUInteger)length;


+ (id) withData:(NSData *)data;
+ (id) withData:(NSData *)data atOffset:(NSUInteger)offset;
+ (id) withBytes:(const void *)bytes andLength:(NSUInteger)length;

@end
