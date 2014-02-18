//
//  ARLoginViewController.m
//  AROne
//
//  Created by Chenchen Zheng on 2/14/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARLoginViewController.h"
#import "MBProgressHUD.h"

@interface ARLoginViewController ()

@property (nonatomic) UITextField *email;
@property (nonatomic) UITextField *password;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation ARLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}

- (void)viewDidLoad
{
  NSLog(@"loginView Called!");
  [super viewDidLoad];
  // Custom initialization
  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_splashpage"]];
  
  [self setLoginView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLoginView
{
  
  UIImage *arlogo = [UIImage imageNamed:@"arlogo"];
  UIImageView *arlogoView = [[UIImageView alloc] initWithImage:arlogo];
  UIView *arlogoFrame = [[UIView alloc]initWithFrame:CGRectMake(0, 0, arlogo.size.width,arlogo.size.height)];
  arlogoFrame.center = CGPointMake(self.view.bounds.size.width/2, 80);
  [arlogoFrame addSubview:arlogoView];
  
  UILabel *signInOpt = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
  signInOpt.center = CGPointMake(self.view.bounds.size.width/2, 150);
  signInOpt.backgroundColor = [UIColor clearColor];
  signInOpt.textAlignment = NSTextAlignmentCenter;
  [signInOpt setText: @"Sign in with"];
  [signInOpt setTextColor:[UIColor whiteColor]];
  
  UIImage *fb = [UIImage imageNamed:@"fb"];
  UIImageView *fbView = [[UIImageView alloc] initWithImage:fb];
  UIButton *fbFrame = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, fb.size.width,fb.size.height)];
  fbFrame.center = CGPointMake(self.view.bounds.size.width/2-60, 200);
  [fbFrame addTarget:self action:@selector(fbButtonTouchHandler:) forControlEvents:UIControlEventTouchDown];
  [fbFrame addSubview:fbView];
  
  
  UIImage  *gPlus= [UIImage imageNamed:@"g+"];
  UIImageView *gPlusView = [[UIImageView alloc] initWithImage:gPlus];
  UIButton *gPlusFrame = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, gPlus.size.width,gPlus.size.height)];
  gPlusFrame.center = CGPointMake(self.view.bounds.size.width/2+60, 200);
  [gPlusFrame addSubview:gPlusView];
  
  UIImage *divid = [UIImage imageNamed:@"divid"];
  UIImageView *dividView = [[UIImageView alloc] initWithImage:divid];
  UIView *dividFrame = [[UIView alloc]initWithFrame:CGRectMake(0, 0, divid.size.width,divid.size.height)];
  dividFrame.center = CGPointMake(self.view.bounds.size.width/2, 240);
  [dividFrame addSubview:dividView];
  
  //padding view is for left margin to not touch the edge
  _email = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, divid.size.width,30)];
  _email.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
  _email.leftViewMode = UITextFieldViewModeAlways;
  _email.center = CGPointMake(self.view.bounds.size.width/2, 280);
  _email.adjustsFontSizeToFitWidth = YES;
  [_email setBackground:[UIImage imageNamed:@"input"]];
  [_email setFont:[UIFont fontWithName:@"Avenir-Roman" size:11.0]];
  [_email setTextColor:[UIColor orangeColor]];
  [_email setPlaceholder:@"Email"];
  
  _password = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, divid.size.width,30)];
  _password.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
  _password.leftViewMode = UITextFieldViewModeAlways;
  _password.center = CGPointMake(self.view.bounds.size.width/2, 320);
  _password.adjustsFontSizeToFitWidth = YES;
  [_password setBackground:[UIImage imageNamed:@"input"]];
  [_password setFont:[UIFont fontWithName:@"Avenir-Roman" size:11.0]];
  [_password setTextColor:[UIColor orangeColor]];
  [_password setPlaceholder:@"Password"];
  [_password setSecureTextEntry:YES];
  
  [[UISwitch appearance] setOnTintColor:[UIColor orangeColor]];
  //[[UISwitch appearance] setTintColor:[UIColor colorWithRed:213.0/255 green:183.0/255 blue:165.0/255 alpha:1.000]];
  // [[UISwitch appearance] setThumbTintColor:[UIColor colorWithRed:125.0/255 green:30.0/255 blue:21.0/255 alpha:1.000]];
  
  [[UISwitch appearance] setOnImage:fb];
  [[UISwitch appearance] setOffImage:gPlus];
  UISwitch *rememberMe = [[UISwitch alloc] init];//WithFrame:CGRectMake(0, 0, switch_button.size.width, switch_button.size.height)];
  rememberMe.transform = CGAffineTransformMakeScale(0.5, 0.5);
  rememberMe.center = CGPointMake(self.view.bounds.size.width/2-100, 360);
  [rememberMe addTarget: self action: @selector(rememberMe:) forControlEvents:UIControlEventValueChanged];

  
  UILabel *rememberMeText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
  rememberMeText.center = CGPointMake(self.view.bounds.size.width/2-30, 360);
  rememberMeText.backgroundColor = [UIColor clearColor];
  [rememberMeText setText: @"Remember me"];
  rememberMeText.font = [UIFont fontWithName:@"Avenir-Roman" size:11.0];
  [rememberMeText setTextColor:[UIColor whiteColor ]];
  
  UIButton *forgetPass = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120,20)];
  forgetPass.center = CGPointMake(self.view.bounds.size.width/2+60, 360);
  [forgetPass setTitle:@"Forget your Password?" forState:UIControlStateNormal];
  forgetPass.titleLabel.font =[UIFont fontWithName:@"Avenir-Roman" size:11.0];
  
  UIImage *login_button = [UIImage imageNamed:@"login_button"];
  UIImageView *login_buttonView = [[UIImageView alloc] initWithImage:login_button];
  UIButton *login_buttonFrame = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, login_button.size.width, login_button.size.height)];
  [login_buttonFrame addTarget:self action:@selector(loginHandler:) forControlEvents:UIControlEventValueChanged];
  login_buttonFrame.center = CGPointMake(self.view.bounds.size.width/2, 400);
  [login_buttonFrame addSubview:login_buttonView];
  [login_buttonFrame setTitle:@"Log In" forState:UIControlStateNormal];
  
  UILabel *NotaMember = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
  NotaMember.center = CGPointMake(self.view.bounds.size.width/2-20, 440);
  NotaMember.backgroundColor = [UIColor clearColor];
  [NotaMember setText: @"Not a Member?"];
  NotaMember.font = [UIFont fontWithName:@"Avenir-Roman" size:11.0];
  [NotaMember setTextColor:[UIColor whiteColor]];
  
  UIButton *signup = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120,20)];
  signup.center = CGPointMake(self.view.bounds.size.width/2+50, 440);
  [signup setTitle:@"Sign up now!" forState:UIControlStateNormal];
  [signup setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
  signup.titleLabel.font =[UIFont fontWithName:@"Avenir-Roman" size:11.0];
  
  
  [self.view addSubview:arlogoFrame];
  [self.view addSubview:fbFrame];
  [self.view addSubview:gPlusFrame];
  [self.view addSubview:dividFrame];
  [self.view addSubview:_email];
  [self.view addSubview:_password];
  [self.view addSubview:rememberMe];
  [self.view addSubview:rememberMeText];
  [self.view addSubview:forgetPass];
  [self.view addSubview:signInOpt];
  [self.view addSubview:login_buttonFrame];
  [self.view addSubview:NotaMember];
  [self.view addSubview:signup];
}

