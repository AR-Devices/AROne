//
//  ARWelcomeViewController.m
//  AROne
//
//  Created by Chenchen Zheng on 2/19/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARWelcomeViewController.h"
#import "ARLoginViewController.h"
#import "CCBaseNavigationController.h"
#import "ARSummaryTableViewController.h"
#import "ARFriendListController.h"
#import "ARSuggestFriendsViewController.h"
#import "ARSettingsViewController.h"

#import "ARProfileViewController.h"

#import <MSDynamicsDrawerViewController.h>
#import "ARMenuViewController.h"

@interface ARWelcomeViewController ()

//@property (nonatomic, strong) AKTabBarController *tabBarController;


@end

@implementation ARWelcomeViewController
@synthesize locationManager = _locationManager;


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
  [self.locationManager startUpdatingLocation];

  // Check if user is logged in
  if (![PFUser currentUser]) {
    // Customize the Log In View Controller
    ARLoginViewController *logInViewController = [[ARLoginViewController alloc] init];    
    // Present Log In View Controller
    logInViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    
    
    
    
    
    

    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:logInViewController] animated:YES completion:NULL];
  } else {
    [self startHomeController];
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

-(void) startHomeController {
  self.dynamicsDrawerViewController = [MSDynamicsDrawerViewController new];
//  self.dynamicsDrawerViewController.delegate = self;
  [self.dynamicsDrawerViewController addStylersFromArray:@[[MSDynamicsDrawerScaleStyler styler], [MSDynamicsDrawerFadeStyler styler]] forDirection:MSDynamicsDrawerDirectionLeft];
//  [self.dynamicsDrawerViewController addStylersFromArray:@[[MSDynamicsDrawerParallaxStyler styler]] forDirection:MSDynamicsDrawerDirectionRight];
  
  ARMenuViewController *menuViewController = [ARMenuViewController new];
  menuViewController.dynamicsDrawerViewController = self.dynamicsDrawerViewController;
  [self.dynamicsDrawerViewController setDrawerViewController:menuViewController forDirection:MSDynamicsDrawerDirectionLeft];
  //the first page in menus to be shown.
  [menuViewController transitionToViewController:MSPaneViewControllerTypeSummary];

//  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//  self.window.rootViewController = self.dynamicsDrawerViewController;
//  [self.window makeKeyAndVisible];
//  [self.window addSubview:self.windowBackground];
//  [self.window sendSubviewToBack:self.windowBackground];
    [self presentViewController:self.dynamicsDrawerViewController animated:YES completion:^{
        //null
    }];

  
  
  
  
  
  
//    UITabBarController *tab = [UITabBarController new];
//    CCBaseNavigationController *first = [[CCBaseNavigationController alloc] initWithRootViewController:[ARSummaryTableViewController new]];
//    [first setTitle:@"Summary"];
//    CCBaseNavigationController *second =[[CCBaseNavigationController alloc] initWithRootViewController:[ARFriendListController new]];
//    [second setTitle:@"Friends"];
//    CCBaseNavigationController *third =[[CCBaseNavigationController alloc] initWithRootViewController:[ARSuggestFriendsViewController new]];
//    [third setTitle:@"SuggestFriends"];
//    CCBaseNavigationController *profile = [[CCBaseNavigationController alloc] initWithRootViewController:[ARProfileViewController new]];
//    [profile setTitle:@"Profile"];
//    CCBaseNavigationController *settings = [[CCBaseNavigationController alloc] initWithRootViewController:[ARSettingsViewController new]];
//    [settings setTitle:@"Settings"];
//    [tab setViewControllers:[NSArray arrayWithObjects:first,second,third, profile, settings,nil]];
//  
//    [self presentViewController:tab animated:YES completion:^{
//      //null
//    }];
}
- (NSString *)descriptionForPaneState:(MSDynamicsDrawerPaneState)paneState
{
  switch (paneState) {
    case MSDynamicsDrawerPaneStateOpen:
      return @"MSDynamicsDrawerPaneStateOpen";
    case MSDynamicsDrawerPaneStateClosed:
      return @"MSDynamicsDrawerPaneStateClosed";
    case MSDynamicsDrawerPaneStateOpenWide:
      return @"MSDynamicsDrawerPaneStateOpenWide";
    default:
      return nil;
  }
}

- (NSString *)descriptionForDirection:(MSDynamicsDrawerDirection)direction
{
  switch (direction) {
    case MSDynamicsDrawerDirectionTop:
      return @"MSDynamicsDrawerDirectionTop";
    case MSDynamicsDrawerDirectionLeft:
      return @"MSDynamicsDrawerDirectionLeft";
    case MSDynamicsDrawerDirectionBottom:
      return @"MSDynamicsDrawerDirectionBottom";
    case MSDynamicsDrawerDirectionRight:
      return @"MSDynamicsDrawerDirectionRight";
    default:
      return nil;
  }
}

#pragma mark - MSDynamicsDrawerViewControllerDelegate

- (void)dynamicsDrawerViewController:(MSDynamicsDrawerViewController *)drawerViewController mayUpdateToPaneState:(MSDynamicsDrawerPaneState)paneState forDirection:(MSDynamicsDrawerDirection)direction
{
  NSLog(@"Drawer view controller may update to state `%@` for direction `%@`", [self descriptionForPaneState:paneState], [self descriptionForDirection:direction]);
}

- (void)dynamicsDrawerViewController:(MSDynamicsDrawerViewController *)drawerViewController didUpdateToPaneState:(MSDynamicsDrawerPaneState)paneState forDirection:(MSDynamicsDrawerDirection)direction
{
  NSLog(@"Drawer view controller did update to state `%@` for direction `%@`", [self descriptionForPaneState:paneState], [self descriptionForDirection:direction]);
}

//-----------------------------------GEO Location

/**
 Conditionally enable the Search/Add buttons:
 If the location manager is generating updates, then enable the buttons;
 If the location manager is failing, then disable the buttons.
 */
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
  NSLog(@"JERRY: didUPdateTOLocation");
  [self insertCurrentLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
}

/**
 Return a location manager -- create one if necessary.
 */
- (CLLocationManager *)locationManager {
	
  if (_locationManager != nil) {
		return _locationManager;
	}
	
	_locationManager = [[CLLocationManager alloc] init];
  _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
  _locationManager.delegate = self;
  _locationManager.purpose = @"Your current location is used to demonstrate PFGeoPoint and Geo Queries.";
	
	return _locationManager;
}

- (void)insertCurrentLocation{
	// If it's not possible to get a location, then return.
	CLLocation *location = self.locationManager.location;
	if (!location) {
		return;
	}
  
	// Configure the new event with information from the location.
	CLLocationCoordinate2D coordinate = [location coordinate];
  PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//  PFObject *object = [PFObject objectWithClassName:@"User"];
  PFUser * object = [PFUser currentUser];
  [object setObject:geoPoint forKey:@"geolocation"];
  
  [object saveEventually:^(BOOL succeeded, NSError *error) {
    if (succeeded) {
      NSLog(@"geolocation uploaded correctly");
      [self.locationManager stopUpdatingLocation];
    }
  }];
}
@end
