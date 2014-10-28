//
//  ARSignupViewController.m
//  AROne
//
//  Created by Chenchen Zheng on 2/17/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARSignupViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface ARSignupViewController () <UITextFieldDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic) UITextField *displayName;
@property (nonatomic) UITextField *email;
@property (nonatomic) UITextField *password;
@property (nonatomic, strong) UIButton *photo;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIImage *uploadImage;

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
  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Up"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(signUpPressed)];
  self.navigationItem.rightBarButtonItem = rightButton;
    [self setSignupPage];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:NO];
  
  [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setSignupPage
{
  UIImage *signup_template = [UIImage imageNamed:@"signup_bg"];
  UIImageView *signup_templateView = [[UIImageView alloc] initWithImage:signup_template];
  UIView *signup_templateFrame = [[UIView alloc] initWithFrame:CGRectMake(5, 30, signup_template.size.width, signup_template.size.height)];
  [signup_templateFrame addSubview:signup_templateView];
  
  UIImage *photo_button = [UIImage imageNamed:@"addPhoto"];
//  UIImageView *photo_buttonView = [[UIImageView alloc] initWithImage:photo_button];
//    UIImage *photoImage = [UIImage imageNamed:@"addPhoto"];
  self.photo = [[UIButton alloc] initWithFrame:CGRectMake(signup_template.size.width-photo_button.size.width-5, 5, photo_button.size.width, photo_button.size.height)];
    [self.photo setImage:[UIImage imageNamed:@"addPhoto"] forState:UIControlStateNormal];
  [self.photo addTarget:self action:@selector(addPicture:) forControlEvents:UIControlEventTouchUpInside];
//  [self.photo addSubview:photo_buttonView];
    [self.photo.layer setCornerRadius:3.0f];
    self.photo.clipsToBounds = YES;
  [signup_templateFrame addSubview:self.photo];
  [self.view addSubview:signup_templateFrame];
  
  _displayName = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, 200, 30)];
  _displayName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
  _displayName.leftViewMode = UITextFieldViewModeAlways;
  _displayName.adjustsFontSizeToFitWidth = YES;
  _displayName.delegate = self;
  [_displayName setBackgroundColor:[UIColor clearColor]];
  [_displayName setFont:[UIFont fontWithName:@"Avenir-Roman" size:15.0]];
  [_displayName setTextColor:[UIColor blackColor]];
  [_displayName setPlaceholder:@"First Name"];
  
  [signup_templateFrame addSubview:_displayName];
  
  
  _email = [[UITextField alloc] initWithFrame:CGRectMake(10, 120, 200, 30)];
  _email.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
  _email.leftViewMode = UITextFieldViewModeAlways;
  _email.adjustsFontSizeToFitWidth = YES;
  _email.delegate = self;
  [_email setBackgroundColor:[UIColor clearColor]];
  [_email setFont:[UIFont fontWithName:@"Avenir-Roman" size:15.0]];
  [_email setTextColor:[UIColor blackColor]];
  [_email setPlaceholder:@"Email"];
  
  [signup_templateFrame addSubview:_email];
  
  _password = [[UITextField alloc] initWithFrame:CGRectMake(10, 165, 200, 30)];
  _password.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
  _password.leftViewMode = UITextFieldViewModeAlways;
  _password.adjustsFontSizeToFitWidth = YES;
  _password.delegate = self;
  _password.secureTextEntry = YES;
  [_password setBackgroundColor:[UIColor clearColor]];
  [_password setFont:[UIFont fontWithName:@"Avenir-Roman" size:15.0]];
  [_password setTextColor:[UIColor blackColor]];
  [_password setPlaceholder:@"Password"];
  
  [signup_templateFrame addSubview:_password];

}
- (void) addPicture: (id) sender
{
    
    [self onAddPhoto];
    
//  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ADD PICTURE" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//  [alertView show];
}
- (void) loginAction: (id) sender
{
  [self.email resignFirstResponder];
  [self.password resignFirstResponder];
  [self processFieldEntries];
}
- (void)processFieldEntries {
	// Get the username text, store it in the app delegate for now
  NSString *displayname = self.displayName.text;
	NSString *username = self.email.text;
	NSString *password = self.password.text;
	NSString *errorText = @" ";

	BOOL textError = NO;
  
  /**********************************************
   ************** validation ********************
   **********************************************/
  //REQUIRED FILEDS
  if (displayname.length == 0 || username.length == 0 || password.length == 0 ) {
		textError = YES;
    
    if (displayname.length == 0) {
      [self.displayName becomeFirstResponder];
    }
		if (password.length == 0) {
			[self.email becomeFirstResponder];
		}
		if (username.length == 0) {
			[self.password becomeFirstResponder];
		}
	}
  
  if (displayname.length == 0) {
    textError = YES;
    errorText = @"Username ";
  }
	if (username.length == 0) {
		textError = YES;
		errorText = [errorText stringByAppendingString:@"Email "];
	}
  
	if (password.length == 0) {
		textError = YES;
			errorText = [errorText stringByAppendingString:@"Password "];
	}
  
	if (textError) {
		errorText = [errorText stringByAppendingString:@"is missing"];
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorText message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
		[alertView show];
		return;
  }else{
    [self doSignupWithUsername];
  }
}

