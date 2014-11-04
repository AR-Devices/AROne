//
//  ARProfileHeaderView.h
//  ARTwo
//
//  Created by Chenchen Zheng on 8/9/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DZNSegmentedControl;

@interface ARProfileHeaderView : UIView
@property (strong, nonatomic) UIImageView *userIcon;
@property (strong, nonatomic) UILabel *userName;
@property (strong, nonatomic) DZNSegmentedControl *control;

@end
