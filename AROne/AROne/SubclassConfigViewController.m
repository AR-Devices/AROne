//
//  SubclassConfigViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/15/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "SubclassConfigViewController.h"
#import "MyLogInViewController.h"
#import "MySignUpViewController.h"
//import vendor TabBar Controller
#import "AKTabBarController.h"
//import Pages
#import "ARSummaryViewController.h"
#import "ARScoreboardViewController.h"
#import "ARTrailSummaryViewController.h"
//FIXME temp put it here to see the view
#import "ARSummaryGraphViewController.h"

@interface SubclassConfigViewController ()
@property (nonatomic, strong) AKTabBarController *tabBarController;

@end
@implementation SubclassConfigViewController


#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([PFUser currentUser]) {
        self.welcomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]];
    } else {
        self.welcomeLabel.text = NSLocalizedString(@"Not logged in", nil);

    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Check if user is logged in
//    if ([PFUser currentUser]) {
//        // Customize the Log In View Controller
//        MyLogInViewController *logInViewController = [[MyLogInViewController alloc] init];
//        logInViewController.delegate = self;
//        logInViewController.facebookPermissions = @[@"friends_about_me"];
//        logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsFacebook | PFLogInFieldsSignUpButton | PFLogInFieldsDismissButton;
//        
//        // Customize the Sign Up View Controller
//        MySignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
//        signUpViewController.delegate = self;
//        signUpViewController.fields = PFSignUpFieldsDefault | PFSignUpFieldsAdditional;
//        logInViewController.signUpController = signUpViewController;
//        
//        // Present Log In View Controller
//        [self presentViewController:logInViewController animated:YES completion:NULL];
//    }
  [self createTabBar];
  [UIView  beginAnimations:nil context:NULL];
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
  [UIView setAnimationDuration:0.75];
  [self.navigationController pushViewController:self.tabBarController animated:YES];
  [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
  [UIView commitAnimations];
}


#pragma mark - PFLogInViewControllerDelegate
- (void) createTabBar
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
  
}
// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    if (username && password && username.length && password.length) {
        return YES;
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO;
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    NSLog(@"User dismissed the logInViewController");
}


#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) {
            informationComplete = NO;
            break;
        }
    }
    
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}


#pragma mark - ()

- (IBAction)logOutButtonTapAction:(id)sender {
    [PFUser logOut];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