- (void)doSignupWithUsername {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    PFUser *newUser = [[PFUser alloc] init];
    [newUser setPassword:_password.text];
    [newUser setUsername:_email.text];
    [newUser setEmail:_email.text];
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
      if (succeeded) {
        // Create next view controller to show
          self.uploadImage = [ARUtility resizeImage:self.uploadImage withSize:CGSizeMake(50, 50)];
          NSData *imageData = UIImagePNGRepresentation(self.uploadImage);
          PFFile *imageFile = [PFFile fileWithName:@"icon_square" data:imageData];
          newUser[@"name"] = self.displayName.text;
          newUser[@"userIcon"] = imageFile;
          [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
              [self showHomeView];
          }];
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
  
}
- (void)showHomeView
{

  NSLog(@"showHomeView!");
  [self dismissViewControllerAnimated:YES completion:^{
    //This sends a message through the NSNotificationCenter to any listeners for "SecondViewControllerDismissed"
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SignUpSuccessful"
                                                        object:nil
                                                      userInfo:nil];
  }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  
  return YES;
}

- (void)signUpPressed
{
  NSLog(@"signup");
  [self doSignupWithUsername];
}

//new code for camera
//UIActionSheet
- (void)onAddPhoto {
    BOOL cameraDeviceAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    BOOL photoLibraryAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    
    if (cameraDeviceAvailable && photoLibraryAvailable) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    } else {
        // if we don't have at least two options, we automatically show whichever is available (camera or roll)
        [self shouldPresentPhotoCaptureController];
    }
}

#pragma mark - AnyPic

- (BOOL)shouldStartCameraController {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
        return NO;
    }
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]
        && [[UIImagePickerController availableMediaTypesForSourceType:
             UIImagePickerControllerSourceTypeCamera] containsObject:(NSString *)kUTTypeImage]) {
        
        cameraUI.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeImage];
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        } else if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        
    } else {
        return NO;
    }
    
    cameraUI.allowsEditing = YES;
    cameraUI.showsCameraControls = YES;
    cameraUI.delegate = self;
    
    [self presentViewController:cameraUI animated:YES completion:nil];
    
    return YES;
}



- (BOOL)shouldStartPhotoLibraryPickerController {
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO
         && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)) {
        return NO;
    }
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]
        && [[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary] containsObject:(NSString *)kUTTypeImage]) {
        
        cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        cameraUI.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeImage];
        
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]
               && [[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum] containsObject:(NSString *)kUTTypeImage]) {
        
        cameraUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        cameraUI.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeImage];
        
    } else {
        return NO;
    }
    
    cameraUI.allowsEditing = YES;
    cameraUI.delegate = self;
    
    [self presentViewController:cameraUI animated:YES completion:nil];
    
    return YES;
}

- (BOOL)shouldPresentPhotoCaptureController {
    BOOL presentedPhotoCaptureController = [self shouldStartCameraController];
    
    if (!presentedPhotoCaptureController) {
        presentedPhotoCaptureController = [self shouldStartPhotoLibraryPickerController];
    }
    
    return presentedPhotoCaptureController;
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self shouldStartCameraController];
    } else if (buttonIndex == 1) {
        [self shouldStartPhotoLibraryPickerController];
    }
}

#pragma mark - camera delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"info are %@", info);
    // Code here to work with media
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *editImage = info[UIImagePickerControllerEditedImage];
        [self.photo setImage:editImage forState:UIControlStateNormal];
        self.uploadImage = editImage;
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        //        NSURL *url = info[UIImagePickerControllerMediaURL];
        // Media is a video
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
