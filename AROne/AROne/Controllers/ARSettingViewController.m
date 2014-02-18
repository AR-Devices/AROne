//
//  ARSettingViewController.m
//  AROne
//
//  Created by Chenchen Zheng on 2/16/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARSettingViewController.h"

@interface ARSettingViewController ()

@end

@implementation ARSettingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  if (section == 0)
    return 1;
  else
    return 1;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  // Configure the cell...
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  if (indexPath.section == 0) {
    if (indexPath.row == 0) {
      cell.textLabel.text = @"Profile";
    } if (indexPath.row == 1) {
      cell.textLabel.text = @"Analysis";
    }
  } else if (indexPath.section == 1)
    cell.textLabel.text = @"Logout";
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//  if (indexPath.section == 0) {
//    if (indexPath.row == 0) {
//      CQProfileViewController *profile = [[CQProfileViewController alloc] init];
//      profile.hidesBottomBarWhenPushed = YES;
//      [self.navigationController pushViewController:profile animated:YES];
//    }
//    if (indexPath.row == 1) {
//      CQAnalysisViewController *analysis = [[CQAnalysisViewController alloc] init];
//      analysis.hidesBottomBarWhenPushed = YES;
//      [self.navigationController pushViewController:analysis animated:YES];
//    }
//  } else if (indexPath.section == 1) {
//    [PFUser logOut];
//    CQLogInViewController *login = [[CQLogInViewController alloc] init];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:login];
//    navi.navigationBar.hidden = YES;
//    [self.navigationController presentViewController:navi animated:YES completion:^{
//      NSLog(@"to Login");
//    }];
//  }
}
@end
