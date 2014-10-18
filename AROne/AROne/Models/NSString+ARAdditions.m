//
//  NSString+ARAdditions.m
//  AROne
//
//  Created by Chenchen Zheng on 10/18/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "NSString+ARAdditions.h"

@implementation NSString (ARAdditions)

+ (BOOL)isStringEmpty:(NSString *)string {
    if([string length] == 0 ||
       [string isEqualToString:@""]) { //string is empty or nil
        return YES;
    }
    
    if(![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        //string is all whitespace
        return YES;
    }
    
    return NO;
}

@end
