//
//  ARSummaryFunctionGraphCell.m
//  AROne
//
//  Created by Jerry Wu on 9/10/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "ARSummaryGraphCell.h"
#import "drawGraph.h"

@implementation ARSummaryGraphCell
@synthesize cellView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 * @desc draw out gerenal view of the Summary Cell
 * @param string $msg - the message to be displayed
 * @return configured cellView
 */

- (void)setThemeWithStyle:(ARSummaryGraphCellStyle) style andValue:(NSString *)value
{
  self.cellView = [[UIView alloc] initWithFrame:CGRectMake(SECTION_CELL_LEFT_MARGIN, 0, SECTION_CELL_WIDTH, SECTION_CELL_HEIGHT)];
  drawGraph *myGraph = [[drawGraph alloc] initWithFrame:CGRectMake(0, 0, SECTION_CELL_WIDTH, SECTION_CELL_HEIGHT)];
//  self.cellView.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0];
  UIImageView *functionGraphView;
  UIColor *purpleColor   = [UIColor colorWithRed:161/255.0f green:138/255.0f blue:193/255.0f alpha:1];
  UIColor *neonblueColor = [UIColor colorWithRed:47/255.0f green:179/255.0f blue:182/255.0f alpha:1];
  UIColor *orangeColor   = [UIColor colorWithRed:238/255.0f green:150/255.0f blue:47/255.0f alpha:1];
  
  switch (style) {
    case ARSummaryGraphCellStyleMaxSpeed:
      myGraph.isVolumeGraph = TRUE;
      myGraph.localColor = purpleColor;
      
      myGraph.backgroundColor = [UIColor whiteColor];//[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"profile_hp"]];
      myGraph.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"graph_bg2"]];

      [self.cellView addSubview:myGraph];
      [self.contentView addSubview:self.cellView];
      
      break;
      
    case ARSummaryGraphCellStyleVerticalDrop:
      myGraph.isVolumeGraph = FALSE;
      myGraph.localColor = neonblueColor;
//      myGraph.backgroundColor = [UIColor whiteColor];
      myGraph.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"element3"]];
      [self.cellView addSubview:myGraph];
      [self.contentView addSubview:self.cellView];
      break;
    case ARSummaryGraphCellStyleAcceleration:

      break;
//      ccz: draw here
    default:
      break;
  }
  [self.cellView addSubview:functionGraphView];
  [self.contentView addSubview:self.cellView];
  
}

/**
 * @desc draw out gerenal view of the Summary Cell
 * @param string $msg - the message to be displayed
 * @return configured cellView
 */

+ (ARSummaryGraphCell *)cellWithStyle:(ARSummaryGraphCellStyle)styles andValue:(NSString *)value
{
  ARSummaryGraphCell *cell = [[ARSummaryGraphCell alloc]init];
  [cell setThemeWithStyle:styles andValue:value];
  return cell;
}


@end
