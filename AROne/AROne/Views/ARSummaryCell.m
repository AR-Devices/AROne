//
//  ARSummaryCell.m
//  style
//
//  Created by Chenchen Zheng on 8/24/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ARSummaryCell.h"

@implementation ARSummaryCell
@synthesize cellView;
@synthesize strip;
@synthesize cellViewTitle;
@synthesize number;

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

- (void)setThemeWithStyle:(ARSummaryCellStyle) style andValue:(NSString *)value rect:(CGRect) rect
{
  //ccz:  create cellView
  NSLog(@"style self.bounds width is %f", self.bounds.size.width);
  self.cellView = [[UIView alloc] initWithFrame:CGRectMake(SECTION_CELL_X_LEFT_MARGIN, 0, rect.size.width-SECTION_CELL_X_LEFT_MARGIN*2, rect.size.height/3.6 - 7)];
  self.cellView.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:.8];
  self.strip = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.cellView.bounds), 14/2.0f)];
  self.cellViewTitle = [[UIImageView alloc] initWithFrame:CGRectMake(3.0f, (8+14)/2.0f, 246/2.0f, 44/2.0f)];
  self.cellViewTitle.contentMode = UIViewContentModeScaleAspectFit;

  self.number = [[UILabel alloc] initWithFrame:CGRectMake(116/2.0f, 52/2.0f, 394/2.0f, 136/2.0f)];
  self.number.font = [UIFont fontWithName:@"Big Caslon" size:56.0];
  self.number.backgroundColor = [UIColor clearColor];
  self.number.textAlignment = NSTextAlignmentCenter;
  self.number.text = value;

  self.unit = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) - 50,CGRectGetHeight(self.bounds)+35, 30, 30)];
  self.unit.contentMode = UIViewContentModeScaleAspectFit;

  switch (style) {
    case ARSummaryCellStyleMaxSpeed:
      //ccz: add color to strip
      self.strip.backgroundColor = [UIColor colorWithRed:161/255.0f green:138/255.0f blue:193/255.0f alpha:1.0];
      self.number.textColor = [UIColor colorWithRed:113.0/255.0 green:82.0/255.0 blue:157.0/255.0 alpha:1.0];
      //ccz: add identify image to top right corner
      self.cellViewTitle.image = [UIImage imageNamed:@"RealTimeSpeed_icon"];
      self.unit.image = [UIImage imageNamed:@"mph"];
      break;
      
    case ARSummaryCellStyleVerticalDrop:
      self.strip.backgroundColor = [UIColor colorWithRed:47/255.0f green:179/255.0f blue:182/255.0f alpha:1];
      self.number.textColor = [UIColor colorWithRed:23/255.0f green:148/255.0f blue:151/255.0f alpha:1];
      self.cellViewTitle.image = [UIImage imageNamed:@"VerticalDrop_icon"];
      self.unit.image = [UIImage imageNamed:@"feet"];
      break;
      
    case ARSummaryCellStyleAcceleration:
      //ccz: add this later we need @"acceleration" and @"AR Score"
      self.strip.backgroundColor = [UIColor colorWithRed:238/255.0f green:150/255.0f blue:47/255.0f alpha:1];
      self.number.textColor = [UIColor colorWithRed:216/255.0f green:127/255.0f blue:24/255.0f alpha:1];
      self.cellViewTitle.image = [UIImage imageNamed:@"Acceleration_icon"];
      self.unit.image = [UIImage imageNamed:@"s2"];
      break;
      
    default:
      break;
  }
  //  shadow
  //  shadow color #696969
  self.cellView.layer.masksToBounds = NO;
  self.cellView.layer.shadowOffset = CGSizeMake(0, 0);
  self.cellView.layer.shadowColor = [[UIColor colorWithRed:105/255.0f green:105/255.0f blue:105/255.0f alpha:1.0] CGColor];
  self.cellView.layer.shadowRadius = 2;
  self.cellView.layer.shadowOpacity = 0.5;
  
// CCZ: different way to add shadow on one side :)
//  CAGradientLayer *shadow = [CAGradientLayer layer];
//  shadow.frame = CGRectMake(0, CGRectGetHeight(self.cellView.bounds)-2, CGRectGetWidth(self.cellView.bounds), 5);
//  shadow.startPoint = CGPointMake(0, 0.5);
//  shadow.endPoint = CGPointMake(10, 0.5);
//  shadow.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:105/255.0f green:105/255.0f blue:105/255.0f alpha:0.5] CGColor], (id)[[UIColor clearColor] CGColor], nil];
//  [self.cellView.layer addSublayer:shadow];
  
  [self.cellView addSubview:self.strip];
  [self.cellView addSubview:self.cellViewTitle];
  [self.cellView addSubview:self.number];
  [self.cellView addSubview:self.unit];
  [self.contentView addSubview:self.cellView];

}

/**
 * @desc draw out gerenal view of the Summary Cell
 * @param string $msg - the message to be displayed
 * @return configured cellView
 */

+ (ARSummaryCell *)cellWithStyle:(ARSummaryCellStyle)styles andValue:(NSString *)value rect:(CGRect) rect
{
  NSLog(@"rect is %f", rect.size.width);
  ARSummaryCell *cell = [[ARSummaryCell alloc]initWithFrame:rect];
  [cell setThemeWithStyle:styles andValue:value rect:rect];
  return cell;
}



@end
