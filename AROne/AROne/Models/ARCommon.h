//
//  ARCommon.h
//  AROne
//
//  Created by Chenchen Zheng on 2/13/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#define A2H(n) (((n) - 48) & ~32) - (((n) > '9') ? 7 : 0)
#define HEX8(ptr) (((A2H(*(ptr))) << 4) | (A2H(*((ptr)+1))))

typedef NS_ENUM(NSUInteger, DataType) {
  speedData,
  accelerationData,
  vDropData
};

typedef NS_ENUM(NSUInteger, GraphType) {
  lineGraph,
  barGraph,
};

@interface ARCommon : NSObject 

+ (NSString *) today;
+ (double) randomDouble;
+ (int) randomVDrop;
+ (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber;
+ (void)createSummaryClass;
+ (NSString *) todayTime;
+ (void)createDataPoint:(int)size;
@end
