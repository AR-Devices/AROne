//
//  Location.h
//  tracker
//
//  Created by Chenchen Zheng on 12/18/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * hAccuracy;
@property (nonatomic, retain) NSNumber * speed;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSNumber * altitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * vAccuracy;
@property (nonatomic, retain) NSNumber * course;
@property (nonatomic, retain) NSNumber * latitude;

@end
