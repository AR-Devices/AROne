//
//  Location+CoreData.m
//  tracker
//
//  Created by Chenchen Zheng on 12/18/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "Location+CoreData.h"

@implementation Location (CoreData) 

+ (Location *)saveLocation:(CLLocation *)info inManagedObjectContext:(NSManagedObjectContext *)context {
    Location *location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:context];
    location.hAccuracy = [NSNumber numberWithDouble:info.horizontalAccuracy];
    location.speed = [NSNumber numberWithDouble:info.speed];
    location.timestamp = info.timestamp;
    location.altitude = [NSNumber numberWithDouble:info.altitude];
    location.longitude = [NSNumber numberWithDouble:info.coordinate.longitude];
    location.vAccuracy = [NSNumber numberWithDouble:info.verticalAccuracy];
    location.course = [NSNumber numberWithDouble:info.course];
    location.latitude = [NSNumber numberWithDouble:info.coordinate.latitude];
    
    return location;
}

+ (CLLocation *)convert2CLLocation: (Location *) loc {
    CLLocationCoordinate2D locCoordinate = CLLocationCoordinate2DMake([loc.latitude doubleValue], [loc.longitude doubleValue]);
    CLLocation *location = [[CLLocation alloc] initWithCoordinate:locCoordinate altitude:[loc.altitude doubleValue]  horizontalAccuracy:[loc.hAccuracy doubleValue] verticalAccuracy:[loc.vAccuracy doubleValue] course:[loc.course doubleValue] speed:[loc.speed doubleValue] timestamp:loc.timestamp];
    return location;
}
@end
