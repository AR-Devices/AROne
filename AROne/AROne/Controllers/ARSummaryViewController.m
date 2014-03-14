//
//  ARSummaryViewController.m
//  AROne
//
//  Created by Chenchen Zheng on 9/4/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "UIViewController+AKTabBarController.h"
#import "UINavigationController+SGProgress.h"
#import "AKSegmentedControl.h"

#import "ARSummaryViewController.h"
#import "ARSummaryGraphViewController.h"
#import <QuartzCore/QuartzCore.h>
//tableviewcell
#import "ARSummaryCell.h"
#import "ARTopBarView.h"

#import "ARLoginViewController.h"
#import "ARSettingViewController.h"

//Parse Object
#import "ARCommon.h"
#import "ARSummary.h"



@interface ARSummaryViewController ()
@property(atomic, strong) NSString* max_speed_value;
@property(atomic, strong) NSString* vertical_drop_value;
@property(atomic, strong) NSString* acceleration_value;
@property(atomic) NSInteger sync_button_value; //REMOVEME use it temporary to indicate whether it's clicked or unclicked. 1=clicked -1=unclicked


@property(nonatomic, strong) NSCalendar * cal;
@property(nonatomic, strong) NSDateComponents *components;
@property(nonatomic, strong) NSDate *myDate;
@property(nonatomic) NSInteger dateCounter;
@property(atomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) UIImage *userIcon;

@end

@implementation ARSummaryViewController
@synthesize pmCC;

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    self.title = @"Summary";
    [self createToolBar];
//    d4dee6
    self.tableView.backgroundColor = [UIColor colorWithRed:212.0/255.0 green:222.0/255.0 blue:230.0/255.0 alpha:1.0];
    self.sync_button_value = 1;
  }
  return self;
}


- (void)viewDidLoad
{
  [super viewDidLoad];

//  add left sync botton, or pull down to refresh
  [self createLeftBarButtons];
//  add right refresh setting button
  [self createRightBarButtons];

  
  //FIXME: temporary hardcored the value here
//  self.max_speed_value = @"34";
//  self.vertical_drop_value = @"35,000";
//  self.acceleration_value = @"9.8";
  self.sync_button_value = -1;
  [self querySummaryData];
  [self queryUserData];
  
}

- (void) querySummaryData {
  PFQuery *query = [ARSummary query];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd"];
  [query whereKey:@"date" equalTo:[formatter stringFromDate:self.myDate]];
  [query whereKey:@"player" equalTo:[PFUser currentUser]];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error && ([objects count] != 0)) {
      ARSummary *firstMeasurement = objects[0];
      NSLog(@"firstMeasuremetn is %@", firstMeasurement);
      // ...
      self.max_speed_value = [NSString stringWithFormat:@"%0.1f",firstMeasurement.maxSpeed];
      self.vertical_drop_value = [NSString stringWithFormat:@"%d", firstMeasurement.verticalDrop];
      self.acceleration_value = [NSString stringWithFormat:@"%0.1f", firstMeasurement.maxAcceleration];
    } else {
      self.max_speed_value = @"0";
      self.vertical_drop_value = @"0";
      self.acceleration_value = @"0";
    }
    [self.tableView reloadData];
  }];
}

