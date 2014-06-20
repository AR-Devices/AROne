//
//  ARTrailPoint.m
//  AROne
//
//  Created by Chenchen Zheng on 6/12/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

//      Data received from BLE:
//      30353235 414e3337 32323432
//      39355731 32313532 34363635
//      30303130 36303631 34303032
//      36333131 35ffffff ffffffff
//
//      Parsed data:
//      0x30('0')	hour_1;
//      0x35('5')	hour_2;
//      0x32('2') minute_1;
//      0x35('5')	minute_2;
//      0x41('A')	data_validity;
//      0x4E('N')	latitude_direction;
//      0x33		latitude_degree_1;
//      0x37		latitude_degree_2;
//      0x32		latitude_min_int_1;
//      0x32		latitude_min_int_2;
//      0x34		latitude_min_dec_1;
//      0x32		latitude_min_dec_2;

//      0x39		latitude_min_dec_3;
//      0x35		latitude_min_dec_4;
//      0x57('W')	longitude_direction;
//      0x31		longitude_degree_1;
//      0x32		longitude_degree_2;
//      0x31		longitude_degree_3;
//      0x35		longitude_min_int_1;
//      0x32		longitude_min_int_2;
//      0x34		longitude_min_dec_1;
//      0x36		longitude_min_dec_2;
//      0x36		longitude_min_dec_3;
//      0x35		longitude_min_dec_4;

//      0x30		speed_int_1;
//      0x30		speed_int_2;
//      0x31		speed_dec_1;
//      0x30('0')	day_1;  Date: 6/6/14
//      0x36('6')	day_2;
//      0x30('0')	month_1;
//      0x36('6')	month_2;
//      0x31('1')	year_1;
//      0x34('4')	year_2;
//      0x30		altitude_int_1;
//      0x30		altitude_int_2;
//      0x32		altitude_int_3;

//      0x36		altitude_int_4;
//      0x33		altitude_dec;
//      0x31		bearing_int_1;
//      0x31		bearing_int_2;
//      0x35		bearing_int_3;
//      0xFF;
//      0xFF;
//      0xFF;
//      0xFF;
//      0xFF;
//      0xFF;
//      0xFF;
//
//      Data received from GPS:
//      $GPRMC,055916.000,A,3722.4285,N,12152.4687,W,0.11,10.67,200414,,,A*46
//      $GPGGA,055917.000,3722.4285,N,12152.4687,W,1,8,0.96,30.7,M,-25.5,M,,*5A
//      $GPGSV,2,2,08,05,28,146,23,04,27,047,26,29,24,281,23,24,23,205,19*75
//lat_degree/60+latitude (need to consider + - after calculation)
//int

#import "ARTrailPoint.h"
@interface ARTrailPoint()
@property int hour;
@property int minute;
@property int second;
@property int year;
@property int month;
@property int day;
@property CLLocationSpeed speed;
@property CLLocationDegrees latitude;
@property CLLocationDegrees longitude;
@property double lat_degree;
@property double long_degree;
@property int lat_direction;
@property int long_direction;
@property CLLocationDistance altitude;
@property CLLocationDirection direction;


@end

//$GPRMC,123519,A,4807.038,N,01131.000,E,022.4,084.4,230394,003.1,W*6A
//
//Where:
//RMC          Recommended Minimum sentence C
//123519       Fix taken at 12:35:19 UTC
//A            Status A=active or V=Void.
//4807.038,N   Latitude 48 deg 07.038' N
//01131.000,E  Longitude 11 deg 31.000' E
//022.4        Speed over the ground in knots
//084.4        Track angle in degrees True
//230394       Date - 23rd of March 1994
//003.1,W      Magnetic Variation
//*6A          The checksum data, always begins with *

@implementation ARTrailPoint

- (id)init {
  self = [super init];
  
  return self;
}

