//
//  ARSuggestFriendsViewController.m
//  ARTwo
//
//  Created by Colororange on 7/30/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARSuggestFriendsViewController.h"



@interface ARSuggestFriendsViewController ()
@property (nonatomic) NSMutableArray* myfbfriends;
@property (nonatomic) NSMutableArray* myfbfriendsID;
@property (nonatomic) NSArray*userArray;
@property (nonatomic, strong) NSArray* activityArray;

@end

@implementation ARSuggestFriendsViewController

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
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
  [self reload];
  self.myfbfriends  = [[NSMutableArray alloc]init];
  self.myfbfriendsID  = [[NSMutableArray alloc]init];
  
    [FBRequestConnection startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
    if (!error) {
      NSArray *friendObjects = [result objectForKey:@"data"];
      // Create a list of friends' Facebook IDs
      for (NSDictionary *friendObject in friendObjects) {
        [self.myfbfriends addObject:friendObject];
        [self.myfbfriendsID addObject:[friendObject objectForKey:@"id"]];
      }

//c
      // Construct a PFUser query that will find friends whose facebook ids
      // are contained in the current user's friend list.
      PFQuery *friendQuery = [PFUser query];
      [friendQuery whereKey:@"fbid" containedIn:self.myfbfriendsID];
      [friendQuery findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        self.userArray = users;
        [self.tableView reloadData];
      }];
    }
  }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
  UIButton * follow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 25)];
  [follow setBackgroundColor:[UIColor blackColor]];
  [follow setTitleColor:[UIColor orangeColor] forState: UIControlStateNormal];
  [follow setTag: indexPath.row];
    [follow.layer setCornerRadius:4.0f];
  BOOL found_person = false;

  for (int i=0; i < [self.activityArray count];i++){
    if([[[[self.activityArray objectAtIndex:i] objectForKey:@"toUser"] objectForKey:@"name"] isEqualToString:person]){
      found_person = true;
    }
  }
  if(!found_person){
      NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"Follow" attributes:@{NSFontAttributeName: kARFontFollowButton, NSForegroundColorAttributeName: [UIColor orangeColor]}];
      [follow setAttributedTitle:string forState:UIControlStateNormal];
    [follow addTarget:self action:@selector(followButtonAction:) forControlEvents:UIControlEventTouchUpInside];
  }else{
      NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"Friends" attributes:@{NSFontAttributeName: kARFontFollowButton, NSForegroundColorAttributeName: [UIColor greenColor]}];
      [follow setAttributedTitle:string forState:UIControlStateNormal];
    [follow addTarget:self action:@selector(unfollowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
  }

  cell.textLabel.font = font;
  cell.textLabel.text = person;
  cell.accessoryView = follow;
  
  return cell;
}

- (void)followButtonAction:(id)sender{
  PFQuery *activityQuery = [PFQuery queryWithClassName:@"Activity"];
  [activityQuery whereKey:@"fromUser" equalTo: [PFUser currentUser]];
  [activityQuery whereKey:@"toUser" equalTo: [self.userArray objectAtIndex:[sender tag]]];
  [activityQuery findObjectsInBackgroundWithBlock:^(NSArray *activities, NSError *error) {
    if([activities count] == 0){
      [self followUserEventually:[self.userArray objectAtIndex:[sender tag]] block:^(BOOL succeeded, NSError *error) {
        if (error) {
          NSLog(@"error %@", error);
          NSLog(@"cannot follow %@", [self.userArray objectAtIndex:[sender tag]]);
        }else{
          NSLog(@"You have successfully add following user %@",  [self.userArray objectAtIndex:[sender tag]]);
        }
      }];
    }else{
      //FIXME: need push notification
      NSLog(@"you have already add %@", [self.userArray objectAtIndex:[sender tag]]);
    }
    
  }];
  

}

- (void)followUserEventually:(PFUser *)user block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
  if ([[user objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
    return;
  }
  
  // Create follow activity
  PFObject *followActivity = [PFObject objectWithClassName:@"Activity"];
  [followActivity setObject:[PFUser currentUser] forKey:@"fromUser"];
  [followActivity setObject:user forKey:@"toUser"];
  [followActivity setObject:@"follow" forKey:@"type"];
  
  // Set the proper ACL
  PFACL *followACL = [PFACL ACLWithUser:[PFUser currentUser]];
  [followACL setPublicReadAccess:YES];
  followActivity.ACL = followACL;
  
  // Save the activity and set the block passed as the completion block
  [followActivity saveEventually:completionBlock];
  [self reload];

}


- (void)unfollowButtonAction:(id)sender{
  
  [self unfollowUserEventually:[self.userArray objectAtIndex:[sender tag]]];
  NSLog(@"You have successfully UNFOLLOW user %@", [self.userArray objectAtIndex:[sender tag]]);
  [self.tableView reloadData];
}

- (void)unfollowUserEventually:(PFUser *)user {
  PFQuery *query = [PFQuery queryWithClassName:@"Activity"];
  [query whereKey:@"fromUser" equalTo:[PFUser currentUser]];
  [query whereKey:@"toUser" equalTo:user];
  [query whereKey:@"type" equalTo:@"follow"];
  [query findObjectsInBackgroundWithBlock:^(NSArray *followActivities, NSError *error) {
    // While normally there should only be one follow activity returned, we can't guarantee that.
    
    if (!error) {
      for (PFObject *followActivity in followActivities) {
        [followActivity deleteEventually];
        [self reload];

      }
    }
  }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"clicked");
    [self pushTo:[self.userArray objectAtIndex:indexPath.row]];
    //and do animation on followed
}

- (void) pushTo:(PFUser *)user {
    // Build a query to match users with a birthday today
    PFQuery *innerQuery = [PFUser query];
    
    // Use hasPrefix: to only match against the month/date
    [innerQuery whereKey:@"user" equalTo:user.username];
    
    // Build the actual push notification target query
    PFQuery *query = [PFInstallation query];
    
    // only return Installations that belong to a User that
    // matches the innerQuery
    [query whereKey:@"user" equalTo:user.username];
    
    // Send the notification.
    PFPush *push = [[PFPush alloc] init];
    [push setQuery:innerQuery];
    PFUser *me = [PFUser currentUser];
    NSString *message = [NSString stringWithFormat:@"%@ added you as friend!", [me objectForKey:@"name"]];
    [push setMessage:message];
    [push sendPushInBackground];
}

-(void) reload{
  PFQuery *activityQuery = [PFQuery queryWithClassName:@"Activity"];
  [activityQuery whereKey:@"fromUser" equalTo: [PFUser currentUser]];
  [activityQuery includeKey:@"toUser"];
  [activityQuery findObjectsInBackgroundWithBlock:^(NSArray *activities, NSError *error) {
    self.activityArray = activities;
    [self.tableView reloadData];

  }];
}

@end
