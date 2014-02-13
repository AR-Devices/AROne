//
//  ARAppDelegate.m
//  AROne
//
//  Created by Chenchen Zheng on 9/4/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "ARAppDelegate.h"

//import vendor TabBar Controller
#import "AKTabBarController.h"
//import Pages
#import "ARSummaryViewController.h"
#import "ARScoreboardViewController.h"
#import "ARTrailSummaryViewController.h"
//FIXME temp put it here to see the view
#import "ARSummaryGraphViewController.h"
#import "SubclassConfigViewController.h"


@interface ARAppDelegate ()


@end
@implementation ARAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // ****************************************************************************
  // Fill in with your Parse and Twitter credentials. Don't forget to add your
  // Facebook id in Info.plist:
  // JERRY: THIS MUST BE THE FIRST LINE OF CODE IN THIS METHOD -^.^-
  // ****************************************************************************
  [Parse setApplicationId:@"Lt8jTMUGgCSfv8HaeY02aVUMlLhX55VrgAmbOzwe" clientKey:@"jdLKdGO8ixtGrpe7HX5XLFwJICB8pFjIPw5xVvA4"];
  [PFFacebookUtils initializeFacebook];
  //[PFTwitterUtils initializeWithConsumerKey:@"your_twitter_consumer_key" consumerSecret:@"your_twitter_consumer_secret"];
  
  [self appTheme];
  [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
  [application setStatusBarStyle:UIStatusBarStyleLightContent];
  //  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//    [application setStatusBarStyle:UIStatusBarStyleLightContent];
//    
//    self.window.clipsToBounds =YES;
//    
//    self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
//  }
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  
  
  SubclassConfigViewController* loginpage = [[SubclassConfigViewController alloc] init];
  
  [self.window setRootViewController:loginpage];

  [self.window makeKeyAndVisible];
  
  

  // Set default ACLs
  PFACL *defaultACL = [PFACL ACL];
  [defaultACL setPublicReadAccess:YES];
  [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - private functions


- (void) appTheme
{
  
  //navigation bar color #0d507f 13 80 127
  //progress bar color 96 219 255
  UIColor *naviColor = [UIColor colorWithRed:13/255.0f green:80/255.0f blue:127/255.0f alpha:1.0f];

//  set Navigation Bar Info
  [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
  // for iOS 7?
//  [[UINavigationBar appearance] setBarTintColor:naviColor];
  [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
  [[UINavigationBar appearance] setBackgroundColor:naviColor];
  [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"TabBarBlue"] forBarMetrics:UIBarMetricsDefault];
  // Customize the title text for *all* UINavigationBars
  //create navi font
//  NSDictionary *naviAttribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
//                                                                            fontWithName:@"Helvetica" size:55/2.5], NSFontAttributeName,
//                                 [UIColor whiteColor], NSForegroundColorAttributeName, nil];
  NSShadow *shadow = [NSShadow new];
  [shadow setShadowColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
  [shadow setShadowOffset: CGSizeMake(0.0f, 1.0f)];
  
  
  [[UINavigationBar appearance] setTitleTextAttributes:
   [NSDictionary dictionaryWithObjectsAndKeys:
    [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0],
    NSForegroundColorAttributeName,
    shadow, NSShadowAttributeName,
    [UIFont fontWithName:@"Avenir-Medium" size:44/1.9],
    NSFontAttributeName,
    nil]];

  
  
  //  [[UILabel appearance] setFont:[UIFont fontWithName:@"Big Caslon" size:18]];
  //  [[UILabel appearanceWhenContainedIn: [UITableView class], nil] setFont:[UIFont fontWithName:@"Big Caslon" size:10]];
  //  UIColor *progressColor = [UIColor colorWithRed:96/255.0f green:219/255.0f blue:255/255.0f alpha:1.0f];
//  [[AKTabBar appearance] setBackgroundColor: barColor];
  // for iOS 7
  //  [[UINavigationBar appearance] setBarTintColor:barColor];
  //  [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
  //  [[UITabBar appearance] setBarTintColor:barColor];
  //  [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
  // for iOS 6
//  [[UITabBar appearance] setBackgroundColor:barColor];
  
  
  //  [[UIProgressView appearance] setTintColor:progressColor];
  //  [[UIProgressView appearance] setTrackTintColor:[UIColor clearColor]];
  
  
  
  //  [[UITabBarItem appearance] setBackgroundImage:[[UIImage alloc] init]];
  //   [barButtonName setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15<=SIZE YOU WANT], UITextAttributeFont,nil] forState:UIControlStateNormal];
  
  //  tabbar stuff
//  [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
//  UIColor *titleHighlightedColor = [UIColor lightGrayColor];
//  [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: titleHighlightedColor, UITextAttributeTextColor, nil] forState:UIControlStateSelected];
//  [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
  
//ccz: segment apperance
//  UIImage *segmentSelected =
//  [[UIImage imageNamed:@"topBackSelected.png"]
//   resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
//  UIImage *segmentUnselected =
//  [[UIImage imageNamed:@"topback.png"]
//   resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
//  UIImage *segmentSelectedUnselected =
//  [UIImage imageNamed:@"segcontrol_sel-uns.png"];
//  UIImage *segUnselectedSelected =
//  [UIImage imageNamed:@"segcontrol_uns-sel.png"];
//  UIImage *segmentUnselectedUnselected =
//  [UIImage imageNamed:@"segcontrol_uns-uns.png"];
//
//  [[UISegmentedControl appearance] setBackgroundImage:segmentUnselected
//                                             forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//  [[UISegmentedControl appearance] setBackgroundImage:segmentSelected
//                                             forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];

//  [[UISegmentedControl appearance] setDividerImage:segmentUnselectedUnselected
//                               forLeftSegmentState:UIControlStateNormal
//                                 rightSegmentState:UIControlStateNormal
//                                        barMetrics:UIBarMetricsDefault];
//  [[UISegmentedControl appearance] setDividerImage:segmentSelectedUnselected
//                               forLeftSegmentState:UIControlStateSelected
//                                 rightSegmentState:UIControlStateNormal
//                                        barMetrics:UIBarMetricsDefault];
//  [[UISegmentedControl appearance]
//   setDividerImage:segUnselectedSelected
//   forLeftSegmentState:UIControlStateNormal
//   rightSegmentState:UIControlStateSelected
//   barMetrics:UIBarMetricsDefault];
//  [[UISegmentedControl appearance] setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6]];
//  4c6974
  
  [shadow setShadowColor: [UIColor colorWithRed:0.0/255.0 green:51.0/255.0 blue:87.0/255.0 alpha:0.75]];
  [shadow setShadowOffset: CGSizeMake(0.0f, -0.5f)];


  [[UISegmentedControl appearance] setTintColor:[UIColor clearColor]];
  NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIColor colorWithRed:76.0/255.0 green:105.0/255.0 blue:116.0/255.0 alpha:1.0],
                                  NSForegroundColorAttributeName,
                                  shadow, NSShadowAttributeName,
                                  [UIFont fontWithName:@"Avenir-Medium" size:34.0/1.9],
                                  NSFontAttributeName,
                                  nil];
    //  ios 6 has this ugly seperator
  [[UISegmentedControl appearance] setTitleTextAttributes: textAttributes forState:UIControlStateNormal];
//  NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
  [[UISegmentedControl appearance] setTitleTextAttributes: textAttributes forState:UIControlStateHighlighted];
  // Image between two unselected segments.
  [[UISegmentedControl appearance] setDividerImage:[UIImage imageNamed:@"segmented-separator"] forLeftSegmentState:UIControlStateNormal
                    rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
  // Image between segment selected on the left and unselected on the right.
  [[UISegmentedControl appearance] setDividerImage:[UIImage imageNamed:@"segmented-separator"] forLeftSegmentState:UIControlStateSelected
                    rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
  // Image between segment selected on  the right and unselected on the right.
  [[UISegmentedControl appearance] setDividerImage:[UIImage imageNamed:@"segmented-separator"] forLeftSegmentState:UIControlStateNormal
                    rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];

  

}



@end
