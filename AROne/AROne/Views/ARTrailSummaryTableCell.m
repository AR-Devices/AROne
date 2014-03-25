//
//  ARTrailSummaryTableCell.m
//  AROne
//
//  Created by Jerry Wu on 2/17/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARTrailSummaryTableCell.h"

@implementation ARTrailSummaryTableCell

//@synthesize cellView;
//@synthesize strip;
//@synthesize cellViewTitle;
//@synthesize number;

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

- (void)setThemeWithStyle:(ARTrailSummaryCellStyle) style andTrail:(NSString*)trail andValue:(NSString *)value andValue2:(NSString *)value2 andValue3:(NSString*)value3 rect:(CGRect) rect
{
  UIColor *bluetrailcolor  = [UIColor colorWithRed:15.0/255.0 green:118.0/255.0 blue:201.0/255.0 alpha:1.0];
  UIColor *greentrailcolor = [UIColor colorWithRed:4.0/255.0 green:149.0/255.0 blue:62.0/255.0 alpha:1.0];
  UIColor *fontcolor =[UIColor colorWithRed:67.0/255.0 green:67.0/255.0 blue:67.0/255.0 alpha:1.0];
  UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 200, 20)];
  title.text = trail;
  title.font = [UIFont fontWithName:@"Avenir-MediumOblique" size:11.0];

  
  UIImage * vdropImage_green = [UIImage imageNamed:@"trailsum_green"];//default
  UIImage * vdropImage_blue  = [UIImage imageNamed:@"trailsum_blue"];//default
  UIImage * vdropImage_black = [UIImage imageNamed:@"trailsum_black2"];//default

  UIImageView *vdropView_green = [[UIImageView alloc] initWithImage:vdropImage_green];
  UIImageView *vdropView_blue  = [[UIImageView alloc] initWithImage:vdropImage_blue];
  UIImageView *vdropView_black = [[UIImageView alloc] initWithImage:vdropImage_black];

  UIView *vdropViewFrame = [[UIButton alloc] initWithFrame:CGRectMake(20, 25,vdropImage_green.size.width, vdropImage_green.size.height)];

  UILabel *maxspeed = [[UILabel alloc] initWithFrame:CGRectMake(50+vdropImage_green.size.width, 20, 80, 30)];
  maxspeed.text = value;
  maxspeed.font = [UIFont fontWithName:@"Avenir-MediumOblique" size:33.0];
  
  UIImage *maxspeed_unit = [UIImage imageNamed:@"mph Max Speed"];
  UIImageView *maxspeedUnitView = [[UIImageView alloc] initWithImage:maxspeed_unit];
  maxspeedUnitView.frame = CGRectMake(20+vdropImage_green.size.width+80, 15, 76/1.9, 76/1.9);
  maxspeedUnitView.contentMode = UIViewContentModeScaleAspectFit;
  
  UILabel * vdrop_value = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, vdropImage_green.size.width, vdropImage_green.size.height-10)];
  vdrop_value.text = value2;
  vdrop_value.font = [UIFont fontWithName:@"Big Caslon" size:30.0];
  maxspeed.textColor = fontcolor;
  vdrop_value.textColor = fontcolor;
  
  UILabel* time_passed =[[UILabel alloc] initWithFrame:CGRectMake(20+vdropImage_green.size.width+80, 40, 76, 76/1.9)];
  time_passed.text = @"Time Passed";
  time_passed.textColor = fontcolor;
  time_passed.font =[UIFont fontWithName:@"Avenir-MediumOblique" size:9.0];
  UILabel *time_passed_value = [[UILabel alloc] initWithFrame:CGRectMake(20+vdropImage_green.size.width+60, 40, 36, 76/1.9)];
  time_passed_value.text = value3;
  time_passed_value.font = [UIFont fontWithName:@"Avenir-MediumOblique" size:16.0];
  time_passed_value.textColor = fontcolor;

  
  switch (style) {
    case ARTralSummaryCellStyle_black: //black
      title.textColor = [UIColor blackColor];
      [vdropViewFrame addSubview:vdropView_black];
      break;
      
    case ARTralSummaryCellStyle_blue: //blue
      title.textColor = bluetrailcolor;
      [vdropViewFrame addSubview:vdropView_blue];

      break;
      
    case ARTralSummaryCellStyle_green: //green
      title.textColor = greentrailcolor;
      [vdropViewFrame addSubview:vdropView_green];

      break;
      
    default:
      break;
  }
  [vdropViewFrame addSubview:vdrop_value];
  [self.contentView addSubview:maxspeed];
  [self.contentView addSubview:maxspeedUnitView];
  [self.contentView addSubview:time_passed];
  [self.contentView addSubview:time_passed_value];

  [self.contentView addSubview:title];
  [self.contentView addSubview:vdropViewFrame];
  
}

/**
 * @desc draw out gerenal view of the Summary Cell
 * @param string $msg - the message to be displayed
 * @return configured cellView
 */

+ (ARTrailSummaryTableCell *)cellWithStyle:(ARTrailSummaryCellStyle)styles andTrail:(NSString *)trail andValue:(NSString *)value andValue2:(NSString *)value2 andValue3:(NSString*)value3 rect:(CGRect) rect;
{
  NSLog(@"rect is %f", rect.size.width);
  ARTrailSummaryTableCell *cell = [[ARTrailSummaryTableCell alloc]initWithFrame:rect];
  [cell setThemeWithStyle:styles andTrail:trail andValue:value andValue2: value2 andValue3: value3 rect:rect];
  return cell;
}


@end
