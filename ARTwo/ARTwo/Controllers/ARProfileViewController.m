//
//  ARProfileViewController.m
//  ARTwo
//
//  Created by Chenchen Zheng on 8/9/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARProfileViewController.h"
#import "DZNSegmentedControl.h"
#import "ARProfileHeaderView.h"
#import "UIImageView+Letters.h"
#import "ARUserTableViewCell.h"
#import "BMInitialsPlaceholderView.h"


@interface ARProfileViewController () <DZNSegmentedControlDelegate>
//@property (nonatomic, strong) DZNSegmentedControl *control;
@property (nonatomic, strong) ARProfileHeaderView *headerView;
@property (nonatomic, strong) NSArray *follower;
@property (nonatomic, strong) NSArray *following;
@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, strong) NSArray *selectedSegment;

@end

@implementation ARProfileViewController

- (void)loadView
{
    [super loadView];
    
    self.title = @"User Profile";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSegment:)];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshSegments:)];
    if (self.user == NULL) {
        NSLog(@"user is null!?");
        self.user = [PFUser currentUser];
    }
    [self setupView];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    //add header
//    UINib *nib = [UINib nibWithNibName:@"ARProfileHeaderView" bundle:nil];
//    self.headerView = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    self.headerView = [[ARProfileHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 250)];
//    self.headerView.userName.text = [[PFUser currentUser] objectForKey:@"name"];
    self.headerView.userName.text = [self.user objectForKey:@"name"];
    [self.headerView.userIcon setImageWithString:self.headerView.userName.text];
//    self.headerView.control.delegate = self;
    self.headerView.control.selectedSegmentIndex = 0;
    [self.headerView.control addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
    self.selectedSegment = self.following;
    [self reloadView];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(reloadView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    
}

- (void)selectedSegment:(DZNSegmentedControl *)sender {
    NSLog(@"clicked on %ld", (long)sender.selectedSegmentIndex);
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.selectedSegment = self.following;
            break;
        case 1:
            self.selectedSegment = self.follower;
            break;
        case 2:
            self.selectedSegment = self.friends;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

- (void)reloadView {
    NSLog(@"reload view here");
    PFQuery *followingQuery = [PFQuery queryWithClassName:@"Activity"];
    PFQuery *followedQuery = [PFQuery queryWithClassName:@"Activity"];
    PFQuery *friendsQuery = [PFQuery queryWithClassName:@"Activity"];
    
    //following: user who are following me,
//    [followingQuery whereKey:@"fromUser" equalTo:[PFUser currentUser]];
    [followedQuery whereKey:@"fromUser" equalTo:self.user];
    [followingQuery includeKey:@"fromUser"];
    [followingQuery includeKey:@"toUser"];
    [followingQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.following = objects;
        NSLog(@"following %@", self.following);
        //followed;
//        [followedQuery whereKey:@"toUser" equalTo:[PFUser currentUser]];
        [followedQuery whereKey:@"toUser" equalTo:self.user];
        [followedQuery includeKey:@"fromUser"];
        [followedQuery includeKey:@"toUser"];
        [followedQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            self.follower = objects;
            NSLog(@"followed %@", self.follower);
            //friends:
//            [followedQuery whereKey:@"toUser" equalTo:[PFUser currentUser]];
            [followedQuery whereKey:@"toUser" equalTo:self.user];
            [friendsQuery whereKey:@"toUser" matchesKey:@"fromUser" inQuery:followedQuery];
            [friendsQuery includeKey:@"fromUser"];
            [friendsQuery includeKey:@"toUser"];
            [friendsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                self.friends = objects;
                NSLog(@"friends %@", self.friends);
                [self.headerView.control setCount:@([self.following count])  forSegmentAtIndex:0];
                [self.headerView.control setCount:@([self.follower count]) forSegmentAtIndex:1];
                [self.headerView.control setCount:@([self.friends count]) forSegmentAtIndex:2];
                [self selectedSegment:self.headerView.control];
                if (self.refreshControl) {
                    [self.refreshControl endRefreshing];
                }
            }];
        }];
    }];
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.selectedSegment count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ARUserTableViewCell *cell = (ARUserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kViewControllerCellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:kViewControllerCellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
        NSLog(@"row is %ld", (long)indexPath.row);
        PFUser *user = [self.selectedSegment objectAtIndex:indexPath.row];
        if(self.headerView.control.selectedSegmentIndex == 0){
            user = (PFUser*)[[self.following objectAtIndex:indexPath.row] objectForKey:@"toUser"];
        }else if(self.headerView.control.selectedSegmentIndex == 1){
            user = (PFUser*)[[self.follower objectAtIndex:indexPath.row] objectForKey:@"fromUser"];
        }else if(self.headerView.control.selectedSegmentIndex == 2){
            user = (PFUser*)[[self.friends objectAtIndex:indexPath.row] objectForKey:@"toUser"];
        }
        NSString *person = [user objectForKey:@"name"];
        NSLog(@"person is %@", person);
        UIFont *font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0];
        
        cell.userName.font = font;
        cell.userName.text = person;
        cell.userIcon.font = font;
        cell.userIcon.initials = [self initialStringForPersonString:person];
        cell.userIcon.circleColor = [self circleColorForIndexPath:indexPath];
        //        cell.accessoryView = placeholder;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ARProfileViewController *profile = [ARProfileViewController new];
    if(self.headerView.control.selectedSegmentIndex == 0){
        profile.user = (PFUser*)[[self.following objectAtIndex:indexPath.row] objectForKey:@"toUser"];
    }else if(self.headerView.control.selectedSegmentIndex == 1){
        profile.user = (PFUser*)[[self.follower objectAtIndex:indexPath.row] objectForKey:@"fromUser"];
    }else if(self.headerView.control.selectedSegmentIndex == 2){
        profile.user = (PFUser*)[[self.friends objectAtIndex:indexPath.row] objectForKey:@"toUser"];
    }
    [self.navigationController pushViewController:profile animated:YES];

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.headerView.bounds.size.height;
    }
    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = self.headerView.bounds.size.height - self.headerView.control.bounds.size.height;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}


//need improve
- (UIColor *)circleColorForIndexPath:(NSIndexPath *)indexPath {
    return [UIColor colorWithHue:arc4random() % 256 / 256.0 saturation:0.7 brightness:0.8 alpha:1.0];
}

- (NSString *)initialStringForPersonString:(NSString *)personString {
    NSArray *comps = [personString componentsSeparatedByString:@" "];
    if ([comps count] >= 2) {
        NSString *firstName = comps[0];
        NSString *lastName = comps[1];
        return [NSString stringWithFormat:@"%@%@", [firstName substringToIndex:1], [lastName substringToIndex:1]];
    } else if ([comps count]) {
        NSString *name = comps[0];
        return [name substringToIndex:1];
    }
    return @"Unknown";
}
@end