- (void) queryUserData {
//  self.userName = [PFUser.currentUser[@"name"] stringValue];
  NSLog(@"name is %@",[PFUser currentUser][@"name"]);
  self.userName = [PFUser currentUser][@"name"];
  [self.tableView reloadData];
//  [PFUser.currentUser[@"isPrivate"] boolValue];
//  PFQuery *query = [PFQuery queryWithClassName:@"User"];
//  NSLog(@"username 1 is %@", [PFUser currentUser].username);
//  [query whereKey:@"username" equalTo:[PFUser currentUser].username];
//  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//    if (!error && ([objects count] != 0)) {
////      PFUser *user = objects[0];
//      NSLog(@"objects are %@", objects);
////      [objects[0] objectForKey:@"user"];
////      NSLog(@"username is %@", user.username);
////      self.userName = objects[0];
////      [self.tableView reloadData];
//    }
//  }];
  
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  if (section == 0) {
    UIView *header = [self createQuickPersonalView];
    return header;
  }
  return nil;
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  if (section == 0) {
    return 80.0f;
  }
	return 0.0f;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
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
  if (indexPath.section == 0) {
    NSLog(@"self.view.bounds is %f", self.view.bounds.size.width);
    cell = [ARSummaryCell cellWithStyle:ARSummaryCellStyleMaxSpeed andValue:self.max_speed_value rect:self.view.bounds];
  } else if (indexPath.section == 1) {
    cell = [ARSummaryCell cellWithStyle:ARSummaryCellStyleVerticalDrop andValue:self.vertical_drop_value rect:self.view.bounds ];
  } else if (indexPath.section == 2) {
    cell = [ARSummaryCell cellWithStyle:ARSummaryCellStyleAcceleration andValue:self.acceleration_value rect:self.view.bounds ];
  }
  //number cgrect 394 136
  cell.selectionStyle = UITableViewCellEditingStyleNone;
  cell.backgroundColor = [UIColor clearColor];
  
  return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"clicked at %ld", (long)indexPath.section);
  ARSummaryGraphCellStyle functionGraphStyle;
  switch(indexPath.section) {
    case 0:
      functionGraphStyle = ARSummaryGraphCellStyleMaxSpeed;
      break;
    case 1:
      functionGraphStyle = ARSummaryGraphCellStyleVerticalDrop;
      break;
    case 2:
      functionGraphStyle = ARSummaryGraphCellStyleAcceleration;
      break;
    default:
      functionGraphStyle = ARSummaryGraphCellStyleMaxSpeed;
      break;
  }
  NSLog(@"mydate is %@", self.myDate);
  ARSummaryGraphViewController *summaryTabGraph = [[ARSummaryGraphViewController alloc] init];
  summaryTabGraph.selectedDate = self.myDate;
//  NSLog(@"mydate is %@", self.myDate);
  summaryTabGraph.graphStyle = functionGraphStyle;
//  UINavigationController *summaryNavi = [[UINavigationController alloc] initWithRootViewController:summaryTabGraph];
// Set this in every view controller so that the back button displays back instead of the root view controller name
//  no text on back button
  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
  [self.navigationController pushViewController:summaryTabGraph animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
//  NSLog(@"clicked at %d", indexPath.row);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//  NSLog(@"contentOffset.y is %f", scrollView.contentOffset.y);
  CGFloat sectionHeaderHeight = 60;
  if (scrollView.contentOffset.y <= sectionHeaderHeight &&
      scrollView.contentOffset.y >= 0) {
    scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
  } else if (scrollView.contentOffset.y >= 0) {
    scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
  }
}

#pragma mark - AKTabBarController Data Source
- (NSString *)tabImageName
{
	return @"home_icon";
}

- (NSString *)activeTabImageName
{
	return @"home_icon_selected";
}

//- (NSString *)tabTitle
//{
//	return self.title;
//}

#pragma mark - Private Methods

/**
 * @desc CCZ: Quick Personal View is the top view with Shao Peng's face
 * @param null
 * @return configured UIView
 */
- (UIView *) createQuickPersonalView
{
  UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,100)];
  header.backgroundColor = [UIColor clearColor];
  header.autoresizingMask = UIViewAutoresizingNone;
  
  CGRect imageRect = CGRectMake(10, 10, 76/1.9, 75/1.9);
  UIImageView *personIcon = [[UIImageView alloc] initWithFrame:imageRect];
  personIcon.image = [UIImage imageNamed:@"profile_hp"];
  [header addSubview:personIcon];
