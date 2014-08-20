//
//  ARUserListCell.h
//  style
//
//  Created by Chenchen Zheng on 8/24/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

//gloabal defination

@interface ARUserListCell : UITableViewCell

@property (nonatomic, strong) UIView* cellView;
@property (nonatomic, strong) UILabel* name_label;
@property (nonatomic, strong) UILabel* email_label;

+ (ARUserListCell *)cellWithName:(NSString*)name andEmail:(NSString *)email;


@end
