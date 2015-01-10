//
//  ARTrailSummaryMapViewController.h
//  AROne
//
//  Created by Jerry Wu on 2/10/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARTrailSummaryMapViewController : UIViewController
- (id)initWithMap:(UIImage*) map;
//+ (NSString* ) trailPathViewData: (float) eva and: (float) longitude and: (float) latitude;
+ (NSInteger) get_distance: (NSArray*) user user_index: (int) u_index : (NSArray*) trail : (int) trail_index;
+(NSArray*) calculate_trail: (float) eva and: (float) longitude and: (float) latitude;
@end
