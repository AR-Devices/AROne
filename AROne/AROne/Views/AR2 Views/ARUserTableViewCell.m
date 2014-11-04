//
//  ARUserTableViewCell.m
//  ARTwo
//
//  Created by Chenchen Zheng on 8/9/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARUserTableViewCell.h"
#import "BMInitialsPlaceholderView.h"

@implementation ARUserTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    _userIcon = [[BMInitialsPlaceholderView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    [self addSubview:_userIcon];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
