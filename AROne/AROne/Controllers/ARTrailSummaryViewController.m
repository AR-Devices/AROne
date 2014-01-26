//
//  ARTrailSummaryViewController.m
//  AROne
//
//  Created by Chenchen Zheng on 9/4/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "ARTrailSummaryViewController.h"
#import "UIViewController+AKTabBarController.h"
#import "AKSegmentedControl.h"
#import "trailPathView.h"


#import <QuartzCore/QuartzCore.h>
//tableviewcell
#import "ARSummaryCell.h"
#import "ARTopBarView.h"
@interface ARTrailSummaryViewController ()<UIScrollViewDelegate, trailPathSource>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIImageView *imageView;
@property(nonatomic, strong) NSCalendar * cal;
@property(nonatomic, strong) NSDateComponents *components;
@property(nonatomic, strong) NSDate *myDate;
@property(nonatomic) NSInteger dateCounter;
@property(atomic, strong) UISegmentedControl *segment;
@end

@implementation ARTrailSummaryViewController
@synthesize pmCC;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.view.backgroundColor = [UIColor whiteColor];
      // Custom initialization
      [self createToolBar];
      
      
      // Do any additional setup after loading the view.
//      trailPathView *trailView = [[trailPathView alloc]initWithFrame:CGRectMake(10, 100, 300, 300)];
//      [self.view addSubview:trailView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  UIImageView *map = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"northstar-trail-map.jpg"]];
  map.frame = CGRectMake(10, 100, 300, 150);
  trailPathView *view = [[trailPathView alloc] initWithFrame:map.frame];
  view.dataSource = self;

  [map addSubview:view];
  [self.view addSubview:map];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AKTabBarController Data Source
- (NSString *)tabImageName
{
	return @"trail_icon";
}

- (NSString *)activeTabImageName
{
	return @"trail_icon_selected";
}

