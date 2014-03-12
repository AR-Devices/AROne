//
//  drawGraph.h
//  AROne
//
//  Created by Jerry Wu on 10/2/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GraphDataSource
- (NSInteger)graphViewDataCount;
- (NSArray *)graphViewData;
@optional
- (NSInteger)graphViewMax;
- (NSInteger)graphViewMin;

@end


@interface drawGraph : UIView
@property(nonatomic) BOOL isVolumeGraph;
@property(nonatomic, strong) UIColor * localColor;
@property(nonatomic) BOOL useTouch;
@property(atomic) NSArray *data;
@property (nonatomic, weak) id<GraphDataSource> dataSource;


@end
