//
//  ARScoreboardViewController.m
//  AROne
//
//  Created by Chenchen Zheng on 9/4/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "UIViewController+AKTabBarController.h"

#import "ARScoreboardViewController.h"

#import "ARScoreBoardCell.h"
#import "ARTopBarView.h"

@interface ARScoreboardViewController ()

@end

@implementation ARScoreboardViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
      self.title = @"Scoreboard";
      [self createToolBar];
      //    d4dee6
      self.tableView.backgroundColor = [UIColor colorWithRed:212.0/255.0 green:222.0/255.0 blue:230.0/255.0 alpha:1.0];

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
//TODO: check data here
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	UIView* footer = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 30)];
	footer.backgroundColor = [UIColor clearColor];
	footer.autoresizingMask = UIViewAutoresizingNone;
	return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 30.0f/2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 216/1.9;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.section];
  UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  
  //  a18ac1 purple
  //  2fb3b6 Cyan
  //  ee962f orange
  //  ffffff white
  cell = [ARScoreBoardCell cellWithStyle:ARScoreBoardCellStyleMaxSpeed andValue:@"56"];
//  if (indexPath.section == 0) {
//    cell = [ARScoreBoardCell cellWithStyle:@"Max Speed" andValue:@"123"];
//  } else if (indexPath.section == 1) {
//    cell = [ARScoreBoardCell cellWithStyle:@"Vertical Drop" andValue:@"234" ];
//  } else if (indexPath.section == 2) {
//    cell = [ARScoreBoardCell cellWithStyle:@"Acceleration" andValue:@"345"];
//  }
  //number cgrect 394 136
  cell.selectionStyle = UITableViewCellEditingStyleNone;
  cell.backgroundColor = [UIColor clearColor];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  NSLog(@"clicked at %d", indexPath.row);
  
}


/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark - AKTabBarController Data Source
- (NSString *)tabImageName
{
	return @"scoreboard_icon";
}

- (NSString *)activeTabImageName
{
	return @"scoreboard_icon";
}

//- (NSString *)tabTitle
//{
//	return self.title;
//}


- (void) createToolBar
{
  ARTopBarView *topbar = [[ARTopBarView alloc] initWithStyle:ARTopBarViewStyleDWM viewBounds:self.view.bounds withBlock:^(UISegmentedControl *segment) {
    //  ccz: use this later... I'm thinking to vreate a seperate view for this top bar
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
  }];
  self.tableView.tableHeaderView = topbar;
}

//note default is DAY!
- (void)segmentAction:(UISegmentedControl *)sender {
  switch ([sender selectedSegmentIndex]) {
    case 0:
      NSLog(@"DAY");
      break;
    case 1:
      NSLog(@"WEEK");
      break;
    case 2:
      NSLog(@"MONTH");
      break;
  }
}

@end
