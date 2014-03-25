//
//  ARScoreBoardCell.m
//  AROne
//
//  Created by Chenchen Zheng on 9/7/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "ARScoreBoardCell.h"

@implementation ARScoreBoardCell

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
//add a ARStyle here...
- (void)setThemeWithStyle:(ARScoreBoardCellStyle)style rank:(ARRankStyle) rank andData:(NSDictionary *)data
{
  NSString *who = [data objectForKey:@"who"];
  NSString *value = [data objectForKey:@"score"];
  NSLog(@"who2 is %@" ,who);
//  NSLog(@"value is %@", [value class]);
  //ccz:  create cellView
  self.cellView = [[UIView alloc] initWithFrame:CGRectMake(SECTION_CELL_X_LEFT_MARGIN, 0, SECTION_CELL_WIDTH, SECTION_CELL_X_HEIGHT-20)];
  self.cellView.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0];

  UIImage *icon = [UIImage imageNamed:@"profile_hp"];
  UIImageView *iconView = [[UIImageView alloc] initWithImage:icon];
  iconView.contentMode = UIViewContentModeScaleAspectFit;
  iconView.center = CGPointMake(self.cellView.bounds.size.width/8,self.cellView.bounds.size.height/2);
  [self.cellView addSubview:iconView];

  UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 76/2)];
  name.font = [UIFont fontWithName:@"Avenir-Medium" size:30.0/1.9];
  name.textColor = [UIColor colorWithRed:109.0/255.0f green:109.0/255.0f blue:109.0/255.0f alpha:1.0];
  name.text = who;
  name.adjustsFontSizeToFitWidth = true;
  name.center = CGPointMake(self.cellView.bounds.size.width/2-40,self.cellView.bounds.size.height/2);

  
  [self.cellView addSubview:name];
  
  //rank image
  UIImageView *rankView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
  switch (rank) {
    case ARGold:
      [rankView setImage:[UIImage imageNamed:@"crown"]];
      [iconView addSubview:rankView];
      break;
    case ARSilver:
      rankView.backgroundColor = [UIColor clearColor];
      [iconView addSubview:rankView];
      break;
    case ARBronze:
      rankView.backgroundColor = [UIColor clearColor];
      [iconView addSubview:rankView];

      break;
    default:
      break;
  }
  UIColor *purpleColor   = [UIColor colorWithRed:161/255.0f green:138/255.0f blue:193/255.0f alpha:1];
  UIColor *neonblueColor = [UIColor colorWithRed:47/255.0f green:179/255.0f blue:182/255.0f alpha:1];
  UIColor *orangeColor   = [UIColor colorWithRed:238/255.0f green:150/255.0f blue:47/255.0f alpha:1];

  switch (style) {
  case ARScoreBoardCellStyleMaxSpeed:
    {
      //jw speed score
      UILabel *maxspeed_text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 66)];
      maxspeed_text.font = [UIFont fontWithName:@"Avenir-MediumOblique" size:72.0/1.9];
      maxspeed_text.text = value; //FIXME value should be extracted from section text
      maxspeed_text.textAlignment = NSTextAlignmentCenter;
      maxspeed_text.adjustsFontSizeToFitWidth = true;
      maxspeed_text.textColor = [UIColor colorWithRed:161/255.0f green:138/255.0f blue:193/255.0f alpha:1];
      maxspeed_text.center = CGPointMake(self.cellView.bounds.size.width/2+10+30,self.cellView.bounds.size.height/2-5);

      [self.cellView addSubview:maxspeed_text];
      //jw speed score units [CONSTANT]
      UIImage *maxspeed_unit = [UIImage imageNamed:@"mph Max Speed"];
      UIImageView *maxspeedUnitView = [[UIImageView alloc] initWithImage:maxspeed_unit];
      maxspeedUnitView.frame = CGRectMake(43, 45, 76/1.9, 76/1.9);
      maxspeedUnitView.contentMode = UIViewContentModeScaleAspectFit;
      maxspeedUnitView.center = CGPointMake(self.cellView.bounds.size.width/2+10+80,self.cellView.bounds.size.height/2);

      [self.cellView addSubview:maxspeedUnitView];
    }
    break;
  case ARScoreBoardCellStyleVerticalDrop:
    {
      //jw speed graph
      UILabel *vdrop_graph = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 66)];
      vdrop_graph.font = [UIFont fontWithName:@"Avenir-MediumOblique" size:72.0/1.9];
      vdrop_graph.text = value; //FIXME value should be extracted from section text
      vdrop_graph.textAlignment = NSTextAlignmentCenter;
      vdrop_graph.adjustsFontSizeToFitWidth = true;
      vdrop_graph.textColor = neonblueColor;
      vdrop_graph.center = CGPointMake(self.cellView.bounds.size.width/2+10+30,self.cellView.bounds.size.height/2-5);
      [self.cellView addSubview:vdrop_graph];
      
      UIImage *vdrop_unit = [UIImage imageNamed:@"mph Max Speed"];
      UIImageView *vdropUnitView = [[UIImageView alloc] initWithImage:vdrop_unit];
      vdropUnitView.frame = CGRectMake(43, 45, 76/1.9, 76/1.9);
      vdropUnitView.contentMode = UIViewContentModeScaleAspectFit;
      vdropUnitView.center = CGPointMake(self.cellView.bounds.size.width/2+10+80,self.cellView.bounds.size.height/2);

      [self.cellView addSubview:vdropUnitView];
    }
    break;
  case ARScoreBoardCellStyleAcceleration:
    {
      //jw speed circle
      UILabel *acce_graph = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 66)];
      acce_graph.font = [UIFont fontWithName:@"Avenir-MediumOblique" size:72.0/1.9];
      acce_graph.text = value; //FIXME value should be extracted from section text
      acce_graph.textAlignment = NSTextAlignmentCenter;
      acce_graph.adjustsFontSizeToFitWidth=true;
      acce_graph.textColor = orangeColor;
      acce_graph.center = CGPointMake(self.cellView.bounds.size.width/2+10+30,self.cellView.bounds.size.height/2-5);
      [self.cellView addSubview:acce_graph];
      
      UIImage *acce_unit = [UIImage imageNamed:@"mph Max Speed"];
      UIImageView *acceUnitView = [[UIImageView alloc] initWithImage:acce_unit];
      acceUnitView.frame = CGRectMake(43, 45, 76/1.9, 76/1.9);
      acceUnitView.contentMode = UIViewContentModeScaleAspectFit;
      acceUnitView.center = CGPointMake(self.cellView.bounds.size.width/2+10+80,self.cellView.bounds.size.height/2);

      [self.cellView addSubview:acceUnitView];