- (void)segment0:(NSData *)data
{
  NSLog(@"parse segment0");
  NSString *hour =[[NSString alloc]initWithBytes:[[data subdataWithRange:NSMakeRange(0,2)]bytes]length:2 encoding:NSASCIIStringEncoding];
  self.hour = [hour intValue];
  NSLog(@"hour is %d",self.hour);
  NSString *minute =[[NSString alloc] initWithBytes:[[data subdataWithRange:NSMakeRange(2,2)] bytes] length:2 encoding:NSASCIIStringEncoding];
  self.minute = [minute intValue];
  NSLog(@"minute is %d",self.minute);
  self.data_validity =[[NSString alloc] initWithBytes:[[data subdataWithRange:NSMakeRange(4,1)] bytes] length:1 encoding:NSASCIIStringEncoding];
  NSLog(@"data_validity is %@",self.data_validity);
  NSString *latitude_direction =[[NSString alloc] initWithBytes:[[data subdataWithRange:NSMakeRange(5,1)] bytes] length:1 encoding:NSASCIIStringEncoding];
  if ([latitude_direction isEqualToString:@"S"]) {
    self.lat_direction = -1;
  } else {
    self.lat_direction = 1;
  }
  NSLog(@"latitude_direction is %@", latitude_direction);
  
  NSString *latitude_degree =[[NSString alloc] initWithBytes:[[data subdataWithRange:NSMakeRange(6,2)] bytes] length:2 encoding:NSASCIIStringEncoding];

  self.latitude = [latitude_degree doubleValue];
  NSLog(@"latitude_degree is %f", self.latitude);
  NSString *latitude_min_int = [[NSString alloc] initWithBytes:[[data subdataWithRange:NSMakeRange(8,2)] bytes] length:2 encoding:NSASCIIStringEncoding];
  self.lat_degree = [latitude_min_int intValue];
  NSLog(@"latitude_min_int is %d",  [latitude_min_int intValue]);
  NSString *latitude_min_dec_12 =  [[NSString alloc] initWithBytes:[[data subdataWithRange:NSMakeRange(10,2)] bytes] length:2 encoding:NSASCIIStringEncoding];
  self.lat_degree += [latitude_min_dec_12 doubleValue]/100;
  NSLog(@"latitude_min_dec_12 is %f", self.lat_degree);
}

- (void)segment1:(NSData *)data
{
  NSLog(@"parse segment1");
  NSString *latitude_min_dec_34 =  [[NSString alloc] initWithBytes:[[data subdataWithRange:NSMakeRange(0,2)] bytes] length:2 encoding:NSASCIIStringEncoding];
  self.lat_degree += [latitude_min_dec_34 doubleValue]/10000;
  self.lat_degree /= 60;
  self.latitude += self.lat_degree;
  self.latitude *= self.lat_direction;
  
  NSLog(@"latitude_min_dec_34 is %f", self.lat_degree);
  NSString *longitude_direction = [[NSString alloc]initWithBytes:[[data subdataWithRange:NSMakeRange(2,1)]bytes]length:1 encoding:NSASCIIStringEncoding];
  if ([longitude_direction isEqualToString:@"W"]) {
    self.long_direction = -1;
  } else {
    self.long_direction = 1;
  }
  NSLog(@"longitude_direction is %@", longitude_direction);
  NSString *longitude_degree = [[NSString alloc]initWithBytes:[[data subdataWithRange:NSMakeRange(3,3)]bytes]length:3 encoding:NSASCIIStringEncoding];
  self.longitude = [longitude_degree doubleValue];
  NSLog(@"longitude_degree is %f", self.longitude);
  NSString *longitude_min_int = [[NSString alloc]initWithBytes:[[data subdataWithRange:NSMakeRange(6,2)]bytes]length:2 encoding:NSASCIIStringEncoding];
  self.long_degree = [longitude_min_int intValue];
  NSLog(@"longitude_min_int is %f", self.long_degree);
  NSString *longitude_min_dec = [[NSString alloc]initWithBytes:[[data subdataWithRange:NSMakeRange(8,4)]bytes]length:4 encoding:NSASCIIStringEncoding];
  self.long_degree += [longitude_min_dec doubleValue]/10000;
  NSLog(@"longitude_min_dec is %@", longitude_min_dec);
  self.long_degree /= 60;
  self.longitude += self.long_degree;
  self.longitude *= self.long_direction;
  
  NSLog(@"longitude is %f", self.longitude);
  NSLog(@"latitude is %f", self.latitude);
  
  
}

