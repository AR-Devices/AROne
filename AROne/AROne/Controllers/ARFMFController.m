//
//  ARFMFController.m
//  AROne
//
//  Created by Chenchen Zheng on 1/1/15.
//  Copyright (c) 2015 Chenchen Zheng. All rights reserved.
//

#import "ARFMFController.h"
#import "ARFriendTableViewCell.h"

@interface ARFMFController ()

@property (nonatomic, strong) NSArray *friendList;

@end

@implementation ARFMFController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FMF";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ARFriendTableViewCell" bundle:nil] forCellReuseIdentifier:@"AppCell"];
    
    PFQuery *activityQuery = [PFQuery queryWithClassName:@"Activity"];
    [activityQuery whereKey:@"fromUser" equalTo: [PFUser currentUser]];
    [activityQuery includeKey:@"toUser"];
    [activityQuery findObjectsInBackgroundWithBlock:^(NSArray *activities, NSError *error) {
        [SVProgressHUD dismiss];
        NSMutableArray *toUser = [NSMutableArray new];
        for (id activity in activities) {
            NSString *username = [[activity objectForKey:@"toUser"] objectForKey:@"username"];
            [toUser addObject:username];
        }
        //        [toUser addObject:[[PFUser currentUser] objectForKey:@"username"]];
        PFQuery *friendQuery = [PFUser query];
        //        [friendQuery whereKey:@"username" containedIn:toUser];
        [friendQuery findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
            NSLog(@"users are %@", users);
            self.friendList = users;
            [self.tableView reloadData];
        }];
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.friendList count]) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friendList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ARFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppCell" forIndexPath:indexPath];
    PFUser *user = [self.friendList objectAtIndex:indexPath.row];
    if (user[@"name"]) {
        cell.userName.text = user[@"name"];
    } else if (user[@"displayname"]) {
        cell.userName.text = user[@"displayname"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 63;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
