//
//  ARMenuViewController.m
//  ARTwo
//
//  Created by Colororange on 8/24/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARMenuViewController.h"
#import "MSMenuTableViewHeader.h"
#import "MSMenuCell.h"
#import "ARSummaryTableViewController.h"
#import "ARFriendAddAcceptViewController.h"
#import "ARSuggestFriendsViewController.h"
#import "ARSettingsViewController.h"
#import "ARMapViewController.h"
#import "ARProfileViewController.h"
#import "CCBaseNavigationController.h"

NSString * const MSMenuCellReuseIdentifier = @"Drawer Cell";
NSString * const MSDrawerHeaderReuseIdentifier = @"Drawer Header";

typedef NS_ENUM(NSUInteger, MSMenuViewControllerTableViewSectionType) {
  MSMenuViewControllerTableViewSectionTypeSummary,
  MSMenuViewControllerTableViewSectionTypeSocial,
  MSMenuViewControllerTableViewSectionTypeProfile,
  MSMenuViewControllerTableViewSectionTypeSetting,
  MSMenuViewControllerTableViewSectionTypeCount
};

@interface ARMenuViewController ()
@property (nonatomic, strong) NSDictionary *paneViewControllerTitles;
#if defined(STORYBOARD)
@property (nonatomic, strong) NSDictionary *paneViewControllerIdentifiers;
#else
@property (nonatomic, strong) NSDictionary *paneViewControllerClasses;
#endif
@property (nonatomic, strong) NSDictionary *sectionTitles;
@property (nonatomic, strong) NSArray *tableViewSectionBreaks;

@property (nonatomic, strong) UIBarButtonItem *paneStateBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *paneRevealLeftBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *paneRevealRightBarButtonItem;

@end

@implementation ARMenuViewController

#pragma mark - NSObject

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self initialize];
  }
  return self;
}

#pragma mark - UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self initialize];
  }
  return self;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
      [self initialize];
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.tableView registerClass:[MSMenuCell class] forCellReuseIdentifier:MSMenuCellReuseIdentifier];
  [self.tableView registerClass:[MSMenuTableViewHeader class] forHeaderFooterViewReuseIdentifier:MSDrawerHeaderReuseIdentifier];
  self.tableView.backgroundColor = [UIColor clearColor];
  self.tableView.separatorColor = [UIColor colorWithWhite:1.0 alpha:0.25];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MSMenuViewController

- (void)initialize
{
    [self.view setBackgroundColor:[UIColor grayColor]];
  self.paneViewControllerType = NSUIntegerMax;
  self.paneViewControllerTitles = @{
                                    @(MSPaneViewControllerTypeSummary) : @"Summary",
                                    @(MSPaneViewControllerTypeSuggestFriends) : @"SuggestFriends",
                                    @(MSPaneViewControllerTypeSetting) : @"Setting",
                                    @(MSPaneViewControllerTypeMap) : @"My Location",
                                    @(MSPaneViewControllerTypeProfile) : @"Profile"
                                    };
#if !defined(STORYBOARD)
  self.paneViewControllerClasses = @{
                                     @(MSPaneViewControllerTypeSummary) : [ARSummaryTableViewController class],
                                     @(MSPaneViewControllerTypeSuggestFriends) : [ARSuggestFriendsViewController class],
                                     @(MSPaneViewControllerTypeSetting) : [ARSettingsViewController class],
                                     @(MSPaneViewControllerTypeMap): [ARMapViewController class],
                                     @(MSPaneViewControllerTypeProfile) : [ARProfileViewController class]
                                     };
#else
  self.paneViewControllerIdentifiers = @{
                                         @(MSPaneViewControllerTypeSummary) : @"Summary",
                                         @(MSPaneViewControllerTypeSuggestFriends) : @"SuggestFriends",
                                         @(MSPaneViewControllerTypeSetting) : @"Setting",
                                         @(MSPaneViewControllerTypeMap) : @"My Location",
                                         @(MSPaneViewControllerTypeProfile) : @"Profile",
                                         };
#endif
  self.sectionTitles = @{
                         @(MSMenuViewControllerTableViewSectionTypeSummary) : @"Summary",
                         @(MSMenuViewControllerTableViewSectionTypeSocial) : @"Social",
                         @(MSMenuViewControllerTableViewSectionTypeProfile) : @"Profile",
                         @(MSMenuViewControllerTableViewSectionTypeSetting) : @"Setting",
                         };
  
  self.tableViewSectionBreaks = @[
                                  @(MSPaneViewControllerTypeSuggestFriends),
                                  @(MSPaneViewControllerTypeProfile),
                                  @(MSPaneViewControllerTypeSetting),
                                  @(MSPaneViewControllerTypeCount)
                                  ];
}

