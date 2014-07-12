//
//  ARWelcomeViewController.m
//  AROne
//
//  Created by Chenchen Zheng on 2/19/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARWelcomeViewController.h"
#import "ARLoginViewController.h"

@interface ARWelcomeViewController ()

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
  
  // Check if user is logged in
  if (![PFUser currentUser]) {
    // Customize the Log In View Controller
    ARLoginViewController *logInViewController = [[ARLoginViewController alloc] init];    
    // Present Log In View Controller
    logInViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:logInViewController] animated:YES completion:NULL];
  } else {
    //
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

@end
