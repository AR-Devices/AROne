//
//  ARUtility.h
//  ARTwo
//
//  Created by Chenchen Zheng on 10/2/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARUtility : NSObject

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *)resizeImage:(UIImage*)image withSize:(CGSize)newSize;

@end
