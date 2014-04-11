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

#import "ARSummary.h"
#import "ARCommon.h"



@interface ARScoreboardViewController ()

@property UIView *comboBar;
@property NSInteger topBarStyle;
@property NSArray * scoreboard_array_cloud;

@end

@implementation ARScoreboardViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
      self.title = @"Scoreboard";
      self.edgesForExtendedLayout = UIRectEdgeNone;
      [self createToolBar];
      //    d4dee6
      self.tableView.backgroundColor = [UIColor colorWithRed:212.0/255.0 green:222.0/255.0 blue:230.0/255.0 alpha:1.0];
      [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
  [self querySummaryData:@"day"];
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
    return [self.scoreboard_array_cloud count];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	UIView* footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
	footer.backgroundColor = [UIColor clearColor];
	footer.autoresizingMask = UIViewAutoresizingNone;
	return footer;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 10)];
  header.backgroundColor = [UIColor clearColor];
  header.autoresizingMask = UIViewAutoresizingNone;
  return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 0.0f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return SECTION_CELL_X_HEIGHT-10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%ld",(long)indexPath.section];
  UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  
  //  a18ac1 purple
  //  2fb3b6 Cyan
  //  ee962f orange
  //  ffffff white
  //
  if (self.scoreboard_array_cloud) {
    NSDictionary * dict = [self.scoreboard_array_cloud objectAtIndex:indexPath.row];
    NSString *score;
    NSMutableDictionary *data = [NSMutableDictionary new];
    @try {
      
      NSDictionary *player = [dict objectForKey:@"player"];
      NSString *name = [player objectForKey:@"name"];
      PFFile *iconFile = [player objectForKey:@"userIcon"];
      NSData *iconData = [iconFile getData];
//      UIImage *userIcon = [UIImage imageWithData:iconData];
      NSLog(@"who is %@", name);
      [data setObject:name forKey:@"who"];
      [data setObject:iconData forKey:@"userIcon"];
    }
    @catch (NSException *exception) {
      NSLog(@"Exception: %@", exception);
    }
    @finally {
      //nothing
    }

    
    ARRankStyle rank = ARNormal;
    if (indexPath.row == 0) {
      rank = ARGold;
    }
    switch (self.topBarStyle) {
      case ARScoreBoardCellStyleMaxSpeed:
        score = [NSString stringWithFormat:@"%0.1f", [[dict objectForKey:@"maxSpeed"] doubleValue]];
        break;
      case ARScoreBoardCellStyleVerticalDrop:
        score = [NSString stringWithFormat:@"%ld", (long)[[dict objectForKey:@"verticalDrop"] integerValue]];
        break;
      case ARScoreBoardCellStyleAcceleration:
        score = [NSString stringWithFormat:@"%0.1f", [[dict objectForKey:@"maxAcceleration"] doubleValue]];
        break;
    }
    [data setObject:score forKey:@"score"];
    cell = [ARScoreBoardCell cellWithStyle:self.topBarStyle rank:rank andData:data];
  }
  //number cgrect 394 136
  cell.selectionStyle = UITableViewCellEditingStyleNone;
  cell.backgroundColor = [UIColor clearColor];
  
  return cell;
}

