//
//  ARReading.h
//  AROne
//
//  Created by Chenchen Zheng on 2/12/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARHeader.h"
@interface ARReading : NSObject

-(id) init;
-(NSString *)toString;
//-(NSString *)toStringNoUnit;
//-(NSString *)toStringUnit;
-(NSData *)dequeue:(NSMutableData *)data minimum:(NSUInteger)min;

-(id) initWithHeader:(ARHeader *)header andData:(NSMutableData *)data;

+(id) withHeader:(ARHeader *)header andData:(NSMutableData *)data;
+(id) withHeader:(ARHeader *)header andBytes:(const void *)bytes andLength:(NSUInteger)length;


@end
