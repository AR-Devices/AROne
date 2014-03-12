//
//  ARSummaryFunctionGraphCell.m
//  AROne
//
//  Created by Jerry Wu on 9/10/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "ARSummaryGraphCell.h"
#import "drawGraph.h"
#import "touchView.h"

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

- (void)setThemeWithStyle:(ARSummaryGraphCellStyle) style andValues:(NSArray *)values{
  self.cellView = [[UIView alloc] initWithFrame:CGRectMake(SECTION_CELL_LEFT_MARGIN, 0, self.bounds.size.width-SECTION_CELL_LEFT_MARGIN*2, self.bounds.size.height/4)];
  drawGraph *myGraph = [[drawGraph alloc] initWithFrame:CGRectMake(0, 0, SECTION_CELL_WIDTH, SECTION_CELL_HEIGHT)];
  touchView *myTouchView = [[touchView alloc] initWithFrame:CGRectMake(0, 0, SECTION_CELL_WIDTH, SECTION_CELL_HEIGHT)];

//  self.cellView.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0];
  myGraph.data = values;
  myTouchView.data = values;
  myTouchView.backgroundColor = [UIColor clearColor];
//  NSLog(@"myGraph.data is %@", myGraph.data);
  UIImageView *functionGraphView;
  UIColor *purpleColor   = [UIColor colorWithRed:161/255.0f green:138/255.0f blue:193/255.0f alpha:1];
  UIColor *neonblueColor = [UIColor colorWithRed:47/255.0f green:179/255.0f blue:182/255.0f alpha:1];
  UIColor *orangeColor   = [UIColor colorWithRed:238/255.0f green:150/255.0f blue:47/255.0f alpha:1];
  
  switch (style) {
    case ARSummaryGraphCellStyleMaxSpeed:
      myGraph.isVolumeGraph = FALSE;
      myGraph.localColor = purpleColor;
      myTouchView.dataType = speedData;

//      myGraph.backgroundColor = [UIColor whiteColor];
//[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"profile_hp"]];
      myGraph.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"graph_bg2"]];

      [self.cellView addSubview:myGraph];
      [self.cellView addSubview:myTouchView];
      [self.contentView addSubview:self.cellView];      
      break;
      
    case ARSummaryGraphCellStyleVerticalDrop:
      myGraph.isVolumeGraph = TRUE;
      myGraph.localColor = neonblueColor;
      myTouchView.dataType = vDropData;

//      myGraph.backgroundColor = [UIColor whiteColor];
      myGraph.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"element3"]];
      [self.cellView addSubview:myGraph];
      [self.cellView addSubview:myTouchView];
      [self.contentView addSubview:self.cellView];
      [self reloadInputViews];
      break;
    case ARSummaryGraphCellStyleAcceleration:
      myGraph.isVolumeGraph = FALSE;
      myGraph.localColor = orangeColor;
      myTouchView.dataType = accelerationData;
      
      [self.cellView addSubview:myGraph];
      [self.cellView addSubview:myTouchView];
      [self.contentView addSubview:self.cellView];
      break;

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

+ (ARSummaryGraphCell *)cellWithStyle:(ARSummaryGraphCellStyle)styles andValues:(NSArray *)values
{
  ARSummaryGraphCell *cell = [[ARSummaryGraphCell alloc]init];
  [cell setThemeWithStyle:styles andValues:values];
  return cell;
}


@end
