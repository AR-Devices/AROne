//
//  Location+CoreData.h
//  tracker
//
//  Created by Chenchen Zheng on 12/18/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "Location.h"
#import <MapKit/MapKit.h>

@interface Location (CoreData)
+ (Location *)saveLocation:(CLLocation *)info inManagedObjectContext:(NSManagedObjectContext *)context;
+ (CLLocation *)convert2CLLocation: (Location *) loc;
@end
