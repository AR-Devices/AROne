//
//  ARSettingsViewController.m
//  ARTwo
//
//  Created by Chenchen Zheng on 8/3/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARSettingsViewController.h"

@interface ARSettingsViewController ()

@end

@implementation ARSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

}

- (void)didReceiveMemoryWarning {
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UIFont *font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0];
    cell.textLabel.font = font;
    cell.textLabel.text = @"Logout";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //logout
        [self logOut];
    }
}


- (void)logOut {
    // clear cache
    //    [[PAPCache sharedCache] clear];
    
    // clear NSUserDefaults
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPAPUserDefaultsCacheFacebookFriendsKey];
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPAPUserDefaultsActivityFeedViewControllerLastRefreshKey];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Unsubscribe from push notifications by removing the user association from the current installation.
    [[PFInstallation currentInstallation] removeObjectForKey:kARInstallationUserKey];
    [[PFInstallation currentInstallation] saveInBackground];
    
    // Clear all caches
    [PFQuery clearAllCachedResults];
    
    // Log out
    [PFUser logOut];
    //    ARLoginViewController *login = [[ARLoginViewController alloc] init];
    //    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:login];
    //    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self dismissViewControllerAnimated:YES completion:^{
        //null
    }];
}


@end
