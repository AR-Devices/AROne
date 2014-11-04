//
//  CCBaseTabBarController.m
//  ARTwo
//
//  Created by Chenchen Zheng on 6/7/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "CCBaseTabBarController.h"

@interface CCBaseTabBarController ()

@end

@implementation CCBaseTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      NSString *deviceType = [UIDevice currentDevice].model;
      if([deviceType rangeOfString:@"iPad"].location == NSNotFound) {
        
      } else {
        
      }

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
