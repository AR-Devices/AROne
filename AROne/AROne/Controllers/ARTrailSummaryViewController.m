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
#import "ARTrailSummaryMapViewController.h"


#import <QuartzCore/QuartzCore.h>
//tableviewcell
#import "ARSummaryCell.h"
#import "ARTopBarView.h"
#import "ARTrailSummaryTableCell.h"



@interface ARTrailSummaryViewController ()<UIScrollViewDelegate, UIPageViewControllerDelegate, trailPathSource, PMCalendarControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UIImageView *imageView;
@property (nonatomic, strong) NSCalendar * cal;
@property (nonatomic, strong) NSDateComponents *components;
@property (nonatomic, strong) NSDate *myDate;
@property (nonatomic) NSInteger dateCounter;
@property (atomic, strong) UISegmentedControl *segment;
@property(nonatomic, strong) NSDate *currentDate;

//Implement Multipule Snow in One Day feature
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIPageControl *pageControl;

//Create below tableview
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSInteger pageNum;
//frame locations and size
@property (nonatomic) NSInteger map_y_high;
@property (nonatomic) NSInteger map_height;
@property (nonatomic) NSInteger map_y_low;
@property (nonatomic) NSInteger pageControl_height;
@property (nonatomic) UIImage* trail_image;


@end

@implementation ARTrailSummaryViewController
@synthesize pmCC;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.title = @"Trail Summary";
      self.view.backgroundColor = [UIColor whiteColor];
      // Custom initialization
      [self createToolBar];
    }
    return self;
}

- (void)viewDidLoad
{
  self.pageControl_height = 20;
  self.map_height = 200;

  [super viewDidLoad];
  [self drawResorts];
  self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.map_y_low+self.pageControl_height, self.view.bounds.size.width, 160) style:UITableViewStylePlain];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.view addSubview:self.tableView]; //jerry

}

- (void) drawResorts
{
  self.pageNum = 2;
  // CCZ: set scroll screen area for scrollView
  CGFloat width = CGRectGetWidth(self.view.bounds);
  CGFloat height = CGRectGetHeight(self.view.bounds);
  
  //ccz: using full view here, so that even if the button does not cover it's full view, it will still looks good
  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  // CCZ: set content screen area
  [self.scrollView setContentSize:CGSizeMake(width * self.pageNum, height)];
  // CCZ: enable page system
  [self.scrollView setPagingEnabled:YES];
  // CCZ: hide scroll indicator
  [self.scrollView setShowsHorizontalScrollIndicator: NO];
  [self.scrollView setShowsVerticalScrollIndicator: NO];
  [self.scrollView setDelegate: self];
  
  for (int i = 0; i < self.pageNum; i ++) {
    //FIXME add different resort here...
    UIView *resortView= [[UIView alloc] initWithFrame:CGRectMake(i * width , 0 , width, height )];
    NSString* trail_name = @"Kickwood Trail Map\nlocation: 1501 Kirkwood Meadows Dr,\nKirkwood, CA 95646";//FIXME this will be grab from server or database
    self.trail_image =[UIImage imageNamed:@"Kirkwood-Trail-Map-Lake-Tahoe.jpg"];//FIXME this will be grab from server or database
    if(i == 1){
      trail_name = @"Northstar Trail Map\nlocation: 5001 Northstar Dr, \nTruckee, CA 96161";//FIXME this will be grab from server or database
      self.trail_image =[UIImage imageNamed:@"northstar-trail-map.jpg"];//FIXME this will be grab from server or database
    }
    [self drawResortOn:resortView trailName:trail_name trailMap:self.trail_image];
    [_scrollView addSubview:resortView];
  }
  
  [self.view addSubview:self.scrollView];
  
  //CCZ: implement dot control
  self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.map_y_low, self.view.frame.size.width, self.pageControl_height)];
  [self.pageControl setNumberOfPages:self.pageNum];
  [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
  self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
  self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];

  [self.view addSubview:self.pageControl];
}

