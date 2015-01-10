//
//  ARFriendListController.m
//  ARTwo
//
//  Created by Chenchen Zheng on 7/27/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARFriendListController.h"
#import "BMInitialsPlaceholderView.h"
#import "ARUserTableViewCell.h"


@interface ARFriendListController ()
@property (strong) NSArray *userArray;

@end

@implementation ARFriendListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Friends";

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.userArray = [NSArray new];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    [self.tableView registerClass:[ARUserTableViewCell class] forCellReuseIdentifier:kViewControllerCellIdentifier];
//    self.tableView.contentInset = self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(20, 0, 0, 0);

    PFQuery *userQuery = [PFUser query];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        self.userArray = users;
        [self.tableView reloadData];    
        NSLog(@"userArray is %@", self.userArray);
    }];
    
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
    return [self.userArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kViewControllerCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ARUserTableViewCell *cell = (ARUserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kViewControllerCellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:kViewControllerCellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
//        ARUserTableViewCell *cell = [[ARUserTableViewCell alloc] init];
        NSLog(@"row is %ld", (long)indexPath.row);
        PFUser *user = [self.userArray objectAtIndex:indexPath.row];
        NSString *person = [user objectForKey:@"name"];
        NSLog(@"person is %@", person);
        UIFont *font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0];
        CGFloat placeholderHW = kViewControllerCellHeight - 15;
        
        BMInitialsPlaceholderView *placeholder = [[BMInitialsPlaceholderView alloc] initWithDiameter:placeholderHW];
        placeholder.font = font;
        placeholder.initials = [self initialStringForPersonString:person];
        placeholder.circleColor = [self circleColorForIndexPath:indexPath];
        
        cell.userName.font = font;
        cell.userName.text = person;
        cell.userIcon.font = font;
        cell.userIcon.initials = [self initialStringForPersonString:person];
        cell.userIcon.circleColor = [self circleColorForIndexPath:indexPath];
//        cell.accessoryView = placeholder;
    }

    
    return cell;
}

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
