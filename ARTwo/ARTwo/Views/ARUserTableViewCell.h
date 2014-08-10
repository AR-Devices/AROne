//
//  ARUserTableViewCell.h
//  ARTwo
//
//  Created by Chenchen Zheng on 8/9/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BMInitialsPlaceholderView;
@interface ARUserTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet BMInitialsPlaceholderView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@end