- (void) drawResortOn: (UIView *)view trailName:(NSString*) trail_name trailMap:(UIImage*)trail_image
{
  UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, self.view.frame.size.width, 45)];
  address.numberOfLines = 3;
  address.adjustsFontSizeToFitWidth = YES;
  address.text = trail_name;
  address.textColor = [UIColor grayColor];
  [view addSubview:address];
  self.map_y_high =address.bounds.size.height/2+address.center.y;
  self.map_y_low = self.map_y_high+self.map_height;
  UIButton *landscapeButton = [[UIButton alloc] initWithFrame:CGRectMake(0,self.map_y_high,self.view.bounds.size.width,self.map_height)];
  UIImageView *map = [[UIImageView alloc] initWithImage:trail_image];
  map.frame = CGRectMake(0, 0, self.view.bounds.size.width, landscapeButton.bounds.size.height);
  trailPathView *pathView = [[trailPathView alloc] initWithFrame:map.frame];
  pathView.dataSource = self;
  [map addSubview:pathView];
  [view addSubview:landscapeButton];
  
  //zoom button
  UIImage *landscape = [UIImage imageNamed:@"landscape"];
  UIImageView *landscapeView = [[UIImageView alloc] initWithImage:landscape];
  UIView *landscapeFrame = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 25 ,5,landscapeView.bounds.size.width+5,landscapeView.bounds.size.height+5)];
  landscapeFrame.backgroundColor = [UIColor whiteColor];
  landscapeFrame.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0].CGColor;
  landscapeFrame.layer.borderWidth = 0.5f;
  [landscapeView setCenter:CGPointMake(landscapeFrame.bounds.size.width/2, landscapeFrame.bounds.size.height/2)];