//  user Name, in the future 
  UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, self.view.bounds.size.width - 90, 25)];
  name.font = [UIFont fontWithName:@"Avenir-Medium" size:30.0/1.9];
  name.textColor = [UIColor colorWithRed:109.0/255.0f green:109.0/255.0f blue:109.0/255.0f alpha:1.0];

  name.text = self.userName;
  name.backgroundColor = [UIColor clearColor];
  [header addSubview:name];

  //the colored box, whose text/score is extracted from the scores in the secitions below
  UILabel *maxspeed_text = [[UILabel alloc] initWithFrame:CGRectMake(60+(40+5)*0, 40, 40, 15)];
  maxspeed_text.font = [UIFont fontWithName:@"Avenir-Roman" size:11.0];
  maxspeed_text.textColor = [UIColor whiteColor];
  maxspeed_text.text = self.max_speed_value; //FIXME value should be extracted from section text
  maxspeed_text.textAlignment = NSTextAlignmentCenter;
  maxspeed_text.backgroundColor = [UIColor colorWithRed:161/255.0f green:138/255.0f blue:193/255.0f alpha:1];
  [header addSubview:maxspeed_text];
  
  UILabel *verticaldrop_text = [[UILabel alloc] initWithFrame:CGRectMake(60+(40+5)*1, 40, 40, 15)];
  verticaldrop_text.font = [UIFont fontWithName:@"Avenir-Roman" size:11.0];
  verticaldrop_text.textColor = [UIColor whiteColor];
  verticaldrop_text.text = self.vertical_drop_value; //FIXME value should be extracted from section text
  verticaldrop_text.textAlignment = NSTextAlignmentCenter;
  verticaldrop_text.backgroundColor = [UIColor colorWithRed:47/255.0f green:179/255.0f blue:182/255.0f alpha:1];
  [header addSubview:verticaldrop_text];
  
  UILabel *acceleration_text = [[UILabel alloc] initWithFrame:CGRectMake(60+(40+5)*2, 40, 40, 15)];
  acceleration_text.font = [UIFont fontWithName:@"Avenir-Roman" size:11.0];
  acceleration_text.textColor = [UIColor whiteColor];
  acceleration_text.text = self.acceleration_value; //FIXME value should be extracted from section text
  acceleration_text.textAlignment = NSTextAlignmentCenter;
  acceleration_text.backgroundColor = [UIColor colorWithRed:238/255.0f green:150/255.0f blue:47/255.0f alpha:1];
  [header addSubview:acceleration_text];

  return header;
}


/**
 * @desc CCZ: this is the top calender tool bar with left and right arrow plus date.
 * @param null
 * @return null
 */
- (void) createToolBar
{
  // set up calender, MUST be used before call createTooBar
  self.cal = [NSCalendar currentCalendar];
  self.components = [self.cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:[[NSDate alloc] init]];
  self.dateCounter = 0;
  [self.components setHour:-[self.components hour]];
  [self.components setMinute:-[self.components minute]];
  [self.components setSecond:-[self.components second]];
  
  
  //TODO: might need to create a universal one
  //get current date information
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"MM dd yyyy"];
  if(self.myDate){
  } else {
    self.myDate = [self.cal dateByAddingComponents:self.components toDate:[[NSDate alloc] init] options:0]; //This variable should now be pointing at a date object that is the start of today (midnight);
  }
  NSString *stringFromDate = [formatter stringFromDate:self.myDate];
  ARTopBarView *topbar = [[ARTopBarView alloc] initWithStyle:ARTopBarViewStyleCalendar viewBounds:self.view.bounds withBlock:^(ARTopBarView *segment) {
    self.segment = segment;
    [segment setTitle:stringFromDate forSegmentAtIndex:1];
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
  }];
  
  self.tableView.tableHeaderView = topbar;

}

//this is for calender stuff
-(void) segmentAction: (UISegmentedControl *)sender
{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"MM dd yyyy"];
  NSString *stringFromDate = [formatter stringFromDate:self.myDate];
  NSLog(@"today is %@", stringFromDate);
  switch ([sender selectedSegmentIndex]) {
    case 0:
      // do something
      self.dateCounter++;
      [self.components setHour:-24];
      [self.components setMinute:0];
      [self.components setSecond:0];
      self.myDate = [self.cal dateByAddingComponents:self.components toDate: self.myDate options:0];
      
      stringFromDate = [formatter stringFromDate:self.myDate];
      [sender setTitle:stringFromDate forSegmentAtIndex:1];
      break;
    case 1:
      stringFromDate = [formatter stringFromDate:self.myDate];
            NSLog(@"[DEBUG]: today is %@",stringFromDate);
      [self showCalendar:sender];
      stringFromDate = [formatter stringFromDate:self.myDate];
      NSLog(@"[DEBUG]: today BECOME %@",stringFromDate);

      break;
    case 2:
      [self.components setHour:+24];
      
      [self.components setMinute:0];
      [self.components setSecond:0];
      self.myDate = [self.cal dateByAddingComponents:self.components toDate: self.myDate options:0];
      stringFromDate = [formatter stringFromDate:self.myDate];
      [sender setTitle:stringFromDate forSegmentAtIndex:1];

      break;
    case UISegmentedControlNoSegment:
      // do something
      break;
    default:
      NSLog(@"No option for: %d", [sender selectedSegmentIndex]);
  }
}

