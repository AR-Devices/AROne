//
//  ARCommon.m
//  AROne
//
//  Created by Chenchen Zheng on 3/2/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARCommon.h"

@implementation ARCommon

+ (NSString *) today {
  
//  NSDateComponents *components = [[NSCalendar currentCalendar]
//                                  components:NSYearCalendarUnit|NSMonthCalendarUnit
//                                  fromDate:[NSDate date]];
//  NSDate *startDate = [[NSCalendar currentCalendar]
//                       dateFromComponents:components];
  NSDate *startDate = [NSDate date];
  NSLog(@"startDate is %@", startDate);
  
  NSDate *date = [NSDate new];
  [date descriptionWithLocale:[NSLocale systemLocale]];
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  NSLog(@"formatter date is %@", [dateFormatter stringFromDate:date]);
//  NSLog(@"date is %@", [date descriptionWithLocale:[NSLocale systemLocale]]);
  
  return [dateFormatter stringFromDate:date];
}

+ (NSString *) todayWithTime {
  
  //  NSDateComponents *components = [[NSCalendar currentCalendar]
  //                                  components:NSYearCalendarUnit|NSMonthCalendarUnit
  //                                  fromDate:[NSDate date]];
  //  NSDate *startDate = [[NSCalendar currentCalendar]
  //                       dateFromComponents:components];
  NSDate *startDate = [NSDate date];
  NSLog(@"startDate is %@", startDate);
  
  NSDate *date = [NSDate new];
  [date descriptionWithLocale:[NSLocale systemLocale]];
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
  [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
  NSLog(@"formatter date is %@", [dateFormatter stringFromDate:date]);
  //  NSLog(@"date is %@", [date descriptionWithLocale:[NSLocale systemLocale]]);
  
  return [dateFormatter stringFromDate:date];
}


@end
