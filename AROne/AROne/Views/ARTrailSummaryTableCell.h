//
//  ARTrailSummaryTableCell.h
//  AROne
//
//  Created by Jerry Wu on 2/17/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IPHONE_WIDTH                  ((int) 312)
#define SECTION_CELL_X_LEFT_MARGIN    ((int) 6)
#define SECTION_CELL_WIDTH            ((int) 308)
#define SECTION_CELL_X_HEIGHT         ((int) 108)

typedef NS_ENUM(NSInteger, ARTrailSummaryCellStyle) {
  ARTralSummaryCellStyle1,
  ARTralSummaryCellStyle2,
  ARTralSummaryCellStyle3
};
@interface ARTrailSummaryTableCell : UITableViewCell
//@property (nonatomic, strong) UIView* cellView;
//@property (nonatomic, strong) UIImageView* strip;
//@property (nonatomic, strong) UIImageView* cellViewTitle;
//@property (nonatomic, strong) UIImageView* unit;
//@property (nonatomic, strong) UILabel* number;

+ (ARTrailSummaryTableCell *)cellWithStyle:(ARTrailSummaryCellStyle)styles andTrail:(NSString *)trail andValue:(NSString *)value andValue2:(NSString *)value2 rect:(CGRect) rect;

@end
