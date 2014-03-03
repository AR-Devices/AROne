//
//  ARCommon.h
//  AROne
//
//  Created by Chenchen Zheng on 2/13/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#define A2H(n) (((n) - 48) & ~32) - (((n) > '9') ? 7 : 0)
#define HEX8(ptr) (((A2H(*(ptr))) << 4) | (A2H(*((ptr)+1))))

@interface ARCommon : NSObject 

+ (NSString *) today;

@end
