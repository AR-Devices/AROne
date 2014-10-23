//
//  ARLoginViewController.m
//  AROne
//
//  Created by Chenchen Zheng on 2/14/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARLoginViewController.h"
#import "ARSignupViewController.h"
#import "MBProgressHUD.h"
#import "NSString+ARAdditions.h"
#import "UIAlertView+Addition.h"

@interface ARLoginViewController ()<UITextFieldDelegate>

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

- (void)viewWillAppear:(BOOL)animated {
  NSLog(@"viewWillAppear Called");
  [super viewWillAppear:YES];
  [self.navigationController setNavigationBarHidden:YES animated:YES];

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
    _email.delegate = self;
    [_email setBackground:[UIImage imageNamed:@"input"]];
    [_email setFont:[UIFont fontWithName:@"Avenir-Roman" size:11.0]];
    [_email setTextColor:[UIColor orangeColor]];
    [_email setPlaceholder:@"Email"];
    [_email.layer setCornerRadius:3.0f];
    _email.clipsToBounds = YES;
    _email.keyboardType = UIKeyboardTypeEmailAddress;

    _password = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, divid.size.width,30)];
    _password.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.center = CGPointMake(self.view.bounds.size.width/2, 320);
    _password.adjustsFontSizeToFitWidth = YES;
    _password.delegate = self;
    [_password setBackground:[UIImage imageNamed:@"input"]];
    [_password setFont:[UIFont fontWithName:@"Avenir-Roman" size:11.0]];
    [_password setTextColor:[UIColor orangeColor]];
    [_password setPlaceholder:@"Password"];
    [_password setSecureTextEntry:YES];
    [_password.layer setCornerRadius:3.0f];
    _password.clipsToBounds = YES;

    UIButton *forgetPass = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _email.bounds.size.width, 20)];
    forgetPass.center = CGPointMake(self.view.bounds.size.width/2, 360);
    [forgetPass setTitle:@"Forget your Password?" forState:UIControlStateNormal];
    forgetPass.titleLabel.font =[UIFont fontWithName:@"Avenir-Roman" size:11.0];
    [forgetPass addTarget:self action:@selector(onForget:) forControlEvents:UIControlEventTouchUpInside];
    [forgetPass setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];


    UIImage *login_button = [UIImage imageNamed:@"login_button"];

    UIImageView *login_buttonView = [[UIImageView alloc] initWithImage:login_button];
    UIButton *login_buttonFrame = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, login_button.size.width, login_button.size.height)];
    [login_buttonFrame addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    login_buttonFrame.center = CGPointMake(self.view.bounds.size.width/2, 400);
    [login_buttonFrame addSubview:login_buttonView];
    [login_buttonFrame setTitle:@"Log In" forState:UIControlStateNormal];
    [login_buttonFrame.layer setCornerRadius:3.0f];
    login_buttonFrame.clipsToBounds = YES;

    UILabel *NotaMember = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    NotaMember.center = CGPointMake(self.view.bounds.size.width/2-20, 440);
    NotaMember.backgroundColor = [UIColor clearColor];
    [NotaMember setText: @"Not a Member?"];
    NotaMember.font = [UIFont fontWithName:@"Avenir-Roman" size:11.0];
    [NotaMember setTextColor:[UIColor whiteColor]];

    UIButton *signup = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120,20)];
    signup.center = CGPointMake(self.view.bounds.size.width/2+50, 440);
    [signup setTitle:@"Sign up now!" forState:UIControlStateNormal];
    [signup addTarget:self action:@selector(signupAction:) forControlEvents:UIControlEventTouchUpInside];
    [signup setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    signup.titleLabel.font =[UIFont fontWithName:@"Avenir-Roman" size:11.0];


    [self.view addSubview:arlogoFrame];
    [self.view addSubview:fbFrame];
    [self.view addSubview:gPlusFrame];
    [self.view addSubview:dividFrame];
    [self.view addSubview:_email];
    [self.view addSubview:_password];
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

- (void) signupAction: (UIButton *)sender
{
    //Set self to listen for the message "SecondViewControllerDismissed and run a method when this message is detected
    [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(didSignUpSuccessful:)
                                               name:@"SignUpSuccessful"
                                             object:nil];
    //signup clicked
    //  [self presentViewController:[[ARSignupViewController alloc] init] animated:YES completion:^{
    //    //null
    //  }];
    [self.navigationController pushViewController:[[ARSignupViewController alloc] init] animated:YES];
}

- (void)didSignUpSuccessful:(id) sender
{
    NSLog(@"signup successful!");
[self showHomeView];
}

- (void) loginAction: (id) sender
{
    [self.email resignFirstResponder];
    [self.password resignFirstResponder];
    [self processFieldEntries];
}

- (void) fbButtonTouchHandler: (id) sender
{
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  // The permissions requested from the user
  NSArray *permissionsArray = @[@"user_about_me", @"user_birthday", @"user_location", @"email", @"user_likes"];

  // Login PFUser using Facebook
  [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
//    [self.activityIndicator stopAnimating]; // Hide loading indicat
    if (!user) {
      if (!error) {
        NSLog(@"Uh oh. The user cancelled the Facebook login.");
      } else {
        NSLog(@"Uh oh. An error occurred: %@", error);
      }
    } else if (user.isNew) {
      NSLog(@"User with facebook signed up and logged in!");
      [self populateFBData];
    } else {
      NSLog(@"User with facebook logged in!");
      //      [self.navigationController pushViewController:[[CQProfileViewController alloc] init] animated:YES];
      [self showHomeView];
    }

  }];
//  [_activityIndicator startAnimating]; // Show loading indicator until login is finished
}