-(NSArray *)trailPathViewData:(trailPathView *)graphView
{
  
  //    NSArray *points = [[NSArray alloc] initWithObjects:
  //                       [NSValue valueWithCGPoint:CGPointMake(571, 405.5)],   //LUMBERJACK
  //                       [NSValue valueWithCGPoint:CGPointMake(564.5, 419)],
  //                       [NSValue valueWithCGPoint:CGPointMake(558.5, 432)],
  //                       [NSValue valueWithCGPoint:CGPointMake(553, 439.5)],    //rows should be 5+3x lanes
  //                       [NSValue valueWithCGPoint:CGPointMake(544, 459.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(536, 488.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(527, 508)],
  //                       [NSValue valueWithCGPoint:CGPointMake(520.5, 525.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(505.5, 533)],
  //                       [NSValue valueWithCGPoint:CGPointMake(488.5, 547.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(474, 564.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(469.5, 575.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(463.5, 589)],
  //                       [NSValue valueWithCGPoint:CGPointMake(457, 612)],
  //                       [NSValue valueWithCGPoint:CGPointMake(444, 636)],
  //                       [NSValue valueWithCGPoint:CGPointMake(444, 636)],
  //                       [NSValue valueWithCGPoint:CGPointMake(444, 636)],
  
  //                       [NSValue valueWithCGPoint:CGPointMake(444, 636)],  //LOWER MAIN STREET
  //                       [NSValue valueWithCGPoint:CGPointMake(436, 646.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(420, 663.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(412.5, 676.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(404, 686.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(394, 700.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(384.5, 710)],
  //                       [NSValue valueWithCGPoint:CGPointMake(368.5, 729.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(358, 743.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(358, 743.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(358, 743.5)],
  
  
  //                       [NSValue valueWithCGPoint:CGPointMake(457, 673)],   //THE GULCH
  //                       [NSValue valueWithCGPoint:CGPointMake(451.5, 685.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(435, 706)],
  //                       [NSValue valueWithCGPoint:CGPointMake(426, 713.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(398.5, 735)],
  //                       [NSValue valueWithCGPoint:CGPointMake(368.5, 765.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(368.5, 765.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(368.5, 765.5)],
  //                       nil];
  NSArray *lumberJack = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(571, 405.5)],   //LUMBERJACK
                         [NSValue valueWithCGPoint:CGPointMake(564.5, 419)],
                         [NSValue valueWithCGPoint:CGPointMake(558.5, 432)],
                         [NSValue valueWithCGPoint:CGPointMake(553, 439.5)],    //rows should be 5+3x lanes
                         [NSValue valueWithCGPoint:CGPointMake(544, 459.5)],
                         [NSValue valueWithCGPoint:CGPointMake(536, 488.5)],
                         [NSValue valueWithCGPoint:CGPointMake(527, 508)],
                         [NSValue valueWithCGPoint:CGPointMake(520.5, 525.5)],
                         [NSValue valueWithCGPoint:CGPointMake(505.5, 533)],
                         [NSValue valueWithCGPoint:CGPointMake(488.5, 547.5)],
                         [NSValue valueWithCGPoint:CGPointMake(474, 564.5)],
                         [NSValue valueWithCGPoint:CGPointMake(469.5, 575.5)],
                         [NSValue valueWithCGPoint:CGPointMake(463.5, 589)],
                         [NSValue valueWithCGPoint:CGPointMake(457, 612)],
                         [NSValue valueWithCGPoint:CGPointMake(444, 636)],
                         [NSValue valueWithCGPoint:CGPointMake(444, 636)],
                         [NSValue valueWithCGPoint:CGPointMake(444, 636)], nil];
  
  
  NSArray *lowerMainStreet = [[NSArray alloc] initWithObjects:
                              [NSValue valueWithCGPoint:CGPointMake(444, 636)],  //LOWER MAIN STREET
                              [NSValue valueWithCGPoint:CGPointMake(436, 646.5)],
                              [NSValue valueWithCGPoint:CGPointMake(420, 663.5)],
                              [NSValue valueWithCGPoint:CGPointMake(412.5, 676.5)],
                              [NSValue valueWithCGPoint:CGPointMake(404, 686.5)],
                              [NSValue valueWithCGPoint:CGPointMake(394, 700.5)],
                              [NSValue valueWithCGPoint:CGPointMake(384.5, 710)],
                              [NSValue valueWithCGPoint:CGPointMake(368.5, 729.5)],
                              [NSValue valueWithCGPoint:CGPointMake(358, 743.5)],
                              [NSValue valueWithCGPoint:CGPointMake(358, 743.5)],
                              [NSValue valueWithCGPoint:CGPointMake(358, 743.5)],nil];
  NSArray *theGulch = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(457, 673)],   //THE GULCH
                       [NSValue valueWithCGPoint:CGPointMake(451.5, 685.5)],
                       [NSValue valueWithCGPoint:CGPointMake(435, 706)],
                       [NSValue valueWithCGPoint:CGPointMake(426, 713.5)],
                       [NSValue valueWithCGPoint:CGPointMake(398.5, 735)],
                       [NSValue valueWithCGPoint:CGPointMake(368.5, 765.5)],
                       [NSValue valueWithCGPoint:CGPointMake(368.5, 765.5)],
                       [NSValue valueWithCGPoint:CGPointMake(368.5, 765.5)],
                       nil];
  NSMutableArray *pointsArray = [NSMutableArray new];
  [pointsArray addObject:lumberJack];
  //  [pointsArray addObject:lowerMainStreet];
  //  [pointsArray addObject:theGulch];
  
  return pointsArray;
}











































//- (NSString *)tabTitle
//{
//	return self.title;
//}
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
  
  [self.view addSubview:topbar];
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
  
  self.pmCC.period = [PMPeriod oneDayPeriodWithDate:[NSDate date	]];
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
  
}
@end
