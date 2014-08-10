//
//  ARRelationshipViewController.m
//  ARTwo
//
//  Created by Colororange on 8/10/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARRelationshipViewController.h"

@interface ARRelationshipViewController ()
@property ARRelationshipType type;
@property (nonatomic) NSArray*userArray;
@property (nonatomic, strong) NSArray * following;
@property (nonatomic, strong) NSArray * followed;
@property (nonatomic, strong) NSArray * friends;


@end

@implementation ARRelationshipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithStyle:(ARRelationshipType)style
{
  self.type = style;
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  PFQuery *followingQuery = [PFQuery queryWithClassName:@"Activity"];
  PFQuery *followedQuery = [PFQuery queryWithClassName:@"Activity"];
  PFQuery *friendsQuery = [PFQuery queryWithClassName:@"Activity"];

  //following:
  [followingQuery whereKey:@"fromUser" equalTo:[PFUser currentUser]];
  self.following = [followingQuery findObjects];
  NSLog(@"following %@", self.following);
  //followed;
  [followedQuery whereKey:@"toUser" equalTo:[PFUser currentUser]];
  self.followed = [followedQuery findObjects];
  NSLog(@"followed %@", self.followed);

  //friends:
  [followedQuery whereKey:@"toUser" equalTo:[PFUser currentUser]];
  [friendsQuery whereKey:@"toUser" matchesKey:@"fromUser" inQuery:followedQuery];
  self.friends = [friendsQuery findObjects];
  NSLog(@"friends %@", self.friends);


  
  
//  PFQuery *relatiQuery = [PFUser query];
//  [friendQuery whereKey:@"fbid" containedIn:self.myfbfriendsID];
//  [friendQuery findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
//    self.userArray = users;
//    [self.tableView reloadData];
//  }];
//}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return [self.userArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  PFUser *user = [self.userArray objectAtIndex:indexPath.row];
  NSString *person = [user objectForKey:@"name"];
  UIFont *font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0];
  UIButton * follow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
  [follow setBackgroundColor:[UIColor blackColor]];
  [follow setTitleColor:[UIColor orangeColor] forState: UIControlStateNormal];
  [follow setTag: indexPath.row];
  PFQuery *activityQuery = [PFQuery queryWithClassName:@"Activity"];
  [activityQuery whereKey:@"toUser" equalTo:(PFUser*)[self.userArray objectAtIndex:indexPath.row]];
  NSArray* activityArray = [activityQuery findObjects];
  if([activityArray count] ==0){
    [follow setTitle:@"Follow" forState:UIControlStateNormal];
    [follow setTitleColor:[UIColor orangeColor] forState: UIControlStateNormal];
    [follow addTarget:self action:@selector(followButtonAction:) forControlEvents:UIControlEventTouchUpInside];
  }else{
    [follow setTitle:@"Friends" forState:UIControlStateNormal];
    [follow setTitleColor:[UIColor greenColor] forState: UIControlStateNormal];
    [follow addTarget:self action:@selector(unfollowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
  }
  
  cell.textLabel.font = font;
  cell.textLabel.text = person;
  cell.accessoryView = follow;
  
  return cell;
}


@end
