//
//  CCBaseNavigationController.m
//  ARTwo
//
//  Created by Chenchen Zheng on 6/7/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "CCBaseNavigationController.h"

@interface CCBaseNavigationController ()

@end

@implementation CCBaseNavigationController

#pragma mark - Alloc/Init

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
  self = [super initWithRootViewController:rootViewController];
  if (self)
  {
    self.navigationBar.translucent = NO;
    [[UINavigationBar appearance] setBarTintColor:kJBColorNavigationTint];
    [[UINavigationBar appearance] setTintColor:kJBColorNavigationBarTint];
    self.interactivePopGestureRecognizer.enabled = NO;
  }
  return self;
}

#pragma mark - Status Bar

- (UIStatusBarStyle)preferredStatusBarStyle
{
  return UIStatusBarStyleLightContent;
}

@end
