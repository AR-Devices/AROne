//
//  ARSignupViewController.m
//  AROne
//
//  Created by Chenchen Zheng on 2/17/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARSignupViewController.h"

@interface ARSignupViewController () <UITextFieldDelegate>
@property (nonatomic) UITextField *email;
@property (nonatomic) UITextField *password;
@property (nonatomic) UITextField *password_confirm;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation ARSignupViewController

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_splashpage"]];
    [self setSignupPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setSignupPage
{
  UIImage *arlogo = [UIImage imageNamed:@"arlogo"];
  UIImageView *arlogoView = [[UIImageView alloc] initWithImage:arlogo];
  UIView *arlogoFrame = [[UIView alloc]initWithFrame:CGRectMake(0, 0, arlogo.size.width,arlogo.size.height)];
  arlogoFrame.center = CGPointMake(self.view.bounds.size.width/2, 80);
  [arlogoFrame addSubview:arlogoView];
  
  UIImage *signup_button = [UIImage imageNamed:@"login_button"];
  UIImageView *signup_buttonView = [[UIImageView alloc] initWithImage:signup_button];
  UIButton *signup_buttonFrame = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, signup_button.size.width, signup_button.size.height)];
  [signup_buttonFrame addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
  signup_buttonFrame.center = CGPointMake(self.view.bounds.size.width/2, 350);
  [signup_buttonFrame addSubview:signup_buttonView];
  [signup_buttonFrame setTitle:@"Sign up" forState:UIControlStateNormal];
  
  _email = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, signup_button.size.width, signup_button.size.height)];
  _email.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
  _email.leftViewMode = UITextFieldViewModeAlways;
  _email.center = CGPointMake(self.view.bounds.size.width/2, 200);
  _email.adjustsFontSizeToFitWidth = YES;
  _email.delegate = self;
  [_email setBackground:[UIImage imageNamed:@"input"]];
  [_email setFont:[UIFont fontWithName:@"Avenir-Roman" size:11.0]];
  [_email setTextColor:[UIColor orangeColor]];
  [_email setPlaceholder:@"Email"];
  
  _password = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, signup_button.size.width, signup_button.size.height)];
  _password.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
  _password.leftViewMode = UITextFieldViewModeAlways;
  _password.center = CGPointMake(self.view.bounds.size.width/2, 250);
  _password.adjustsFontSizeToFitWidth = YES;
  _password.delegate = self;
  [_password setBackground:[UIImage imageNamed:@"input"]];
  [_password setFont:[UIFont fontWithName:@"Avenir-Roman" size:11.0]];
  [_password setTextColor:[UIColor orangeColor]];
  [_password setPlaceholder:@"Create Password"];
  [_password setSecureTextEntry:YES];
  
  _password_confirm = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, signup_button.size.width, signup_button.size.height)];
  _password_confirm.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
  _password_confirm.leftViewMode = UITextFieldViewModeAlways;
  _password_confirm.center = CGPointMake(self.view.bounds.size.width/2, 300);
  _password_confirm.adjustsFontSizeToFitWidth = YES;
  _password_confirm.delegate = self;
  [_password_confirm setBackground:[UIImage imageNamed:@"input"]];
  [_password_confirm setFont:[UIFont fontWithName:@"Avenir-Roman" size:11.0]];
  [_password_confirm setTextColor:[UIColor orangeColor]];
  [_password_confirm setPlaceholder:@"Confirm Password"];
  [_password_confirm setSecureTextEntry:YES];
  

  
  [self.view addSubview:arlogoFrame];
  [self.view addSubview:_email];
  [self.view addSubview:_password];
  [self.view addSubview:_password_confirm];
  [self.view addSubview:signup_buttonFrame];


}

- (void) loginAction: (id) sender
{
  [self.email resignFirstResponder];
  [self.password resignFirstResponder];
  [self processFieldEntries];
}
- (void)processFieldEntries {
	// Get the username text, store it in the app delegate for now
	NSString *username = self.email.text;
	NSString *password = self.password.text;
  NSString *password_confirm = self.password_confirm.text;
  NSLog(@"user name is %@", username);
	NSString *noUsernameText = @"username";
	NSString *noPasswordText = @"password";
  NSString *noPasswordConfirmText = @"confirm password";
	NSString *errorText = @"No ";
	NSString *errorTextJoin = @" or ";
	NSString *errorTextEnding = @" entered";
	BOOL textError = NO;
  
	// Messaging nil will return 0, so these checks implicitly check for nil text.
	if (username.length == 0 || password.length == 0 || password_confirm.length == 0) {
		textError = YES;
    
		// Set up the keyboard for the first field missing input:
		if (password.length == 0) {
			[self.email becomeFirstResponder];
		}
		if (username.length == 0) {
			[self.password becomeFirstResponder];
		}
    if(password_confirm.length == 0){
      [self.password_confirm becomeFirstResponder];
    }
	}
  
	if (username.length == 0) {
		textError = YES;
		errorText = [errorText stringByAppendingString:noUsernameText];
	}
  
	if (password.length == 0) {
		textError = YES;
		if (username.length == 0) {
			errorText = [errorText stringByAppendingString:errorTextJoin];
		}
		errorText = [errorText stringByAppendingString:noPasswordText];
	}
  
  if (password_confirm.length == 0) {
		textError = YES;
		if (username.length == 0 || password.length == 0) {
			errorText = [errorText stringByAppendingString:errorTextJoin];
		}
		errorText = [errorText stringByAppendingString:noPasswordConfirmText];
	}
  
	if (textError) {
		errorText = [errorText stringByAppendingString:errorTextEnding];
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorText message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
		[alertView show];
		return;
	}
  
  [self doSignupWithUsername];
  
}

- (void)doSignupWithUsername {
  PFUser *newUser = [[PFUser alloc] init];
  if([_password.text isEqualToString:_password_confirm.text]){
  [newUser setPassword:_password.text];
  [newUser setUsername:_email.text];
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
      if (succeeded) {
        // Create next view controller to show
        [self showHomeView];
      }
      else // Login failed
      {
        UIAlertView *alertView = nil;
        
        if (error == nil) // Login failed because of an invalid username and password
        {
          // Create an alert view to tell the user
          alertView = [[UIAlertView alloc] initWithTitle:@"Couldn't log in:"
                       "\nThe username or password were wrong."
                                                 message:nil
                                                delegate:self
                                       cancelButtonTitle:nil
                                       otherButtonTitles:@"Ok", nil];
        }
        else // Login failed for another reason
        {
          // Create an alert view to tell the user
          alertView = [[UIAlertView alloc] initWithTitle:[[error userInfo] objectForKey:@"error"]
                                                 message:nil
                                                delegate:self
                                       cancelButtonTitle:nil
                                       otherButtonTitles:@"Ok", nil];
        }
        // Show the alert view
        [alertView show];
        
        // Bring the keyboard back up, user will probably need to change something
        //      [usernameField becomeFirstResponder];
      
  
      }}];
    }else{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"confirmed password no match" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
		[alertView show];
  }
}
- (void)showHomeView
{
  NSLog(@"showHomeView!");
  [self dismissViewControllerAnimated:YES completion:^{
    //null
  }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  
  return YES;
}
@end
