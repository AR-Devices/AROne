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
@property (nonatomic) NSArray * parse_return_array;
@property (nonatomic) NSArray * friends;


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
  [self MGPSearchView];

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
  data = [[NSMutableArray alloc] init];
  PFQuery *query = [PFQuery queryWithClassName:@"_User"];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error && ([objects count] != 0)) {
      self.parse_return_array = objects;
      for (int i = 0; i < [self.parse_return_array count]; i++) {
        NSDictionary *dict = [self.parse_return_array objectAtIndex:i];
        [data addObject:[NSDictionary dictionaryWithObjectsAndKeys: [dict objectForKey:@"name"] , @"DisplayText",
                                                                    @"=^.^=", @"DisplaySubText",
                                                                    dict, @"CustomObject",
                                                                    nil]]; //load up MGP Search Engine
        [self.Usernames  addObject:[dict objectForKey:@"name"]];
//        [self.Useremails addObject:[dict objectForKey:@"email"]];
      }
      [self.tableView reloadData];
    }}];
}

- (void) searchUsers
{
  PFQuery *query = [PFQuery queryWithClassName:@"_User"];
  [query whereKey:@"name" containsString:self.search_name.text];
  self.friends = [query findObjects];
}

- (void) MGPSearchView
{
  self.search_name = [[MPGTextField alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width,30)];
  [self.search_name setDelegate:self];
  self.search_name.adjustsFontSizeToFitWidth = YES;
  [self.search_name setBackgroundColor:[UIColor clearColor]];
  [self.search_name setFont:[UIFont fontWithName:@"Avenir-Roman" size:11.0]];
  [self.search_name setTextColor:[UIColor blackColor]];
  [self.search_name setPlaceholder:@"Name"];
  [self.view addSubview:self.search_name];
}

#pragma mark MPGTextField Delegate Methods

- (NSArray *)dataForPopoverInTextField:(MPGTextField *)textField
{
  if ([textField isEqual:self.search_name]) {
    return data;
  }
  else{
    return nil;
  }
}

- (BOOL)textFieldShouldSelect:(MPGTextField *)textField
{
  return YES;
}

- (void)textField:(MPGTextField *)textField didEndEditingWithSelection:(NSDictionary *)result
{
  [self searchUsers];
  [self.tableView reloadData];

//  //A selection was made - either by the user or by the textfield. Check if its a selection from the data provided or a NEW entry.
//  if ([[result objectForKey:@"CustomObject"] isKindOfClass:[NSString class]] && [[result objectForKey:@"CustomObject"] isEqualToString:@"NEW"]) {
//    //New Entry
//    [self.nameStatus setHidden:NO]; //FIXME what's this for?
//  }
//  else{
//    //Selection from provided data
//    if ([textField isEqual:self.search_name]) {
//      [self.nameStatus setHidden:YES];
//
//    }
//  }
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
//  return [self.Usernames count];
  return [self.friends count]; //FIXME
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
//  cell = [ARUserListCell cellWithName:[self.Usernames objectAtIndex:indexPath.section] andEmail:@"dummy@gmail.com"]; //FIXME
  cell = [ARUserListCell cellWithName:[[self.friends objectAtIndex:indexPath.section] objectForKey: @"name"]andEmail:@"dummy@gmail.com"]; //FIXME

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
