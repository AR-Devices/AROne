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

//
      // Construct a PFUser query that will find friends whose facebook ids
      // are contained in the current user's friend list.
      PFQuery *friendQuery = [PFUser query];
      [friendQuery whereKey:@"fbid" containedIn:self.myfbfriendsID];

      // findObjects will return a list of PFUsers that are friends
      // with the current user
//      self.userArray = [friendQuery findObjects];
      [friendQuery findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        self.userArray = users;
        [self.tableView reloadData];
        NSLog(@"userArray is %@", self.userArray);
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
  UIButton * follow = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
  [follow setTitle:@"Follow" forState:UIControlStateNormal];
  [follow setBackgroundColor:[UIColor blackColor]];
  [follow setTitleColor:[UIColor orangeColor] forState: UIControlStateNormal];
  cell.textLabel.font = font;
  cell.textLabel.text = person;
  cell.accessoryView = follow;
  
  return cell;
}


@end
