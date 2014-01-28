//
//  trailPathView.h
//  TrailSummary
//
//  Created by Chenchen Zheng on 1/16/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class trailPathView;

@protocol trailPathSource <NSObject>
- (NSArray *)trailPathViewData:(trailPathView *)graphView;

@optional

@end


@interface trailPathView : UIView

@property (nonatomic, weak) id<trailPathSource> dataSource;

@end
