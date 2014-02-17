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

@interface ARAppDelegate ()
@property (nonatomic, strong) AKTabBarController *tabBarController;


@end
@implementation ARAppDelegate

// ****************************************************************************
// App switching methods to support Facebook Single Sign-On.
// ****************************************************************************
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
  return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
//  return [PFFacebookUtils handleOpenURL:url];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  [FBAppEvents activateApp];
  [FBSession.activeSession handleDidBecomeActive];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
  NSLog(@"called");
  // Store the deviceToken in the current installation and save it to Parse.
  PFInstallation *currentInstallation = [PFInstallation currentInstallation];
  [currentInstallation setDeviceTokenFromData:newDeviceToken];
  //  [currentInstallation addUniqueObject:@"Cliq" forKey:@"channels"];
  NSString *fbid = [[NSUserDefaults standardUserDefaults] objectForKey:@"myFBID"];
  NSLog(@"fbid is %@",fbid);
  if (fbid != nil) {
    [currentInstallation addUniqueObject:fbid forKey: @"channels"];
  }
  [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
  [PFPush handlePush:userInfo];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // ****************************************************************************
  // Fill in with your Parse and Twitter credentials. Don't forget to add your
  // Facebook id in Info.plist:
  // JERRY: THIS MUST BE THE FIRST LINE OF CODE IN THIS METHOD -^.^-
  // ****************************************************************************
  [Parse setApplicationId:@"Lt8jTMUGgCSfv8HaeY02aVUMlLhX55VrgAmbOzwe" clientKey:@"jdLKdGO8ixtGrpe7HX5XLFwJICB8pFjIPw5xVvA4"];
  
  // Register for push notifications
  [application registerForRemoteNotificationTypes:
   UIRemoteNotificationTypeBadge |
   UIRemoteNotificationTypeAlert |
   UIRemoteNotificationTypeSound];
  
  [PFFacebookUtils initializeFacebook];
  //[PFTwitterUtils initializeWithConsumerKey:@"your_twitter_consumer_key" consumerSecret:@"your_twitter_consumer_secret"];

  [self setAppTheme];
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [self setTabBarController];
  [self.window makeKeyAndVisible];
  return YES;
}

#pragma mark - private functions
- (void) setTabBarController
{
  //check if device is ipad or iphone
  NSString *deviceType = [UIDevice currentDevice].model;
  NSLog(@"deviceType is %@", deviceType);
  if([deviceType rangeOfString:@"iPad"].location == NSNotFound) {
    //  ccz: init Trabbar controller with height of 50, thinking not to display tab bar text
    self.tabBarController = [[AKTabBarController alloc] initWithTabBarHeight:40 position:AKTabBarPositionBottom];
  } else {
    self.tabBarController = [[AKTabBarController alloc] initWithTabBarHeight:60 position:AKTabBarPositionBottom];
  }
  
  ARSummaryViewController *summary = [[ARSummaryViewController alloc] initWithStyle:UITableViewStylePlain];
  UINavigationController *summaryNavigation = [[UINavigationController alloc] initWithRootViewController:summary];
  ARScoreboardViewController *scoreboard = [[ARScoreboardViewController alloc] initWithStyle:UITableViewStylePlain];
  UINavigationController *scoreboardNavigation = [[UINavigationController alloc] initWithRootViewController:scoreboard];
  UINavigationController *trailSummary = [[UINavigationController alloc] initWithRootViewController:[ARTrailSummaryViewController new]];
  
  
  [self.tabBarController setViewControllers:[NSMutableArray arrayWithObjects:summaryNavigation, scoreboardNavigation, trailSummary, nil]]; //FIXME: delete summaryTabGraph
  
  // Tab background Image
  [self.tabBarController setBackgroundImageName:@"TabBarBlue"];
  [self.tabBarController setSelectedBackgroundImageName:@"TabBarBlue"];
  
  
  // If needed, set cap insets for the background image
  [_tabBarController setBackgroundImageCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
  
  // Tabs top embos Color
  [_tabBarController setTabEdgeColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.8]];
  
  // Tabs Colors settings
  [_tabBarController setTabColors:@[[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.0],
                                    [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]]]; // MAX 2 Colors
  
  [_tabBarController setSelectedTabColors:@[[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0],
                                            [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0]]]; // MAX 2 Colors
  
  // Tab Stroke Color
  //   [_tabBarController setTabStrokeColor:[UIColor whiteColor]];
  
  // Icons Color settings
  [_tabBarController setIconColors:@[[UIColor colorWithRed:174.0/255.0 green:174.0/255.0 blue:174.0/255.0 alpha:1],
                                     [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1]]]; // MAX 2 Colors
  
  // Icon Shadow
  //   [_tabBarController setIconShadowColor:[UIColor blackColor]];
  //   [_tabBarController setIconShadowOffset:CGSizeMake(0, 1)];
  
  [_tabBarController setSelectedIconColors:@[[UIColor colorWithRed:174.0/255.0 green:174.0/255.0 blue:174.0/255.0 alpha:1],
                                             [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1]]]; // MAX 2 Colors
  
  [_tabBarController setSelectedIconOuterGlowColor:[UIColor whiteColor]];
  
  // Text Color
  [_tabBarController setTextColor:[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0]];
  [_tabBarController setSelectedTextColor:[UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0]];
  
  // Text font
  //   [_tabBarController setTextFont:[UIFont fontWithName:@"Chalkduster" size:14]];
  
  // Hide / Show glossy on tab icons
  [_tabBarController setIconGlossyIsHidden:YES];
  
  // Enable / Disable pre-rendered image mode
  [_tabBarController setTabIconPreRendered:NO];
  
  
  // Uncomment the following lines to completely remove the border from all elements.
  /*
   [_tabBarController setTabEdgeColor:[UIColor clearColor]];
   [_tabBarController setTabInnerStrokeColor:[UIColor clearColor]];
   [_tabBarController setTabStrokeColor:[UIColor clearColor]];
   [_tabBarController setTopEdgeColor:[UIColor clearColor]];
   */
  
  // Uncomment the following to display centered image in the center of the tabbar, similar to Instagram.
  /*
   UIImage *img = [UIImage imageNamed:@"sample-center-image"];
   UIImageView *bottomCenterView = [[UIImageView alloc] initWithImage:img];
   CGRect rect = _tabBarController.view.frame;
   bottomCenterView.frame = CGRectMake(rect.size.width/2 - img.size.width/2, rect.size.height - img.size.height,
   img.size.width, img.size.height);
   [_tabBarController.view addSubview:bottomCenterView];
   */
  
  [self.window setRootViewController:self.tabBarController];

  
}

- (void) setAppTheme
{
  //set status bar to white
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
  //  [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
  //  [application setStatusBarStyle:UIStatusBarStyleLightContent];

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
