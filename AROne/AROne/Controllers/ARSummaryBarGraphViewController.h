//
//  ARSummaryBarGraphViewController.h
//  AROne
//
//  Created by Jerry Wu on 6/7/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARSummaryGraphCell.h"
#import "JBBaseChartViewController.h"
#import "JBConstants.h"

@interface ARSummaryBarGraphViewController : JBBaseChartViewController
@property(atomic) ARSummaryGraphCellStyle graphStyle;
@property(atomic) NSDate *selectedDate;
@property (strong, nonatomic) NSMutableArray *ArrayOfValues;
@property (strong, nonatomic) NSMutableArray *ArrayOfDates;

- (void) setFunctionStyle: (ARSummaryGraphCellStyle) style;
@end
