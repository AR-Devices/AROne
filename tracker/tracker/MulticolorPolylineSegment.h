//
//  MulticolorPolylineSegment.h
//  tracker
//
//  Created by Chenchen Zheng on 12/18/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Location.h"
#import "Location+CoreData.h"

@interface MulticolorPolylineSegment : MKPolyline

@property (strong, nonatomic) UIColor *color;
+ (NSArray *)colorSegmentsForLocations:(NSArray *)locations;

@end
