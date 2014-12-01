//
//  AREditProfileTableViewController.m
//  AROne
//
//  Created by Chenchen Zheng on 10/22/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "AREditProfileTableViewController.h"
#import "NSString+ARAdditions.h"
#import "AREditProfileSingleTableViewController.h"
#import <RMDateSelectionViewController/RMDateSelectionViewController.h>
#import <MBProgressHUD.h>


@interface AREditProfileTableViewController () <RMDateSelectionViewControllerDelegate>
@end

@implementation AREditProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Edit Profile";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"reloadEditProfile" object:nil];

//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"AppCell"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)reload {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 3;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppCell" forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppCell"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AppCell"];
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"User Name";
                NSString *displayName = [PFUser currentUser][@"displayname"];
                cell.detailTextLabel.text = displayName;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            } else if (indexPath.row == 1) {
                cell.textLabel.text = @"Gender";
                NSString *gender = [PFUser currentUser][@"gender"];
                cell.detailTextLabel.text = gender;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Birthday";
                cell.detailTextLabel.text = [PFUser currentUser][@"birthday"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            } else if (indexPath.row == 1) {
                cell.textLabel.text = @"Email";
                cell.detailTextLabel.text = [PFUser currentUser][@"email"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else if (indexPath.row == 2) {
                cell.textLabel.text = @"Facebook";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            }
        }
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"MY SETTINGS";
    }
    return @"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            AREditProfileSingleTableViewController *single = [[AREditProfileSingleTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            single.type = @"displayname";
            single.placeHolder = [PFUser currentUser][@"displayname"];
            [self.navigationController pushViewController:single animated:YES];
        } else if (indexPath.row == 1) {
            AREditProfileSingleTableViewController *single = [[AREditProfileSingleTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            single.type = @"gender";
            single.placeHolder = [PFUser currentUser][@"gender"];
            [self.navigationController pushViewController:single animated:YES];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSString *data = [PFUser currentUser][@"birthday"];
            RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
            dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDate;
            dateSelectionVC.delegate = self;
            if (![NSString isStringEmpty:data]) {
                // Convert string to date object
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"MM/dd/yyyy"];
                NSDate *date = [dateFormat dateFromString:data];
                [dateSelectionVC.datePicker setDate:date];
            }
            [dateSelectionVC show];
        } else if (indexPath.row == 1) {
            AREditProfileSingleTableViewController *single = [[AREditProfileSingleTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            single.type = @"email";
            single.placeHolder = [PFUser currentUser][@"email"];
            [self.navigationController pushViewController:single animated:YES];
        } else if (indexPath.row == 2) {
            
        }
    }
}

#pragma mark - RMDateSelectionViewController Delegates
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSString *stringFromDate = [dateFormat stringFromDate:aDate];
    cell.detailTextLabel.text = stringFromDate;
    
    PFUser *user = [PFUser currentUser];
    [user setObject:stringFromDate forKey:@"birthday"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //loading and refresh
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadEditProfile" object:nil userInfo:nil];
    }];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    //Do something else
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
