//
//  ARScoreBoardCell.h
//  AROne
//
//  Created by Chenchen Zheng on 9/7/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IPHONE_WIDTH                  ((int) 312)
#define SECTION_CELL_X_LEFT_MARGIN    ((int) 6)
#define SECTION_CELL_WIDTH            ((int) 308)
#define SECTION_CELL_X_HEIGHT         ((int) 108)

typedef NS_ENUM(NSInteger, ARScoreBoardCellStyle) {
  ARScoreBoardCellStyleMaxSpeed,
  ARScoreBoardCellStyleVerticalDrop,
  ARScoreBoardCellStyleAcceleration
};
typedef NS_ENUM(NSInteger, ARRankStyle) {
  ARGold,
  ARSilver,
  ARBronze,
  ARNormal
};
@interface ARScoreBoardCell : UITableViewCell

@property (nonatomic, strong) UIView* cellView;
@property (nonatomic, strong) UIView* nameAndIcon;
@property (nonatomic, weak) UILabel* number;

+ (ARScoreBoardCell *)cellWithStyle:(ARScoreBoardCellStyle)style rank: (ARRankStyle) rank andData: (NSDictionary *)data;

//+ (ARScoreBoardCell *)cellWithStyle:(ARScoreBoardCellStyle)style andWho:(NSString* )who andValue:(NSString *)value andRank:(ARRankStyle) rank;

@end
