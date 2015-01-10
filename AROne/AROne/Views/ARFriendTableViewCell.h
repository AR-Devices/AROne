//
//  ARFriendTableViewCell.h
//  AROne
//
//  Created by Chenchen Zheng on 1/1/15.
//  Copyright (c) 2015 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARFriendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *trailName;
@property (weak, nonatomic) IBOutlet UILabel *lastSeen;
@property (weak, nonatomic) IBOutlet UILabel *coordinates;

@end
