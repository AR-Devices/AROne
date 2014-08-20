//
//  ARUserListCell.m
//  style
//
//  Created by Chenchen Zheng on 8/24/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ARUserListCell.h"

@implementation ARUserListCell
@synthesize name_label;
@synthesize email_label;

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


- (void)setThemeWithName:(NSString*) name andEmail:(NSString *)email
{
  //ccz:  create cellView
  self.cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
  self.cellView.backgroundColor = [UIColor clearColor];

  self.name_label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,200,20)];
  self.name_label.text = name;
  
  self.email_label = [[UILabel alloc] initWithFrame:CGRectMake(150,0,100,20)];
  self.email_label.text = email;
  
  [self.cellView addSubview:self.name_label];
  [self.cellView addSubview:self.email_label];
  [self.contentView addSubview:self.cellView];

}


+ (ARUserListCell *)cellWithName:(NSString*)name andEmail:(NSString *)email
{
  ARUserListCell *cell = [[ARUserListCell alloc]init];
  [cell setThemeWithName:name andEmail:email];
  return cell;
}



@end
