//
//  ARSettingViewController.m
//  AROne
//
//  Created by Chenchen Zheng on 2/16/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARSettingViewController.h"
#import "ARLoginViewController.h"
#import "ARPairController.h"
#import "AREditProfileTableViewController.h"


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
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  if (section == 0)
    return 2;
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
            cell.textLabel.text = @"Pair a Device";
        } if (indexPath.row == 1) {
            cell.textLabel.text = @"Analysis";
        }
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"Edit My Profile";
    } else if (indexPath.section == 2) {
        cell.textLabel.text = @"Logout";
    }
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.section == 0) {
    if (indexPath.row == 0) {
      ARPairController *pair = [[ARPairController alloc]init];
      pair.hidesBottomBarWhenPushed = YES;
      [self.navigationController pushViewController:pair animated:YES];
    }
    if (indexPath.row == 1) {
//      CQAnalysisViewController *analysis = [[CQAnalysisViewController alloc] init];
//      analysis.hidesBottomBarWhenPushed = YES;
//      [self.navigationController pushViewController:analysis animated:YES];
    }
  } else if (indexPath.section ==1 ) {
//      ARProfileEditTableViewController *editProfile = [[ARProfileEditTableViewController alloc] init];
      AREditProfileTableViewController *editProfile = [[AREditProfileTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
      [self.navigationController pushViewController:editProfile animated:YES];
  } else if (indexPath.section == 2) {
      NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
      [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
      [PFUser logOut];
      [self dismissViewControllerAnimated:YES completion:^{
          [[[[UIApplication sharedApplication] delegate] window] reloadInputViews];
      }];
  }
}
@end
