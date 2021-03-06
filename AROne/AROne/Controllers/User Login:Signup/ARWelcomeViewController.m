//
//  ARWelcomeViewController.m
//  AROne
//
//  Created by Chenchen Zheng on 2/19/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARWelcomeViewController.h"
//#import "AKTabBarController.h"
#import "ARSummaryViewController.h"
#import "ARScoreboardViewController.h"
#import "ARTrailSummaryViewController.h"
#import "ARMoreTableViewController.h"
#import "ARMapViewController.h"
#import "ARFMFController.h"
#import "ARLoginViewController.h"

@interface ARWelcomeViewController ()

//@property (nonatomic, strong) AKTabBarController *tabBarController;


@end

@implementation ARWelcomeViewController


//Login stuff

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if ([PFUser currentUser]) {
    NSLog(@"%@ Logged In!", [NSString stringWithFormat: NSLocalizedString(@"Welcome %@", nil), [[PFUser currentUser] username]]);
    //    self.welcomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]];
  } else {
    NSLog(@"no one logged in yet");
    //    self.welcomeLabel.text = NSLocalizedString(@"Not logged in", nil);
  }
}


- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
//  [self jerry_test];
  
  // Check if user is logged in
  if (![PFUser currentUser]) {
    // Customize the Log In View Controller
    ARLoginViewController *logInViewController = [[ARLoginViewController alloc] init];    
    // Present Log In View Controller
    logInViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:logInViewController] animated:YES completion:NULL];
  } else {
    [self setTabBarController];
  }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"welcome"]];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setTabBarController {
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    
    ARSummaryViewController *summary = [[ARSummaryViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *summaryNavigation = [[UINavigationController alloc] initWithRootViewController:summary];
    
    ARScoreboardViewController *scoreboard = [[ARScoreboardViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *scoreboardNavigation = [[UINavigationController alloc] initWithRootViewController:scoreboard];
    
    UINavigationController *trailSummary = [[UINavigationController alloc] initWithRootViewController:[ARTrailSummaryViewController new]];

//    UINavigationController *buddyNavi = [[UINavigationController alloc] initWithRootViewController:[ARMapViewController new]];
    UINavigationController *buddyNavi = [[UINavigationController alloc] initWithRootViewController:[ARFMFController new]];
    ARMoreTableViewController *more = [[ARMoreTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *moreNavi = [[UINavigationController alloc] initWithRootViewController:more];
    

    [tabbar setViewControllers:@[summaryNavigation,scoreboardNavigation,trailSummary, buddyNavi, moreNavi]];
    [self presentViewController:tabbar animated:YES completion:nil];
}

//- (void) setTabBarController
//{
//  //check if device is ipad or iphone
//  NSString *deviceType = [UIDevice currentDevice].model;
//  NSLog(@"deviceType is %@", deviceType);
//  if([deviceType rangeOfString:@"iPad"].location == NSNotFound) {
//    //  ccz: init Trabbar controller with height of 50, thinking not to display tab bar text
//    self.tabBarController = [[AKTabBarController alloc] initWithTabBarHeight:40 position:AKTabBarPositionBottom];
//  } else {
//    self.tabBarController = [[AKTabBarController alloc] initWithTabBarHeight:60 position:AKTabBarPositionBottom];
//  }
//  
//  ARSummaryViewController *summary = [[ARSummaryViewController alloc] initWithStyle:UITableViewStylePlain];
//  UINavigationController *summaryNavigation = [[UINavigationController alloc] initWithRootViewController:summary];
//  ARScoreboardViewController *scoreboard = [[ARScoreboardViewController alloc] initWithStyle:UITableViewStylePlain];
//  UINavigationController *scoreboardNavigation = [[UINavigationController alloc] initWithRootViewController:scoreboard];
//  UINavigationController *trailSummary = [[UINavigationController alloc] initWithRootViewController:[ARTrailSummaryViewController new]];
//
//  
//  [self.tabBarController setViewControllers:[NSMutableArray arrayWithObjects:summaryNavigation, scoreboardNavigation, trailSummary, nil]]; //FIXME: delete summaryTabGraph
//  
//  // Tab background Image
//  [self.tabBarController setBackgroundImageName:@"TabBarBlue"];
//  [self.tabBarController setSelectedBackgroundImageName:@"TabBarBlue"];
//  
//  
//  // If needed, set cap insets for the background image
//  [_tabBarController setBackgroundImageCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
//  
//  // Tabs top embos Color
//  [_tabBarController setTabEdgeColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.8]];
//  
//  // Tabs Colors settings
//  [_tabBarController setTabColors:@[[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.0],
//                                    [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]]]; // MAX 2 Colors
//  
//  [_tabBarController setSelectedTabColors:@[[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0],
//                                            [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0]]]; // MAX 2 Colors
//  
//  // Tab Stroke Color
//  //   [_tabBarController setTabStrokeColor:[UIColor whiteColor]];
//  
//  // Icons Color settings
//  [_tabBarController setIconColors:@[[UIColor colorWithRed:174.0/255.0 green:174.0/255.0 blue:174.0/255.0 alpha:1],
//                                     [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1]]]; // MAX 2 Colors
//  
//  // Icon Shadow
//  //   [_tabBarController setIconShadowColor:[UIColor blackColor]];
//  //   [_tabBarController setIconShadowOffset:CGSizeMake(0, 1)];
//  
//  [_tabBarController setSelectedIconColors:@[[UIColor colorWithRed:174.0/255.0 green:174.0/255.0 blue:174.0/255.0 alpha:1],
//                                             [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1]]]; // MAX 2 Colors
//  
//  [_tabBarController setSelectedIconOuterGlowColor:[UIColor whiteColor]];
//  
//  // Text Color
//  [_tabBarController setTextColor:[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0]];
//  [_tabBarController setSelectedTextColor:[UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0]];
//  
//  // Text font
//  //   [_tabBarController setTextFont:[UIFont fontWithName:@"Chalkduster" size:14]];
//  
//  // Hide / Show glossy on tab icons
//  [_tabBarController setIconGlossyIsHidden:YES];
//  
//  // Enable / Disable pre-rendered image mode
//  [_tabBarController setTabIconPreRendered:NO];
//  
//  
//  // Uncomment the following lines to completely remove the border from all elements.
//  /*
//   [_tabBarController setTabEdgeColor:[UIColor clearColor]];
//   [_tabBarController setTabInnerStrokeColor:[UIColor clearColor]];
//   [_tabBarController setTabStrokeColor:[UIColor clearColor]];
//   [_tabBarController setTopEdgeColor:[UIColor clearColor]];
//   */
//  
//  // Uncomment the following to display centered image in the center of the tabbar, similar to Instagram.
//  /*
//   UIImage *img = [UIImage imageNamed:@"sample-center-image"];
//   UIImageView *bottomCenterView = [[UIImageView alloc] initWithImage:img];
//   CGRect rect = _tabBarController.view.frame;
//   bottomCenterView.frame = CGRectMake(rect.size.width/2 - img.size.width/2, rect.size.height - img.size.height,
//   img.size.width, img.size.height);
//   [_tabBarController.view addSubview:bottomCenterView];
//   */
//  
//////  [self.window setRootViewController:self.tabBarController];
////  [UIView  beginAnimations:nil context:NULL];
////  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
////  [UIView setAnimationDuration:0.75];
//  self.tabBarController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
////  self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//  [self presentViewController:self.tabBarController animated:YES completion:^{
//    //null
//  }];
//  
//}

- (void) jerry_test{
  NSString *const FTGooglePlacesAPIBaseURL = @"https://maps.googleapis.com/maps/api/place/search/json?location=39.260275,-120.127764&radius=500&sensor=true&key=AIzaSyC1fb_MtdKucHrAWb7HUoTdI-vcPWz_33k";
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:FTGooglePlacesAPIBaseURL]
                                                         cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                     timeoutInterval:10];
  
  [request setHTTPMethod: @"GET"];
  
  NSError *requestError;
  NSURLResponse *urlResponse = nil;
  
  
  NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
  NSError* error;
  NSDictionary* json = [NSJSONSerialization
                        JSONObjectWithData:response1
                        
                        options:kNilOptions
                        error:&error];
  
  //The results from Google will be an array obtained from the NSDictionary object with the key "results".
  NSArray* places = [json objectForKey:@"results"];
  
  //Write out the data to the console.
  NSLog(@"JERRY Google Data: %@", places);
//  NSLog(@"JERRY google place API: %@", response1);
}

@end
