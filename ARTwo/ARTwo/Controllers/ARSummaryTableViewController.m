//
//  ARSummaryTableViewController.m
//  ARTwo
//
//  Created by Chenchen Zheng on 6/7/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARSummaryTableViewController.h"
#import "ARUserListCell.h"
#import "ARFriendAddAcceptViewController.h"

@interface ARSummaryTableViewController ()
@property (nonatomic) NSMutableArray *Usernames;
@property (nonatomic) NSMutableArray *Useremails;
@property (nonatomic) NSArray * parse_return_array;
@property (nonatomic) NSMutableArray * friends;
@property (nonatomic) NSMutableArray *user_database;
@property (nonatomic) UISearchBar *search_name;

@property (nonatomic) Boolean isSearching;


@end

@implementation ARSummaryTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.Usernames  = [NSMutableArray new];
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
  self.user_database = [[NSMutableArray alloc] init];
  PFQuery *query = [PFQuery queryWithClassName:@"_User"];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error && ([objects count] != 0)) {
      self.parse_return_array = objects;
      for (int i = 0; i < [self.parse_return_array count]; i++) {
        NSDictionary *dict = [self.parse_return_array objectAtIndex:i];
        NSString * user_email;
        if([dict objectForKey:@"email"]!=nil){
          user_email = [dict objectForKey:@"email"];
        }else{
          user_email = @"no email found";
        }
        [self.user_database addObject:[NSDictionary dictionaryWithObjectsAndKeys: [dict objectForKey:@"name"] , @"name",
                                                                    user_email, @"email",
                                                                    nil]]; //load up MGP Search Engine
        [self.Usernames  addObject:[dict objectForKey:@"name"]];
//        [self.Useremails addObject:[dict objectForKey:@"email"]];
      }
      [self.tableView reloadData];
    }}];
}

- (void) searchUsers
{
  self.friends =[[NSMutableArray alloc] init];
  PFQuery *query = [PFQuery queryWithClassName:@"_User"];
  NSLog(@"searching %@", self.search_name.text);
  [query whereKey:@"name" matchesRegex:self.search_name.text modifiers:@"i"];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error && ([objects count] != 0)) {
      self.parse_return_array = objects;
      for (int i = 0; i < [self.parse_return_array count]; i++) {
        NSDictionary *dict = [self.parse_return_array objectAtIndex:i];
        NSString * user_email;
        if([dict objectForKey:@"email"]!=nil){
          user_email = [dict objectForKey:@"email"];
        }else{
          user_email = @"no email found";
        }

        NSLog(@"adding %@", [dict objectForKey:@"name"]);
        [self.friends addObject:[NSDictionary dictionaryWithObjectsAndKeys: [dict objectForKey:@"name"] , @"name",
                                       user_email, @"email",
                                       nil]];
      }
      [self.tableView reloadData];
    }}];
}

- (void) NameSearchView
{
  self.search_name = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,30)];
  self.search_name.delegate = self;
  [self.search_name setPlaceholder:@"Name"];
}



#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  if(section == 0){
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,30)];
    header.backgroundColor = [UIColor clearColor];
    [self NameSearchView];
    [header addSubview:self.search_name];
    return header;
  }else{
    return nil;
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  if(section == 0){
    return 30.0f;
  }else{
    return 0.0f;
  }
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
  if (self.friends == nil){
    return 1;
  }else if([self.friends count] == 0){
    return 1;
  }else{
    return [self.friends count];
  }
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
  if(self.friends == nil){
  }else{
    cell = [ARUserListCell cellWithName:[[self.friends objectAtIndex:indexPath.section] objectForKey: @"name"]andEmail:@""]; //FIXME
  }
  cell.selectionStyle = UITableViewCellEditingStyleNone;
  cell.backgroundColor = [UIColor clearColor];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  ARFriendAddAcceptViewController* friendaddacceptvc = [[ARFriendAddAcceptViewController alloc]init];
  friendaddacceptvc.user_package = [self.friends objectAtIndex:indexPath.section];
  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
  [self.navigationController pushViewController:friendaddacceptvc animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}

#pragma searchBar
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [self searchUsers];
}





@end
