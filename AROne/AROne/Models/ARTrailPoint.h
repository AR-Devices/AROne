//
//  ARTrailPoint.h
//  AROne
//
//  Created by Chenchen Zheng on 6/12/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARTrailPoint : NSObject

@property NSDate *time;
@property NSString *data_validity;


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
@end
