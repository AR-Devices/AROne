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


@interface ARProfileViewController () <DZNSegmentedControlDelegate>
//@property (nonatomic, strong) DZNSegmentedControl *control;
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) ARProfileHeaderView *headerView;

@end

@implementation ARProfileViewController

- (void)loadView
{
    [super loadView];
    
    self.title = @"User Profile";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSegment:)];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshSegments:)];
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
    self.headerView.userName.text = [[PFUser currentUser] objectForKey:@"name"];
    [self.headerView.userIcon setImageWithString:self.headerView.userName.text];
//    self.headerView.control.delegate = self;
    self.headerView.control.selectedSegmentIndex = 0;
    [self.headerView.control addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];

    
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(reloadView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
}

- (void)selectedSegment:(DZNSegmentedControl *)sender {
    NSLog(@"clicked on %ld", (long)sender.selectedSegmentIndex);
}

- (void)reloadView {
    NSLog(@"reload view here");
    //    [control setCount:@(12) forSegmentAtIndex:0];
    //    [control setTitle:@"Hello" forSegmentAtIndex:1];
    //    [control setEnabled:NO forSegmentAtIndex:2];
    [self.refreshControl endRefreshing];
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 10;
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

@end
