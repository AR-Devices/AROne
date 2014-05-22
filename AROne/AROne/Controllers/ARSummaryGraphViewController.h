//
//  ARSummaryFunctionGraphViewController.h
//  AROne
//
//  Created by Jerry Wu on 9/10/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARSummaryGraphCell.h"
#import "JBBaseChartViewController.h"


@interface ARSummaryGraphViewController : JBBaseChartViewController
@property(atomic) ARSummaryGraphCellStyle graphStyle;
@property(atomic) NSDate *selectedDate;
@property (strong, nonatomic) NSMutableArray *ArrayOfValues;
@property (strong, nonatomic) NSMutableArray *ArrayOfDates;

- (void) setFunctionStyle: (ARSummaryGraphCellStyle) style;
@end
