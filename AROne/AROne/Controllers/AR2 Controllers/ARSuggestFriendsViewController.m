//
//  ARSuggestFriendsViewController.m
//  ARTwo
//
//  Created by Colororange on 7/30/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARSuggestFriendsViewController.h"
#import "BMInitialsPlaceholderView.h"
#import "ARUserTableViewCell.h"



@interface ARSuggestFriendsViewController ()
//@property (nonatomic) NSMutableArray* myfbfriends; //my friend list
@property (nonatomic) NSArray*userArray;
@property (nonatomic, strong) NSArray* friendsArray;

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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ARUserTableViewCell" bundle:nil] forCellReuseIdentifier:@"appCell"];
//    self.myfbfriends  = [[NSMutableArray alloc]init];
    [SVProgressHUD show];
    [FBRequestConnection startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSMutableArray *myfbfriendsID = [NSMutableArray new];
            NSArray *friendObjects = [result objectForKey:@"data"];
            // Create a list of friends' Facebook IDs
            for (NSDictionary *friendObject in friendObjects) {
                NSLog(@"friendObject is %@", friendObject);
//                [self.myfbfriends addObject:friendObject];
                [myfbfriendsID addObject:[friendObject objectForKey:@"id"]];
            }
            // Construct a PFUser query that will find friends whose facebook ids
            // are contained in the current user's friend list.
            PFQuery *friendQuery = [PFUser query];
            [friendQuery whereKey:@"fbid" containedIn:myfbfriendsID];
            [friendQuery findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
                self.userArray = users;
                [self reloadFollowActivity];
            }];
        }
  }];
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
    ARUserTableViewCell *cell = (ARUserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"appCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSLog(@"row is %ld", (long)indexPath.row);
    PFUser *user = [self.userArray objectAtIndex:indexPath.row];
    NSString *person = [user objectForKey:@"name"];
    NSLog(@"person is %@", person);
    UIFont *font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0];
    
    //display header icon
    cell.userName.font = font;
    cell.userName.text = person;
    cell.userIcon.font = font;
    cell.userIcon.initials = [self initialStringForPersonString:person];
    cell.userIcon.circleColor = [self circleColorForIndexPath:indexPath];
    
    UIButton * follow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 25)];
    [follow setBackgroundColor:[UIColor blackColor]];
    [follow setBackgroundImage:[ARUtility imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [follow setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    [follow setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [follow setTag: indexPath.row];
    [follow.layer setCornerRadius:4.0f];
    [follow.layer setBorderColor:[UIColor blackColor].CGColor];
    [follow.layer setBorderWidth:1.0];
    follow.clipsToBounds = YES;
    
    
    BOOL found_person = false;
    
    
    for (PFUser *toUser in self.friendsArray) {
        if ([[toUser objectForKey:@"name"] isEqualToString:person]) {
            found_person = true;
            break;
        }
    }
    
//    for (int i=0; i < [self.activityArray count];i++){
//        if([[[[self.activityArray objectAtIndex:i] objectForKey:@"toUser"] objectForKey:@"name"] isEqualToString:person]){
//            found_person = true;
//        }
//    }
    
    if(!found_person){
        NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"Follow" attributes:@{NSFontAttributeName: kARFontFollowButton, NSForegroundColorAttributeName: [UIColor whiteColor]}];
        [follow setAttributedTitle:string forState:UIControlStateNormal];
        [follow addTarget:self action:@selector(followButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"Friend" attributes:@{NSFontAttributeName: kARFontFollowButton, NSForegroundColorAttributeName: [UIColor greenColor]}];
        [follow setAttributedTitle:string forState:UIControlStateNormal];
        [follow addTarget:self action:@selector(unfollowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.accessoryView = follow;
  return cell;
}

- (void)followButtonAction:(UIButton *)sender{
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
            PFUser *newFriend = [self.userArray objectAtIndex:sender.tag];
            [self pushTo:newFriend];
            NSMutableArray *newFriendsArray = [[NSMutableArray alloc] initWithArray:self.friendsArray];
            [newFriendsArray addObject:newFriend];
            self.friendsArray = newFriendsArray;
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];

          NSLog(@"You have successfully add following user %@",  [self.userArray objectAtIndex:[sender tag]]);
        }
      }];
    }else{
      //FIXME: need push notification
//        NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"Friends" attributes:@{NSFontAttributeName: kARFontFollowButton, NSForegroundColorAttributeName: [UIColor greenColor]}];
//        [follow setAttributedTitle:string forState:UIControlStateNormal];
//        [follow addTarget:self action:@selector(unfollowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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
}


- (void)unfollowButtonAction:(UIButton *)sender{
    [self unfollowUserEventually:[self.userArray objectAtIndex:[sender tag]]];
    NSLog(@"You have successfully UNFOLLOW user %@", [self.userArray objectAtIndex:[sender tag]]);
    NSMutableArray *data = [[NSMutableArray alloc] initWithArray:self.friendsArray];
    PFUser *user = [self.userArray objectAtIndex:sender.tag];
    NSString *person = [user objectForKey:@"name"];
    for (PFUser *toUser in self.friendsArray) {
        if ([[toUser objectForKey:@"name"] isEqualToString:person]) {
            [data removeObject:toUser];
            break;
        }
    }
    self.friendsArray = data;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
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
      }
    }
  }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"clicked");
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

-(void) reloadFollowActivity{
  PFQuery *activityQuery = [PFQuery queryWithClassName:@"Activity"];
  [activityQuery whereKey:@"fromUser" equalTo: [PFUser currentUser]];
  [activityQuery includeKey:@"toUser"];
  [activityQuery findObjectsInBackgroundWithBlock:^(NSArray *activities, NSError *error) {
      [SVProgressHUD dismiss];
      NSLog(@"activityArray is %@", activities);
      NSMutableArray *toUser = [NSMutableArray new];
      for (id activity in activities) {
          [toUser addObject:[activity objectForKey:@"toUser"]];
      }
      self.friendsArray = toUser;
      [self.tableView reloadData];
  }];
}

- (UIColor *)circleColorForIndexPath:(NSIndexPath *)indexPath {
    return [UIColor colorWithHue:arc4random() % 256 / 256.0 saturation:0.7 brightness:0.8 alpha:1.0];
}

- (NSString *)initialStringForPersonString:(NSString *)personString {
    NSArray *comps = [personString componentsSeparatedByString:@" "];
    if ([comps count] >= 2) {
        NSString *firstName = comps[0];
        NSString *lastName = comps[1];
        return [NSString stringWithFormat:@"%@%@", [firstName substringToIndex:1], [lastName substringToIndex:1]];
    } else if ([comps count]) {
        NSString *name = comps[0];
        return [name substringToIndex:1];
    }
    return @"Unknown";
}

@end
