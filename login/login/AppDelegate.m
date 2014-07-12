//
//  AppDelegate.m
//  login
//
//  Created by Chenchen Zheng on 7/11/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "AppDelegate.h"
#import "ARWelcomeViewController.h"

@interface AppDelegate ()
            

@end

@implementation AppDelegate





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
  // Initialization of CentralManager
//  [LGCentralManager sharedInstance];
  
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
  
  // ****************************************************************************
  // Fill in with your Parse and Twitter credentials. Don't forget to add your
  // Facebook id in Info.plist:
  // JERRY: THIS MUST BE THE FIRST LINE OF CODE IN THIS METHOD -^.^-
  // ****************************************************************************
  [Parse setApplicationId:@"Lt8jTMUGgCSfv8HaeY02aVUMlLhX55VrgAmbOzwe" clientKey:@"jdLKdGO8ixtGrpe7HX5XLFwJICB8pFjIPw5xVvA4"];
  // Register for push notifications
  
//  [application registerForRemoteNotificationTypes:
//   UIRemoteNotificationTypeBadge |
//   UIRemoteNotificationTypeAlert |
//   UIRemoteNotificationTypeSound];
  
  [PFFacebookUtils initializeFacebook];
  //[PFTwitterUtils initializeWithConsumerKey:@"your_twitter_consumer_key" consumerSecret:@"your_twitter_consumer_secret"];
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [self.window setRootViewController:[ARWelcomeViewController new]];
  //[self.window setRootViewController:[ARSignupViewController new]];
  
  //  [self setTabBarController];
  
  //  [self createSummaryClass];
  
  [self.window makeKeyAndVisible];
  return YES;
}


@end
