//
//  ARSummaryFunctionGraphViewController.h
//  AROne
//
//  Created by Jerry Wu on 9/10/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARSummaryGraphCell.h"


@interface ARSummaryGraphViewController : UITableViewController
@property(atomic) ARSummaryGraphCellStyle graphStyle;
@property(atomic) NSDate *selectedDate;

- (void) setFunctionStyle: (ARSummaryGraphCellStyle) style;
@end
