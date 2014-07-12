//
//  ARSummaryTableViewController.m
//  ARTwo
//
//  Created by Chenchen Zheng on 6/7/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARSummaryTableViewController.h"
#import "ARUserListCell.h"

@interface ARSummaryTableViewController ()
@property (nonatomic) NSMutableArray *Usernames;
@property (nonatomic) NSMutableArray *Useremails;
@end

@implementation ARSummaryTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.Usernames = [NSMutableArray new];
      self.Useremails = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self queryUsers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) queryUsers
{
  PFQuery *query = [PFQuery queryWithClassName:@"_User"];
  [query whereKey:@"username" equalTo:[PFUser currentUser].username];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error && ([objects count] != 0)) {
      NSArray *array = objects;
      for (int i = 0; i < [array count]; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        [self.Usernames  addObject:[dict objectForKey:@"name"]];
        [self.Useremails addObject:[dict objectForKey:@"email"]];
      }
      [self.tableView reloadData];
    }}];
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return [self.Useremails count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%ld",(long)indexPath.section];
  UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  cell = [ARUserListCell cellWithName:[self.Usernames objectAtIndex:indexPath.section] andEmail:[self.Useremails objectAtIndex:indexPath.section]];
  cell.selectionStyle = UITableViewCellEditingStyleNone;
  cell.backgroundColor = [UIColor clearColor];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}



@end