- (void) querySummaryData: (NSString *)period {
  NSString *dataType;
  switch (self.topBarStyle) {
    case ARScoreBoardCellStyleMaxSpeed:
      dataType = @"maxSpeed";
      break;
    case ARScoreBoardCellStyleVerticalDrop:
      dataType = @"maxAcceleration";
      break;
    case ARScoreBoardCellStyleAcceleration:
      dataType = @"verticalDrop";
      break;
  }
  NSString *myStartDate;
  NSString *myEndDate;
  
  NSDate *date = [NSDate new];
  [date descriptionWithLocale:[NSLocale systemLocale]];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  NSString *today = [dateFormatter stringFromDate:date];
  NSCalendar* calendar = [NSCalendar currentCalendar];
  NSDateComponents* comps = [calendar components:NSYearForWeekOfYearCalendarUnit |NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
  
  [comps setWeekday:2]; // 2: monday
  NSDate *firstDayOfTheWeek = [calendar dateFromComponents:comps];
  NSString *firstDayOfTheWeek_string = [dateFormatter stringFromDate:firstDayOfTheWeek];

  [comps setWeekday:7]; // 7: saturday
  NSDate *lastDayOfTheWeek = [calendar dateFromComponents:comps];
  NSString *lastDayOfTheWeek_string = [dateFormatter stringFromDate:lastDayOfTheWeek];

  [comps setDay:1];
  NSDate *firstDayOfMonth = [calendar dateFromComponents:comps];
  NSString *firstDayOfMonth_string = [dateFormatter stringFromDate:firstDayOfMonth];

  comps.month = comps.month+1;
  [comps setDay:0];
  NSDate *lastDayOfMonth = [calendar dateFromComponents:comps];
  NSString *lastDayOfMonth_string = [dateFormatter stringFromDate:lastDayOfMonth];

  NSLog(@"!******%@", firstDayOfTheWeek_string);
  NSLog(@"7******%@", lastDayOfTheWeek_string);
  NSLog(@"0******%@", firstDayOfMonth_string);
  NSLog(@"31******%@", lastDayOfMonth_string);

  
  if([period isEqualToString:@"day"]){
    myStartDate = today;
    myEndDate = today;
  }else if([period isEqualToString:@"week"]){
    myStartDate = firstDayOfTheWeek_string;
    myEndDate = lastDayOfTheWeek_string;
  }else if([period isEqualToString:@"month"]){
    myStartDate = firstDayOfMonth_string;
    myEndDate = lastDayOfMonth_string;
  }else{
    myStartDate = today;
    myEndDate = today;
  }
  [PFCloud callFunctionInBackground:@"scoreBoard" withParameters:@{@"date": [ARCommon today],@"datatype": dataType , @"startDate": myStartDate, @"endDate":myEndDate}
 block:^(NSArray * result, NSError *error) {
    if (!error) {
      self.scoreboard_array_cloud = result;
      NSLog(@"=====================%@", result);
      [self.tableView reloadData];
    }
  }];
  //FIXIT: Need to compare with selected date from Top calender bar, and this query has to be
//  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//  [formatter setDateFormat:@"yyyy-MM-dd"];
//  [query whereKey:@"date" equalTo:[formatter stringFromDate:self.myDate]];
//  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//    if (!error && ([objects count] != 0)) {
//      ARSummary *firstMeasurement = objects[0];
//
//    [self.tableView reloadData];
//  }];
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
  ARTopBarView *topbar = [[ARTopBarView alloc] initWithStyle:ARTopBarViewStyleSelector viewBounds:self.view.bounds withBlock:^(UISegmentedControl *segment) {
    //  ccz: use this later... I'm thinking to vreate a seperate view for this top bar
    [segment addTarget:self action:@selector(segmentAction_topBar:) forControlEvents:UIControlEventValueChanged];
  }];
//  topbar.translatesAutoresizingMaskIntoConstraints = NO;

  ARTopBarView *dateBar = [[ARTopBarView alloc] initWithStyle:ARTopBarViewStyleDWMSmall viewBounds:self.view.bounds withBlock:^(ARTopBarView *segment) {
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
  }];
  dateBar.translatesAutoresizingMaskIntoConstraints = NO;

  
  UIView* spacer = [UIView new];
  spacer.backgroundColor = [[UIColor redColor] colorWithAlphaComponent: 0.5];
  spacer.translatesAutoresizingMaskIntoConstraints = NO;
//  spacer.hidden = YES; // comment out to show spacer!
  
  self.comboBar= [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 66)];
//  [comboView insertSubview:topbar atIndex:0];

  [self.comboBar addSubview:topbar];
  [self.comboBar addSubview:dateBar];
//  [comboView addSubview:spacer];
  NSDictionary* views = NSDictionaryOfVariableBindings( topbar, dateBar );
  
  // Center the two views horizontally
//  [comboView addConstraint:[NSLayoutConstraint constraintWithItem:topbar
//                                                        attribute:NSLayoutAttributeCenterX
//                                                        relatedBy:NSLayoutRelationEqual
//                                                           toItem:comboView
//                                                        attribute:NSLayoutAttributeCenterX
//                                                       multiplier:1
//                                                         constant:0]];
//  
//  [comboView addConstraint:[NSLayoutConstraint constraintWithItem:dateBar
//                                                        attribute:NSLayoutAttributeCenterX
//                                                        relatedBy:NSLayoutRelationEqual
//                                                           toItem:comboView
//                                                        attribute:NSLayoutAttributeCenterX
//                                                       multiplier:1
//                                                         constant:0]];
  
  // Position the two views one below the other, using the separator height defined above
  [self.comboBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topbar(32.5)]-0-[dateBar(32.5)]"
                                                                    options:0
                                                                    metrics:0
                                                                      views:views]];
  
  // Force the button distance from the bottom to be the half of the size of the content
//  CGFloat constant = (imageview.frame.size.height + button.frame.size.height + [sepHeight floatValue]) / 2.0;
//  [comboView addConstraint:[NSLayoutConstraint constraintWithItem:button
//                                                        attribute:NSLayoutAttributeBottom
//                                                        relatedBy:NSLayoutRelationEqual
//                                                           toItem:self.view
//                                                        attribute:NSLayoutAttributeCenterY
//                                                       multiplier:1
//                                                         constant:constant]];
  
  self.tableView.tableHeaderView = self.comboBar;
}

//trying to keep the header at top but failed
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//  NSLog(@"called");
//  CGRect rect = self.comboBar.bounds;
//  rect.origin.y = MIN(0, -self.tableView.contentOffset.y);
//  NSLog(@"rect.origin.y is %f", rect.origin.y);
//  self.tableView.tableHeaderView.bounds = rect;
//}

//note default is DAY!
- (void)segmentAction_topBar:(UISegmentedControl *)sender {
  switch ([sender selectedSegmentIndex]) {
    case 0:
      self.topBarStyle = ARScoreBoardCellStyleMaxSpeed;
      [self querySummaryData:@"day"];
      break;
    case 1:
      self.topBarStyle = ARScoreBoardCellStyleVerticalDrop;
      [self querySummaryData:@"day"];
      break;
    case 2:
      self.topBarStyle = ARScoreBoardCellStyleAcceleration;
      [self querySummaryData:@"day"];
      break;
  }
}
- (void)segmentAction:(UISegmentedControl *)sender {
  switch ([sender selectedSegmentIndex]) {
    case 0:
      NSLog(@"DAY");
      [self querySummaryData:@"day"];
      break;
    case 1:
      NSLog(@"WEEK");
      [self querySummaryData:@"week"];
      break;
    case 2:
      NSLog(@"MONTH");
      [self querySummaryData:@"month"];
      break;
  }
}

@end
