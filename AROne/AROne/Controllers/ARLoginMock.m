//
//  ARLoginMock.m
//  AROne
//
//  Created by Jerry Wu on 2/12/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARLoginMock.h"

@interface ARLoginMock ()

@end

@implementation ARLoginMock

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"splashpage"]];
  
  UIImage *arlogo = [UIImage imageNamed:@"arlogo"];
  UIImageView *arlogoView = [[UIImageView alloc] initWithImage:arlogo];
  UIView *arlogoFrame = [[UIView alloc]initWithFrame:CGRectMake(0, 0, arlogo.size.width,arlogo.size.height)];
  arlogoFrame.center = CGPointMake(self.view.bounds.size.width/2, 80);
  [arlogoFrame addSubview:arlogoView];

  UILabel *signInOpt = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
  signInOpt.center = CGPointMake(self.view.bounds.size.width/2, 150);
  signInOpt.backgroundColor = [UIColor clearColor];
  [signInOpt setText: @"Sign in with"];
  [signInOpt setTextColor:[UIColor whiteColor ]];

  UIImage *fb = [UIImage imageNamed:@"fb"];
  UIImageView *fbView = [[UIImageView alloc] initWithImage:fb];
  UIButton *fbFrame = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, fb.size.width,fb.size.height)];
  fbFrame.center = CGPointMake(self.view.bounds.size.width/2-60, 200);
  [fbFrame addSubview:fbView];
  
  
  UIImage  * gPlus= [UIImage imageNamed:@"g+"];
  UIImageView *gPlusView = [[UIImageView alloc] initWithImage:gPlus];
  UIButton *gPlusFrame = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, gPlus.size.width,gPlus.size.height)];
  gPlusFrame.center = CGPointMake(self.view.bounds.size.width/2+60, 200);
  [gPlusFrame addSubview:gPlusView];
  
  UIImage *divid = [UIImage imageNamed:@"divid"];
  UIImageView *dividView = [[UIImageView alloc] initWithImage:divid];
  UIView *dividFrame = [[UIView alloc]initWithFrame:CGRectMake(0, 0, divid.size.width,divid.size.height)];
  dividFrame.center = CGPointMake(self.view.bounds.size.width/2, 240);
  [dividFrame addSubview:dividView];
  

  UITextView *Email = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, divid.size.width,30)];
  Email.center = CGPointMake(self.view.bounds.size.width/2, 280);
  [Email setTextColor:[UIColor orangeColor]];
  [Email setText:@"Email"];
  
  UITextView *Pass = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, divid.size.width,30)];
  Pass.center = CGPointMake(self.view.bounds.size.width/2, 320);
  [Pass setTextColor:[UIColor orangeColor]];
  [Pass setText:@"Password"];
  
  [[UISwitch appearance] setOnTintColor:[UIColor orangeColor]];
  //[[UISwitch appearance] setTintColor:[UIColor colorWithRed:213.0/255 green:183.0/255 blue:165.0/255 alpha:1.000]];
 // [[UISwitch appearance] setThumbTintColor:[UIColor colorWithRed:125.0/255 green:30.0/255 blue:21.0/255 alpha:1.000]];

  [[UISwitch appearance] setOnImage:fb];
  [[UISwitch appearance] setOffImage:gPlus];
  //UIImage *switch_button = [UIImage imageNamed:@"switch_button"];
  UISwitch *rememberMe = [[UISwitch alloc] init];//WithFrame:CGRectMake(0, 0, switch_button.size.width, switch_button.size.height)];
  rememberMe.transform = CGAffineTransformMakeScale(0.5, 0.5);
  rememberMe.center = CGPointMake(self.view.bounds.size.width/2-100, 360);

  UILabel *rememberMeText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
  rememberMeText.center = CGPointMake(self.view.bounds.size.width/2-30, 360);
  rememberMeText.backgroundColor = [UIColor clearColor];
  [rememberMeText setText: @"Remember me"];
  rememberMeText.font = [UIFont fontWithName:@"Avenir-Roman" size:11.0];
  [rememberMeText setTextColor:[UIColor whiteColor ]];
  
  UIButton *forgetPass = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120,20)];
  forgetPass.center = CGPointMake(self.view.bounds.size.width/2+60, 360);
  [forgetPass setTitle:@"Forget your Password?" forState:UIControlStateNormal];
  forgetPass.font =[UIFont fontWithName:@"Avenir-Roman" size:11.0];
  
  UIImage *login_button = [UIImage imageNamed:@"login_button"];
  UIImageView *login_buttonView = [[UIImageView alloc] initWithImage:login_button];
  UIButton *login_buttonFrame = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, login_button.size.width, login_button.size.height)];
  login_buttonFrame.center = CGPointMake(self.view.bounds.size.width/2, 400);
  [login_buttonFrame addSubview:login_buttonView];
  [login_buttonFrame setTitle:@"Log In" forState:UIControlStateNormal];
  
  UILabel *NotaMember = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
  NotaMember.center = CGPointMake(self.view.bounds.size.width/2-20, 440);
  NotaMember.backgroundColor = [UIColor clearColor];
  [NotaMember setText: @"Not a Member?"];
  NotaMember.font = [UIFont fontWithName:@"Avenir-Roman" size:11.0];
  [NotaMember setTextColor:[UIColor blackColor]];
  
  UIButton *signup = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120,20)];
  signup.center = CGPointMake(self.view.bounds.size.width/2+50, 440);
  [signup setTitle:@"Sign up now!" forState:UIControlStateNormal];
  [signup setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
  signup.font =[UIFont fontWithName:@"Avenir-Roman" size:11.0];


  [self.view addSubview:arlogoFrame];
  [self.view addSubview:fbFrame];
  [self.view addSubview:gPlusFrame];
  [self.view addSubview:dividFrame];
  [self.view addSubview:Email];
  [self.view addSubview:Pass];
  [self.view addSubview:rememberMe];
  [self.view addSubview:rememberMeText];
  [self.view addSubview:forgetPass];
  [self.view addSubview:signInOpt];
  [self.view addSubview:login_buttonFrame];
  [self.view addSubview:NotaMember];
  [self.view addSubview:signup];







}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
