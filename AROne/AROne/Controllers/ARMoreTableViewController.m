//
//  ARMoreTableViewController.m
//  AROne
//
//  Created by Chenchen Zheng on 11/3/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARMoreTableViewController.h"
#import "AREditProfileTableViewController.h"
#import "ARProfileViewController.h"
#import "ARFriendListController.h"
#import "ARSuggestFriendsViewController.h"


@interface ARMoreTableViewController ()

@end

@implementation ARMoreTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"More";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ARMoreUserTableViewCell" bundle:nil] forCellReuseIdentifier:@"UserCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RegularCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 4;
    } else if (section == 2) {
        return 1;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"RegularCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Edit My Profile";
            cell.imageView.image = [UIImage imageNamed:@"edit"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"My Friend List";
            cell.imageView.image = [UIImage imageNamed:@"Friendslist"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"Hide My Location";
            cell.imageView.image = [UIImage imageNamed:@"myLocation"];
            UISwitch *toggle = [UISwitch new];
            toggle.tag = 1;
            [toggle addTarget:self action:@selector(onToggle:) forControlEvents:UIControlEventValueChanged];
//            [toggle setOn:[SettingsManager canReminder]];
            cell.accessoryView = toggle;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"Share My Data";
            cell.imageView.image = [UIImage imageNamed:@"share"];
            UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"P", @"F", @"D"]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryView = seg;
            
        }
    } else if (indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"RegularCell" forIndexPath:indexPath];
        cell.textLabel.text = @"Logout";
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        ARProfileViewController *profile = [ARProfileViewController new];
        [self.navigationController pushViewController:profile animated:YES];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            AREditProfileTableViewController *editProfile = [[AREditProfileTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:editProfile animated:YES];
        } else if (indexPath.row == 1) {
//            ARFriendListController *friendList = [ARFriendListController new];
            ARSuggestFriendsViewController *friends = [ARSuggestFriendsViewController new];
            [self.navigationController pushViewController:friends animated:YES];
        }
    } else if (indexPath.section == 2) {
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        [PFUser logOut];
        [self dismissViewControllerAnimated:YES completion:^{
            [[[[UIApplication sharedApplication] delegate] window] reloadInputViews];
        }];
    }
}

- (void)onToggle:(UISwitch *)toggle {
    if (toggle.tag == 0) { //reminder
//        [SettingsManager setCanReminder:toggle.on];
    } else if (toggle.tag == 1) { //notification
//        [SettingsManager setCanNotify:toggle.on];
    }
}
@end
