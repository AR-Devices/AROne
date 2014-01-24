//
//  ARSummaryCell.h
//  style
//
//  Created by Chenchen Zheng on 8/24/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IPHONE_WIDTH                  ((int) 312)
#define SECTION_CELL_X_LEFT_MARGIN    ((int) 6)
#define SECTION_CELL_WIDTH            ((int) 308)
#define SECTION_CELL_X_HEIGHT         ((int) 108)

//gloabal defination

typedef NS_ENUM(NSInteger, ARSummaryCellStyle) {
  ARSummaryCellStyleMaxSpeed,
  ARSummaryCellStyleVerticalDrop,
  ARSummaryCellStyleAcceleration
};

@interface ARSummaryCell : UITableViewCell

@property (nonatomic, strong) UIView* cellView;
@property (nonatomic, strong) UIImageView* strip;
@property (nonatomic, strong) UIImageView* cellViewTitle;
@property (nonatomic, strong) UIImageView* unit;
@property (nonatomic, strong) UILabel* number;

+ (ARSummaryCell *)cellWithStyle:(ARSummaryCellStyle)ARSummaryCellStyle andValue:(NSString *)value;


@end
