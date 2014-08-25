//
//  ARWelcomeViewController.h
//  AROne
//
//  Created by Chenchen Zheng on 2/19/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseViewController.h"
#import <MSDynamicsDrawerViewController.h>

@interface ARWelcomeViewController : CCBaseViewController
@property (strong, nonatomic) MSDynamicsDrawerViewController *dynamicsDrawerViewController;
@property (strong, nonatomic) UIWindow *window;

@end