-(void) createLeftBarButtons
{
  UIButton *sync = [[UIButton alloc] initWithFrame:CGRectMake(0,0,30,22)];
  [sync setBackgroundImage:[UIImage imageNamed:@"sync_icon"] forState:UIControlStateNormal];
  [sync addTarget:self action:@selector(syncPressed:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:sync];
  [self.navigationItem setLeftBarButtonItem:leftBarButton];
}

-(void) createRightBarButtons
{
  UIButton *setting = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 23)];
  [setting setBackgroundImage:[UIImage imageNamed:@"setting_icon"] forState:UIControlStateNormal];
  [setting addTarget:self action:@selector(settingPressed:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:setting];
  [self.navigationItem setRightBarButtonItem:rightBarButton];
}
-(void)syncPressed:(id)sender
{
  NSLog(@"sync Clicked %ld", (long)self.sync_button_value);
  UIButton *sync_button = (UIButton *) sender;
  if(self.sync_button_value == 1){
    [self animateSynchronization:sync_button];
    [self.navigationController showSGProgressWithDuration:3]; //uses the navbar tint color
    [ARCommon createSummaryClass];
//    [ARCommon createDataPoint:100];
    int64_t delayInSeconds = 3; // Your Game Interval as mentioned above by you
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      
      // Update your label here.
      [sync_button.layer removeAllAnimations];
      self.sync_button_value = self.sync_button_value*-1;
      
    });
  } else {
    [sync_button.layer removeAllAnimations];
  }
  
//  self.sync_button_value = self.sync_button_value*-1;
}

-(void)settingPressed:(id)sender
{
  NSLog(@"setting Clicked");
  [self.navigationController pushViewController:[[ARSettingViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
}

#pragma button animation
/**********************************************
 ******button animation************************
 **********************************************/
-(void)animateSynchronization: (UIButton *)sync_button
{
  [UIView animateWithDuration:1 delay:0.0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat |UIViewAnimationOptionAllowUserInteraction
   animations:^{
    sync_button.transform = CGAffineTransformRotate(sync_button.transform, M_PI);
  } completion:nil];
}


#pragma calender pop up view
/**********************************************
 ******PMCalender API function*****************
 **********************************************/
- (void)showCalendar: (id) sender
{
  if ([self.pmCC isCalendarVisible])
  {
    NSLog(@"calendar is visable");
    [self.pmCC dismissCalendarAnimated:NO];
  }
  
  BOOL isPopover = YES;
  self.pmCC = [[PMCalendarController alloc] initWithThemeName:@"default"];
  [self.pmCC
   presentCalendarFromView:sender
   permittedArrowDirections:PMCalendarArrowDirectionAny
   isPopover:isPopover
   animated:YES];
//  [self.pmCC presentCalendarFromRect:CGRectMake(160,25,0,0)
//                              inView:self.tableView
//            permittedArrowDirections:PMCalendarArrowDirectionUp
//                           isPopover:YES
//                            animated:YES];
  
  self.pmCC.delegate = self;
  //end
  
  self.pmCC.period = [PMPeriod oneDayPeriodWithDate:[NSDate date]];
  [self calendarController:self.pmCC didChangePeriod:self.pmCC.period ];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark PMCalendarControllerDelegate methods

- (void)calendarController:(PMCalendarController *)calendarController didChangePeriod:(PMPeriod *)newPeriod
{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"MM dd yyyy"];
  NSString *stringFromDate = [formatter stringFromDate:newPeriod.startDate];
  
  [self.segment setTitle:stringFromDate forSegmentAtIndex:1];
  self.myDate = newPeriod.startDate;
  NSLog(@"[DEBUG] you choose this date ");
  [self querySummaryData];

}


@end


