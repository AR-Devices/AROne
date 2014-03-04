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
#import "ARWelcomeViewController.h"
#import "ARSignupViewController.h"
#import "ARLoginViewController.h"

//test
#import "ARSummary.h"
#import "ARCommon.h"


@interface ARAppDelegate ()


@end
@implementation ARAppDelegate
// In the app delegate we create a constant string to be used as an event name
static NSString* const kPAWLocationChangeNotification= @"kPAWLocationChangeNotification";


// ****************************************************************************
// App switching methods to support Facebook Single Sign-On.
// ****************************************************************************
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
  return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
  
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

  [FBAppEvents activateApp];
  [FBSession.activeSession handleDidBecomeActive];
  
}

- (void)createSummaryClass {
  
  ARSummary *measurement = [ARSummary object];
  measurement.displayName = @"Chenchen's First Measurement";
  measurement.date = [ARCommon today];
  measurement.maxAcceleration = 10.2;
  measurement.maxSpeed = 25.2;
  measurement.verticalDrop = 18560;
//  [measurement setPlayer:[PFUser currentUser]];
  measurement.player = [PFUser currentUser];
  measurement.ACL = [PFACL ACLWithUser:measurement.player];
  [measurement saveInBackground];
  
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
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
  
  //calling class
  [ARSummary registerSubclass];
  
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
  [self.window setRootViewController:[ARWelcomeViewController new]];
  //[self.window setRootViewController:[ARSignupViewController new]];
 
//  [self setTabBarController];
  
//  [self createSummaryClass];
  
  [self.window makeKeyAndVisible];
  return YES;
}

#pragma mark - private functions

// We also add a method to be called when the location changes.
// This is where we post the notification to all observers.
- (void)setCurrentLocation:(CLLocation *)aCurrentLocation
{
  NSDictionary *userInfo = [NSDictionary dictionaryWithObject: aCurrentLocation
                                                       forKey:@"location"];
  [[NSNotificationCenter defaultCenter] postNotificationName:kPAWLocationChangeNotification
                                                      object:nil
                                                    userInfo:userInfo];
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