- (void)segment2:(NSData *)data
{
    NSLog(@"parse segment2");
  NSString *speed =[[NSString alloc]initWithBytes:[[data subdataWithRange:NSMakeRange(0,2)]bytes]length:2 encoding:NSASCIIStringEncoding];
  self.speed = [speed doubleValue] * 0.5144; // convert to meter per second
  NSLog(@"speed is %@", speed);
  NSLog(@"speed in double is %f", self.speed);
  NSString *speed_dec =[[NSString alloc]initWithBytes:[[data subdataWithRange:NSMakeRange(2,1)]bytes]length:1 encoding:NSASCIIStringEncoding];
  self.speed += [speed_dec doubleValue]/10;
  NSString *day =[[NSString alloc]initWithBytes:[[data subdataWithRange:NSMakeRange(3,2)]bytes]length:2 encoding:NSASCIIStringEncoding];
  self.day = [day intValue];
  NSString *month =[[NSString alloc]initWithBytes:[[data subdataWithRange:NSMakeRange(5,2)]bytes]length:2 encoding:NSASCIIStringEncoding];
  self.month = [month intValue];
  NSString *year =[[NSString alloc]initWithBytes:[[data subdataWithRange:NSMakeRange(7,2)]bytes]length:2 encoding:NSASCIIStringEncoding];
  self.year = [year intValue];
  NSString *altitude_int_123 =[[NSString alloc]initWithBytes:[[data subdataWithRange:NSMakeRange(9,3)]bytes]length:3 encoding:NSASCIIStringEncoding];
  self.altitude = [altitude_int_123 doubleValue] * 10;
}

- (void)segment3:(NSData *)data
{
  NSLog(@"parse segment3");
  NSString *altitude_int_4 =[[NSString alloc]initWithBytes:[[data subdataWithRange:NSMakeRange(0,1)]bytes]length:1 encoding:NSASCIIStringEncoding];
  self.altitude += [altitude_int_4 doubleValue];
  NSString *altitude_dec =[[NSString alloc]initWithBytes:[[data subdataWithRange:NSMakeRange(1,1)]bytes]length:1 encoding:NSASCIIStringEncoding];
  self.altitude += [altitude_dec doubleValue]/10;
  NSLog(@"altitude is %f", self.altitude);
  NSString *bearing_int =[[NSString alloc]initWithBytes:[[data subdataWithRange:NSMakeRange(2,3)]bytes]length:3 encoding:NSASCIIStringEncoding];
  self.direction = [bearing_int intValue];
  NSLog(@"direction is %f", self.direction);
  [self parse];
}

- (NSString *) headingDirection: (int )bearing
{
  if (bearing >= 0 && bearing <= 15) {
    return @"N";
  } else if (bearing > 15 && bearing < 75) {
    return @"NE";
  } else if (bearing >= 75 && bearing <= 105) {
    return @"E";
  } else if (bearing > 105 && bearing < 165) {
    return @"SE";
  } else if (bearing >= 165 && bearing <= 195) {
    return @"S";
  } else if (bearing > 195 && bearing < 255) {
    return @"SW";
  } else if (bearing >= 255 && bearing <= 285) {
    return @"W";
  } else if (bearing > 285 && bearing < 345) {
    return @"NW";
  } else {
    return @"N";
  }
}

- (void)parse
{
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
  NSString *date = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d", self.year, self.month, self.day, self.hour, self.minute, self.second];
  NSLog(@"date is %@", date);
  self.time = [df dateFromString: date];
  CLLocationCoordinate2D location = CLLocationCoordinate2DMake(self.latitude, self.longitude);
  self.location = [[CLLocation alloc] initWithCoordinate:location altitude:self.altitude horizontalAccuracy:0 verticalAccuracy:0 course:self.direction speed:self.speed timestamp:self.time];
//  self.location = [[CLLocation alloc] initWithCoordinate:location altitude:self.altitude horizontalAccuracy:0 verticalAccuracy:0 timestamp:self.time];
  NSLog(@"location is %@", self.location);
}




@end
