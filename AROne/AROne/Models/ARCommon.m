//
//  ARCommon.m
//  AROne
//
//  Created by Chenchen Zheng on 3/2/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARCommon.h"
#import "ARSummary.h"
#import "ARDataPoint.h"

@implementation ARCommon

+ (NSString *) today {
  NSDate *date = [NSDate new];
  [date descriptionWithLocale:[NSLocale systemLocale]];
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  NSLog(@"formatter date is %@", [dateFormatter stringFromDate:date]);
//  NSLog(@"date is %@", [date descriptionWithLocale:[NSLocale systemLocale]]);
  
  return [dateFormatter stringFromDate:date];
}

+ (NSString *) selectedDate: (NSDate *)date
{
  [date descriptionWithLocale:[NSLocale systemLocale]];

  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  NSLog(@"formatter date is %@", [dateFormatter stringFromDate:date]);
  //  NSLog(@"date is %@", [date descriptionWithLocale:[NSLocale systemLocale]]);
  return [dateFormatter stringFromDate:date];
}
+ (NSString *) todayTime {
  NSDate *startDate = [NSDate date];
  NSLog(@"startDate is %@", startDate);
  
  NSDate *date = [NSDate new];
  [date descriptionWithLocale:[NSLocale systemLocale]];
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
  [dateFormatter setDateFormat:@"HH:mm:ss"];
  NSLog(@"todaytime is %@", [dateFormatter stringFromDate:date]);
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

+ (double) randomDouble {
  double r = (arc4random() % 100)/10;
  return r;
}

+ (int) randomVDrop {
  return arc4random() % 20000;
}

+ (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
  float diff = bigNumber - smallNumber;
  return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

+ (void)createSummaryClass:(NSDate *) date {
  
  ARSummary *measurement = [ARSummary object];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  measurement.displayName = [defaults valueForKey:@"userName"];
  NSLog(@"name is %@", measurement.displayName);

  measurement.date = [ARCommon selectedDate:date];
  measurement.maxAcceleration = [ARCommon randomFloatBetween:0.0 and:10.0];
  measurement.maxSpeed = [ARCommon randomFloatBetween:0.0 and:50.0];
  measurement.verticalDrop = [ARCommon randomVDrop];
  //  [measurement setPlayer:[PFUser currentUser]];
  measurement.player = [PFUser currentUser];
  PFACL *defaultACL = [PFACL ACL];
  // Optionally enable public read access while disabling public write access.
  [defaultACL setPublicReadAccess:YES];
  [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
  measurement.ACL = defaultACL;
  
  [measurement saveInBackground];
}

+ (void)createDataPoint:(int)size {
  NSLog(@"createDataPoint Called");
  NSMutableArray *dataArray = [NSMutableArray new];
  for (int i = 0 ; i < size; i++) {
    ARDataPoint *dp = [ARDataPoint object];
    dp.dateRecord = [ARCommon today];
    dp.timeRecord = [ARCommon todayTime];
    dp.acceleration = [ARCommon randomFloatBetween:0.0 and:10.0];
    dp.speed = [ARCommon randomFloatBetween:0.0 and:50.0];
    dp.verticalDrop = [ARCommon randomVDrop];
    dp.player = [PFUser currentUser];
    // Optionally enable public read access while disabling public write access.
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    dp.ACL = defaultACL;
    [dataArray addObject:dp];
  }

  [PFObject saveAll:dataArray];
}

+(UIImage*) drawImage:(UIImage*) fgImage
              inImage:(UIImage*) bgImage
              atPoint:(CGPoint)  point
{
  UIGraphicsBeginImageContextWithOptions(bgImage.size, FALSE, 0.0);
  [bgImage drawInRect:CGRectMake( 0, 0, bgImage.size.width, bgImage.size.height)];
  [fgImage drawInRect:CGRectMake( point.x, point.y, fgImage.size.width, fgImage.size.height)];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return newImage;
}

@end