//  landscapeView.center = landscapeFrame.center;
  [landscapeFrame addSubview:landscapeView];

  [map addSubview:landscapeFrame];
  [landscapeButton addSubview:map];
  [landscapeButton addTarget:self action:@selector(landscapeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
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

-(void)landscapeButtonPressed:(id)sender
{
  ARTrailSummaryMapViewController *landscape = [[ARTrailSummaryMapViewController alloc] initWithMap:self.trail_image];

  [self presentViewController:landscape animated:YES completion:^{
    //nothing
  }];
//  [self.navigationController pushViewController:landscape animated:YES];
  [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
  [UIView commitAnimations];
}

-(NSArray *)trailPathViewData:(trailPathView *)graphView
{
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
  [pointsArray addObject:lowerMainStreet];
  [pointsArray addObject:theGulch];
  
  return pointsArray;
}

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
  [formatter setDateFormat:@"EEE, MMM dd"];
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
  [formatter setDateFormat:@"EEE, MMM dd"];
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
  //FIXME? what heppen here? why settingPressed is gone?
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
  self.currentDate = self.myDate;
  self.pmCC.period = [PMPeriod oneDayPeriodWithDate:self.myDate];
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
  [formatter setDateFormat:@"EEE, MMM dd"];
  NSString *stringFromDate = [formatter stringFromDate:newPeriod.startDate];
  NSString *stringFromCurrent = [formatter stringFromDate:self.currentDate];

  [self.segment setTitle:stringFromDate forSegmentAtIndex:1];
  self.myDate = newPeriod.startDate;
  NSLog(@"[DEBUG] you choose this date ");
  NSLog(@"%@........%@", stringFromDate, stringFromCurrent);

  if([stringFromDate isEqualToString:stringFromCurrent]){
  }else{
    [self.pmCC dismissCalendarAnimated:YES];
    
  }
  
}

- (void)changePage:(id)sender
{
}

//手指离开屏幕后ScrollView还会继续滚动一段时间只到停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  //  NSLog(@"scrolling started");
}

-(void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
  //  NSLog(@"scrolling ended");
}

-(void)scrollViewDidScroll:(UIScrollView*)scrollView
{
  NSLog(@"scrollView is %@", scrollView);
  if ([scrollView isEqual: self.scrollView]) {
    [self.pageControl setCurrentPage:fabs(scrollView.contentOffset.x/self.view.frame.size.width)];
    [self.tableView reloadData];
    if ([self.pageControl currentPage]) {
        self.trail_image =[UIImage imageNamed:@"northstar-trail-map.jpg"];//FIXME this will be grab from server or database
    } else {
      self.trail_image =[UIImage imageNamed:@"Kirkwood-Trail-Map-Lake-Tahoe.jpg"];//FIXME this will be grab from server or database
    }
  }
  
}

-(void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
  //  NSLog(@"滚动视图开始滚动，它只调用一次");
}

-(void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
  //  NSLog(@"滚动视图结束滚动，它只调用一次");
  
}

- (NSUInteger)supportedInterfaceOrientations
{
  NSLog(@"%s", __PRETTY_FUNCTION__);
  return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (BOOL)shouldAutorotate
{
  NSLog(@"%s", __PRETTY_FUNCTION__);
  return true;
}














//***********************************************tableview Delegates*************************************************************
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  if([self.pageControl currentPage] == 1){
  return 5;
  }else{
    return 3;
  }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 90;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.section];
  UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  
  //  a18ac1 purple
  //  2fb3b6 Cyan
  //  ee962f orange
  //  ffffff white
  if([self.pageControl currentPage] == 1){
    if (indexPath.section == 0) {
      cell = [ARTrailSummaryTableCell cellWithStyle:ARTralSummaryCellStyle_green andTrail:@"THE GULCH" andValue:@"25" andValue2:@"1233" andValue3:@"3" rect:self.view.bounds];
    } else if (indexPath.section == 1) {
      cell = [ARTrailSummaryTableCell cellWithStyle:ARTralSummaryCellStyle_blue andTrail:@"POWDER BOWL" andValue:@"36" andValue2:@"3233" andValue3:@"1" rect:self.view.bounds ];
    }else if (indexPath.section == 2) {
      cell = [ARTrailSummaryTableCell cellWithStyle:ARTralSummaryCellStyle_black  andTrail:@"BOCA" andValue:@"37" andValue2:@"4344" andValue3:@"5" rect:self.view.bounds ];
    }else if (indexPath.section == 3) {
      cell = [ARTrailSummaryTableCell cellWithStyle:ARTralSummaryCellStyle_blue  andTrail:@"DROP OFF" andValue:@"27" andValue2:@"2144" andValue3:@"7" rect:self.view.bounds ];
    }else if (indexPath.section == 4) {
      cell = [ARTrailSummaryTableCell cellWithStyle:ARTralSummaryCellStyle_black  andTrail:@"SUGAR PINE GLADE" andValue:@"47" andValue2:@"5344" andValue3:@"1" rect:self.view.bounds ];
    }  //number cgrect 394 136
  }else{
    if (indexPath.section == 0) {
      cell = [ARTrailSummaryTableCell cellWithStyle:ARTralSummaryCellStyle_green andTrail:@"Funny Bunny" andValue:@"15" andValue2:@"3382" andValue3:@"9" rect:self.view.bounds];
    } else if (indexPath.section == 1) {
      cell = [ARTrailSummaryTableCell cellWithStyle:ARTralSummaryCellStyle_blue andTrail:@"Jumper" andValue:@"24" andValue2:@"1258" andValue3:@"1" rect:self.view.bounds ];
    }else if (indexPath.section == 2) {
      cell = [ARTrailSummaryTableCell cellWithStyle:ARTralSummaryCellStyle_black  andTrail:@"The Wall" andValue:@"47" andValue2:@"6009" andValue3:@"5" rect:self.view.bounds ];
    }  //number cgrect 394 136
  }
  cell.selectionStyle = UITableViewCellEditingStyleNone;
  cell.backgroundColor = [UIColor clearColor];
  
  return cell;
}


@end
