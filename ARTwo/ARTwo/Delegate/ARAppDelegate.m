//
//  ARAppDelegate.m
//  ARTwo
//
//  Created by Chenchen Zheng on 6/7/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARAppDelegate.h"
#import "CCBaseNavigationController.h"
#import "ARSummaryTableViewController.h"

@implementation ARAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  CCBaseNavigationController *navigationController = [[CCBaseNavigationController alloc] initWithRootViewController:[[ARSummaryTableViewController alloc] init]];
  self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