- (void) rememberMe: (UISwitch *)sender
{
  if (sender.on) NSLog(@"On");
  else  NSLog(@"Off");
}

- (void) loginHandler: (id) sender
{
  
}
- (void) fbButtonTouchHandler: (id) sender
{
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  // The permissions requested from the user
  NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location", @"email", @"user_work_history", @"user_likes"];
  
  // Login PFUser using Facebook
  [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
//    [self.activityIndicator stopAnimating]; // Hide loading indicator
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if (!user) {
      if (!error) {
        NSLog(@"Uh oh. The user cancelled the Facebook login.");
      } else {
        NSLog(@"Uh oh. An error occurred: %@", error);
      }
    } else if (user.isNew) {
      NSLog(@"User with facebook signed up and logged in!");
      [self showHomeView];
    } else {
      NSLog(@"User with facebook logged in!");
      //      [self.navigationController pushViewController:[[CQProfileViewController alloc] init] animated:YES];
      [self showHomeView];
    }

  }];
//  [_activityIndicator startAnimating]; // Show loading indicator until login is finished
}

- (void)showHomeView
{
  NSLog(@"showHomeView!");
  [self dismissViewControllerAnimated:YES completion:^{
    //null
  }];
}

//keyboard dismissal
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch * touch = [touches anyObject];
  if(touch.phase == UITouchPhaseBegan) {
    [_email resignFirstResponder];
    [_password resignFirstResponder];
  }
}
@end
