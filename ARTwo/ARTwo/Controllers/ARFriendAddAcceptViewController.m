//
//  ARFriendAddAcceptViewController.m
//  ARTwo
//
//  Created by Colororange on 7/23/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARFriendAddAcceptViewController.h"

@interface ARFriendAddAcceptViewController () <UITextFieldDelegate>
@property (nonatomic) UITextField * name;
@property (nonatomic) UITextField * email;
@end

@implementation ARFriendAddAcceptViewController
@synthesize user_package;

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
  [self friendsDetailView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) friendsDetailView
{
  UIView *signup_templateFrame = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
  signup_templateFrame.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:signup_templateFrame];
  
  self.name = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, 300, 30)];
  self.name.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
  self.name.leftViewMode = UITextFieldViewModeAlways;
  self.name.adjustsFontSizeToFitWidth = YES;
  self.name.delegate = self;
  [self.name setBackgroundColor:[UIColor clearColor]];
  [self.name setFont:[UIFont fontWithName:@"Avenir-Roman" size:15.0]];
  [self.name setTextColor:[UIColor blackColor]];
  [self.name setText: [@"Name:" stringByAppendingString: [user_package objectForKey:@"name"]]];

  [signup_templateFrame addSubview:self.name];
  
  self.email = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 300, 30)];
  self.email.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
  self.email.leftViewMode = UITextFieldViewModeAlways;
  self.email.adjustsFontSizeToFitWidth = YES;
  self.email.delegate = self;
  [self.email setBackgroundColor:[UIColor clearColor]];
  [self.email setFont:[UIFont fontWithName:@"Avenir-Roman" size:15.0]];
  [self.email setTextColor:[UIColor blackColor]];
  if([user_package objectForKey:@"email"] != nil){
    [self.email setText: [@"Email:" stringByAppendingString: [user_package objectForKey:@"email"]]];
  }else{
    [self.email setText: [@"Email:" stringByAppendingString: [user_package objectForKey:@"ARDevice@gmail.com"]]];
  }
  
  [signup_templateFrame addSubview:self.email];
  
  UIButton *add_friend = [[UIButton alloc] initWithFrame:CGRectMake(10,100, 100, 30)];
  [add_friend setTitle:@"Add Friend" forState:UIControlStateNormal];
  [add_friend setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
  add_friend.titleLabel.font =[UIFont fontWithName:@"Avenir-Roman" size:13.0];
  add_friend.backgroundColor = [UIColor blackColor];
//  [add_friend addTarget:self action:@selector(:) forControlEvents:UIControlEventTouchUpInside];
  
  [signup_templateFrame addSubview:add_friend];
  
  UIButton *accept_friend = [[UIButton alloc] initWithFrame:CGRectMake(210,100, 100, 30)];
  [accept_friend setTitle:@"Accept Friend" forState:UIControlStateNormal];
  [accept_friend setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
  accept_friend.titleLabel.font =[UIFont fontWithName:@"Avenir-Roman" size:13.0];
  accept_friend.backgroundColor = [UIColor blackColor];
  //  [add_friend addTarget:self action:@selector(:) forControlEvents:UIControlEventTouchUpInside];
  
  [signup_templateFrame addSubview:accept_friend];
  
}



@end
