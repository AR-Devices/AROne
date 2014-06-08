//
//  CCBaseViewController.m
//  ARTwo
//
//  Created by Chenchen Zheng on 6/7/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "CCBaseViewController.h"

@interface CCBaseViewController ()

@end

@implementation CCBaseViewController

- (void)loadView
{
  [super loadView];
  self.edgesForExtendedLayout = UIRectEdgeTop;
  self.view.backgroundColor = [UIColor whiteColor];
//  self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kJBImageIconJawboneLogo]];
}

#pragma mark - Orientation

- (BOOL)shouldAutorotate
{
  return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Getters

//- (UIBarButtonItem *)chartToggleButtonWithTarget:(id)target action:(SEL)action
//{
//  UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:kJBImageIconArrow] style:UIBarButtonItemStylePlain target:target action:action];
//  return button;
//}

@end
