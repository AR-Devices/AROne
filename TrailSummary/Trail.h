//
//  Trail.h
//  TrailSummary
//
//  Created by Chenchen Zheng on 12/16/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrailPoint.h"
@interface Trail : NSObject

@property (nonatomic) NSArray *trailPoints;

+ (NSString *) compareWith:(NSArray *)userTrailPoints;


@end