//      UIImage *maxspeed_circle = [UIImage imageNamed:@"circle"];
//      UIImageView *maxspeedCircleView = [[UIImageView alloc] initWithImage:maxspeed_circle];
//      maxspeedCircleView.frame = CGRectMake(250, 45, 40, 40);
//      maxspeedCircleView.contentMode = UIViewContentModeScaleAspectFit;
//
//      
//      UITextField* textField = [[UITextField alloc]
//                                initWithFrame:CGRectMake(10, 10, 50, 20)];
//      textField.font = [UIFont fontWithName:@"Avenir-Roman" size:12.0];
//
//      textField.placeholder = @"8.9";
//      maxspeedCircleView.center = CGPointMake(self.cellView.bounds.size.width/2+10+40,self.cellView.bounds.size.height/2);
//
//      [maxspeedCircleView addSubview:textField];
//      [self.cellView addSubview:maxspeedCircleView];
    }
    break;
  }

  





  
  
  UILabel* numberView = [[UILabel alloc] initWithFrame:CGRectMake(116/2.0f, 52/2.0f, 394/2.0f, 136/2.0f)];
  self.number = numberView;
  self.number.font = [UIFont fontWithName:@"Big Caslon" size:56.0];
  self.number.backgroundColor = [UIColor clearColor];
  self.number.textAlignment = NSTextAlignmentCenter;

  
  //  self.number.textColor = self.strip.backgroundColor;
  
  //  shadow
  //  shadow color #696969
  self.cellView.layer.masksToBounds = NO;
  self.cellView.layer.shadowOffset = CGSizeMake(0, 0);
  self.cellView.layer.shadowColor = [[UIColor colorWithRed:105/255.0f green:105/255.0f blue:105/255.0f alpha:1.0] CGColor];
  self.cellView.layer.shadowRadius = 2;
  self.cellView.layer.shadowOpacity = 0.5;

  
  
  [self.cellView addSubview:self.number];
  [self.contentView addSubview:self.cellView];
  
}

/**
 * @desc draw out gerenal view of the Summary Cell
 * @param string $msg - the message to be displayed
 * @return configured cellView
 */

+ (ARScoreBoardCell *)cellWithStyle:(ARScoreBoardCellStyle)style rank: (ARRankStyle) rank andData: (NSDictionary *)data
{
  ARScoreBoardCell *cell = [[ARScoreBoardCell alloc]init];
  [cell setThemeWithStyle:style rank:rank andData:data];
  return cell;
}


/**
 * @desc
 *
 *
 */


@end
