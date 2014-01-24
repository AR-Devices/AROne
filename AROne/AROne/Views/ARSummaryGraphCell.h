//
//  ARSummaryFunctionGraphCell.h
//  AROne
//
//  Created by Jerry Wu on 9/10/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IPHONE_WIDTH                  ((int) 312)
#define SECTION_CELL_LEFT_MARGIN    ((int) 6)
#define SECTION_CELL_WIDTH            ((int) 308)
#define SECTION_CELL_HEIGHT         ((int) 180)

typedef NS_ENUM(NSInteger, ARSummaryGraphCellStyle) {
  ARSummaryGraphCellStyleMaxSpeed,
  ARSummaryGraphCellStyleVerticalDrop,
  ARSummaryGraphCellStyleAcceleration
};

@interface ARSummaryGraphCell : UITableViewCell
@property (nonatomic, strong) UIView* cellView;



+ (ARSummaryGraphCell *)cellWithStyle:(ARSummaryGraphCellStyle)ARSummaryCellStyle andValue:(NSString *)value;
@end
