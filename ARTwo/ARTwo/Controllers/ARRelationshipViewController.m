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
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
  PFQuery *followingQuery = [PFQuery queryWithClassName:@"Activity"];
  PFQuery *followedQuery = [PFQuery queryWithClassName:@"Activity"];
  PFQuery *friendsQuery = [PFQuery queryWithClassName:@"Activity"];

  if(self.type == Following){
  //following: user who are following me,
    [followingQuery whereKey:@"fromUser" equalTo:[PFUser currentUser]];
    [followingQuery includeKey:@"fromUser"];
    [followingQuery includeKey:@"toUser"];
    [followingQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.following = objects;
        NSLog(@"following %@", self.following);
    }];
  }else if(self.type == Followed){
  //followed;
    [followedQuery whereKey:@"toUser" equalTo:[PFUser currentUser]];
    [followedQuery includeKey:@"fromUser"];
    [followedQuery includeKey:@"toUser"];
    [followedQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.followed = objects;
        NSLog(@"followed %@", self.followed);
    }];
  }else if(self.type == Friends){
  //friends:
    [followedQuery whereKey:@"toUser" equalTo:[PFUser currentUser]];
    [friendsQuery whereKey:@"toUser" matchesKey:@"fromUser" inQuery:followedQuery];
    [friendsQuery includeKey:@"fromUser"];
    [friendsQuery includeKey:@"toUser"];

    [friendsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.friends = objects;
        NSLog(@"friends %@", self.friends);

    }];
  }
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
  NSInteger rows = 0;
  if(self.type == Following){
    rows = [self.following count];
  }else if(self.type == Followed){
    rows = [self.followed count];
  }else if(self.type == Friends){
    rows = [self.friends count];
  }
  return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  PFUser *user;
  if(self.type == Following){
    user = (PFUser*)[[self.following objectAtIndex:indexPath.row] objectForKey:@"toUser"];
  }else if(self.type == Followed){
    user = (PFUser*)[[self.followed objectAtIndex:indexPath.row] objectForKey:@"fromUser"];
  }else if(self.type == Friends){
    user = (PFUser*)[[self.friends objectAtIndex:indexPath.row] objectForKey:@"toUser"];
  }
  NSString *person = [user objectForKey:@"name"];
  UIFont *font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0];

  
  cell.textLabel.font = font;
  cell.textLabel.text = person;
  
  return cell;
}


@end