- (void) onForget:(id) sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Are you sure you want to reset your password?" delegate:nil cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [alert showWithCompletion:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            NSLog(@"haha %@", self.email.text);
            if ([NSString isStringEmpty:self.email.text] ||
                ![self isValidEmail:self.email.text]) {
                hud.labelText = @"Type in your email address";
                [hud show:YES];
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    // Do something...
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                });
            } else {
                [PFUser requestPasswordResetForEmailInBackground:self.email.text];
                hud.labelText = @"Please check your email to change your password.";
                [hud show:YES];
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    // Do something...
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                });
            }
        }
    }];
}

- (void)showHomeView
{
  NSLog(@"showHomeView!");
  [self dismissViewControllerAnimated:YES completion:^{
    //null
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
  }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  
  return YES;
}


- (void) populateFBData
{
  FBRequest *request = [FBRequest requestForMe];
  // Send request to Facebook
  [request startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
    if (!error) {
  //      upload info to parse
    PFQuery *query = [PFUser query];
    PFUser *PU = [PFUser currentUser];
    [query whereKey:@"username" equalTo:PU.username];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    NSLog(@"objects are %@", objects);
    PFObject *Puser = [objects objectAtIndex:0];
    [Puser setObject:user.name forKey:@"name"];
    //        Puser[@"name"] = user.name;
    @try {
      [Puser setObject:[user objectForKey:@"email"] forKey:@"email"];
    } @catch (NSException *exception) {
      NSLog(@"Puser email exception %@", exception);
    }
    @try {
      [Puser setObject:[[user objectForKey:@"location"] objectForKey:@"name"] forKey:@"location"];

    } @catch (NSException *exception) {
      NSLog(@"Puser location exception %@", exception);
    }

    @try {
        [Puser setObject:user.birthday forKey:@"birthday"];
    }
    @catch (NSException *exception) {
        NSLog(@"Puser birthday exception %@", exception);
    }
      
      @try {
          [Puser setObject:user.first_name forKey:@"displayname"];
      }
      @catch (NSException *exception) {
          NSLog(@"Puser  exception displayname %@", exception);
      }
      
      @try {
          [Puser setObject:[user objectForKey:@"gender"] forKey:@"gender"];
      }
      @catch (NSException *exception) {
          NSLog(@"Puser  exception displayname %@", exception);
      }
      
//        Puser[@"email"] = [user objectForKey:@"email"];
//        Puser[@"location"] = [[user objectForKey:@"location"] objectForKey:@"name"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?square", user.id]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    PFFile *imageFile = [PFFile fileWithName:@"icon_square" data:data];
//        UIImage *profilePic = [[UIImage alloc] initWithData:data];
    Puser[@"userIcon"] = imageFile;
    [Puser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
      [self showHomeView];
    }];
      }];
    } else {
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                          message:error.localizedDescription
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
      [alertView show];
    }
  }];
}

- (void)saveDone
{
  [self showHomeView];
}

//keyboard dismissal
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch * touch = [touches anyObject];
  if(touch.phase == UITouchPhaseBegan) {
    [_email resignFirstResponder];
    [_password resignFirstResponder];
  }
}

- (void)processFieldEntries {
	// Get the username text, store it in the app delegate for now
	NSString *username = self.email.text;
	NSString *password = self.password.text;
  NSLog(@"user name is %@", username);
	NSString *noUsernameText = @"username";
	NSString *noPasswordText = @"password";
	NSString *errorText = @"No ";
	NSString *errorTextJoin = @" or ";
	NSString *errorTextEnding = @" entered";
	BOOL textError = NO;
  
	// Messaging nil will return 0, so these checks implicitly check for nil text.
	if (username.length == 0 || password.length == 0) {
		textError = YES;
    
		// Set up the keyboard for the first field missing input:
		if (password.length == 0) {
			[self.email becomeFirstResponder];
		}
		if (username.length == 0) {
			[self.password becomeFirstResponder];
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
  
	if (textError) {
		errorText = [errorText stringByAppendingString:errorTextEnding];
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorText message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
		[alertView show];
		return;
	}
  
  [self doLoginWithUsername];
  

  //signup

//  - (void) done:(id)sender {
//    PFUser *user = [PFUser user];
//    user.username = username;
//    user.password = password;
//    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//     {
//       if (error) // Something went wrong
//       {
//         // Display an alert view to show the error message
//         UIAlertView *alertView =
//         [[UIAlertView alloc] initWithTitle:[[error userInfo] objectForKey:@"error"]
//                                    message:nil
//                                   delegate:self
//                          cancelButtonTitle:nil
//                          otherButtonTitles:@"Ok", nil];
//         [alertView show];
//         
//         // Bring the keyboard back up, user will probably need to change something
//         [usernameField becomeFirstResponder];
//         return;
//       }
//       
//       // Success!
//       // We push the next view on the navigation stack
//       PAWWallViewController *wallViewController =
//       [[PAWWallViewController alloc] initWithNibName:nil bundle:nil];
//       UINavigationController *navController = (UINavigationController *)self.presentingViewController;
//       [navController pushViewController:wallViewController animated:NO];
//       
//       // And since this view controller was presented modally, we dismiss ourself
//       [self dismissModalViewControllerAnimated:YES];
//     }];
//  }
  
}

- (void)doLoginWithUsername {
  
  [PFUser logInWithUsernameInBackground:self.email.text password:self.password.text block:^(PFUser *user, NSError *error) {
    if (user) {
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
        alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                               message:error.localizedDescription
                                              delegate:self
                                     cancelButtonTitle:nil
                                     otherButtonTitles:@"Ok", nil];
      }
      // Show the alert view
      [alertView show];
      
      // Bring the keyboard back up, user will probably need to change something
      //      [usernameField becomeFirstResponder];
    }
  }];
}

- (BOOL)isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


@end