- (MSPaneViewControllerType)paneViewControllerTypeForIndexPath:(NSIndexPath *)indexPath
{
  MSPaneViewControllerType paneViewControllerType;
  if (indexPath.section == 0) {
    paneViewControllerType = indexPath.row;
  } else {
    paneViewControllerType = ([self.tableViewSectionBreaks[(indexPath.section - 1)] integerValue] + indexPath.row);
  }
  NSAssert(paneViewControllerType < MSPaneViewControllerTypeCount, @"Invalid Index Path");
  return paneViewControllerType;
}

- (void)transitionToViewController:(MSPaneViewControllerType)paneViewControllerType
{
  // Close pane if already displaying the pane view controller
  if (paneViewControllerType == self.paneViewControllerType) {
    [self.dynamicsDrawerViewController setPaneState:MSDynamicsDrawerPaneStateClosed animated:YES allowUserInterruption:YES completion:nil];
    return;
  }
  
  BOOL animateTransition = self.dynamicsDrawerViewController.paneViewController != nil;
  
#if defined(STORYBOARD)
  UIViewController *paneViewController = [self.storyboard instantiateViewControllerWithIdentifier:self.paneViewControllerIdentifiers[@(paneViewControllerType)]];
#else
  Class paneViewControllerClass = self.paneViewControllerClasses[@(paneViewControllerType)];
  UIViewController *paneViewController = (UIViewController *)[paneViewControllerClass new];
#endif
  
  paneViewController.navigationItem.title = self.paneViewControllerTitles[@(paneViewControllerType)];
  
  self.paneRevealLeftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"UIIconHamburger"] style:UIBarButtonItemStyleBordered target:self action:@selector(dynamicsDrawerRevealLeftBarButtonItemTapped:)];
  paneViewController.navigationItem.leftBarButtonItem = self.paneRevealLeftBarButtonItem;
  
//  self.paneRevealRightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Right Reveal Icon"] style:UIBarButtonItemStyleBordered target:self action:@selector(dynamicsDrawerRevealRightBarButtonItemTapped:)];
//  paneViewController.navigationItem.rightBarButtonItem = self.paneRevealRightBarButtonItem;
  
  CCBaseNavigationController *paneNavigationViewController = [[CCBaseNavigationController alloc] initWithRootViewController:paneViewController];
  [self.dynamicsDrawerViewController setPaneViewController:paneNavigationViewController animated:animateTransition completion:nil];
  
  self.paneViewControllerType = paneViewControllerType;
}

- (void)dynamicsDrawerRevealLeftBarButtonItemTapped:(id)sender
{
  [self.dynamicsDrawerViewController setPaneState:MSDynamicsDrawerPaneStateOpen inDirection:MSDynamicsDrawerDirectionLeft animated:YES allowUserInterruption:YES completion:nil];
}

- (void)dynamicsDrawerRevealRightBarButtonItemTapped:(id)sender
{
  [self.dynamicsDrawerViewController setPaneState:MSDynamicsDrawerPaneStateOpen inDirection:MSDynamicsDrawerDirectionRight animated:YES allowUserInterruption:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return MSMenuViewControllerTableViewSectionTypeCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (section == 0) {
    return [self.tableViewSectionBreaks[section] integerValue];
  } else {
    return ([self.tableViewSectionBreaks[section] integerValue] - [self.tableViewSectionBreaks[(section - 1)] integerValue]);
  }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  UITableViewHeaderFooterView *headerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:MSDrawerHeaderReuseIdentifier];
  headerView.textLabel.text = [self.sectionTitles[@(section)] uppercaseString];
  return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return 30.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
  return FLT_EPSILON;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MSMenuCellReuseIdentifier forIndexPath:indexPath];
  cell.textLabel.text = self.paneViewControllerTitles[@([self paneViewControllerTypeForIndexPath:indexPath])];
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  MSPaneViewControllerType paneViewControllerType = [self paneViewControllerTypeForIndexPath:indexPath];
  [self transitionToViewController:paneViewControllerType];
  
  // Prevent visual display bug with cell dividers
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  double delayInSeconds = 0.3;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [self.tableView reloadData];
  });
}

@end
