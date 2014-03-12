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

- (void)setThemeWithStyle:(ARTrailSummaryCellStyle) style andTrail:(NSString*)trail andValue:(NSString *)value rect:(CGRect) rect
{
  
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
  maxspeed.font = [UIFont fontWithName:@"Avenir-MediumOblique" size:20.0];
  maxspeed.textColor = [UIColor colorWithRed:161/255.0f green:138/255.0f blue:193/255.0f alpha:1];
  
  UIImage *maxspeed_unit = [UIImage imageNamed:@"mph Max Speed"];
  UIImageView *maxspeedUnitView = [[UIImageView alloc] initWithImage:maxspeed_unit];
  maxspeedUnitView.frame = CGRectMake(20+vdropImage_green.size.width+80, 15, 76/1.9, 76/1.9);
  maxspeedUnitView.contentMode = UIViewContentModeScaleAspectFit;
  

  

  
  switch (style) {
    case ARTralSummaryCellStyle1:
      title.textColor = [UIColor colorWithRed:113.0/255.0 green:82.0/255.0 blue:157.0/255.0 alpha:1.0];
      [vdropViewFrame addSubview:vdropView_black];
      break;
      
    case ARTralSummaryCellStyle2:
      title.textColor = [UIColor colorWithRed:23/255.0f green:148/255.0f blue:151/255.0f alpha:1];
      [vdropViewFrame addSubview:vdropView_blue];

      break;
      
    case ARTralSummaryCellStyle3:
      title.textColor = [UIColor colorWithRed:216/255.0f green:127/255.0f blue:24/255.0f alpha:1];
      [vdropViewFrame addSubview:vdropView_green];

      break;
      
    default:
      break;
  }

  [self.contentView addSubview:maxspeed];
  [self.contentView addSubview:maxspeedUnitView];
  [self.contentView addSubview:title];
  [self.contentView addSubview:vdropViewFrame];
  
}

/**
 * @desc draw out gerenal view of the Summary Cell
 * @param string $msg - the message to be displayed
 * @return configured cellView
 */

+ (ARTrailSummaryTableCell *)cellWithStyle:(ARTrailSummaryCellStyle)styles andTrail:(NSString *)trail andValue:(NSString *)value rect:(CGRect) rect;
{
  NSLog(@"rect is %f", rect.size.width);
  ARTrailSummaryTableCell *cell = [[ARTrailSummaryTableCell alloc]initWithFrame:rect];
  [cell setThemeWithStyle:styles andTrail:trail andValue:value rect:rect];
  return cell;
}


@end
