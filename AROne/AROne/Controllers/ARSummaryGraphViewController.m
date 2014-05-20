//
//  ARSummaryFunctionGraphViewController.m
//  AROne
//
//  Created by Jerry Wu on 9/10/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "ARSummaryGraphViewController.h"
#import "ARSummaryGraphDetailViewController.h"

#import "ARDataPoint.h"
#import "PAImageView.h"

// Views
#import "JBLineChartView.h"
#import "JBChartHeaderView.h"
#import "JBLineChartFooterView.h"
#import "JBChartInformationView.h"

#define ARC4RANDOM_MAX 0x100000000

typedef NS_ENUM(NSInteger, JBLineChartLine){
	JBLineChartLineSolid,
  JBLineChartLineDashed,
  JBLineChartLineCount
};

// Numerics
CGFloat const kJBLineChartViewControllerChartHeight = 250.0f;
CGFloat const kJBLineChartViewControllerChartPadding = 10.0f;
CGFloat const kJBLineChartViewControllerChartHeaderHeight = 75.0f;
CGFloat const kJBLineChartViewControllerChartHeaderPadding = 20.0f;
CGFloat const kJBLineChartViewControllerChartFooterHeight = 20.0f;
CGFloat const kJBLineChartViewControllerChartSolidLineWidth = 6.0f;
CGFloat const kJBLineChartViewControllerChartDashedLineWidth = 2.0f;
NSInteger const kJBLineChartViewControllerMaxNumChartPoints = 7;

// Strings
NSString * const kJBLineChartViewControllerNavButtonViewKey = @"view";



@interface ARSummaryGraphViewController ()
@property (nonatomic) NSDate *createdAt;

@property (nonatomic, strong) JBLineChartView *lineChartView;
@property (nonatomic, strong) JBChartInformationView *informationView;
@property (nonatomic, strong) NSArray *chartData;
@property (nonatomic, strong) NSArray *daysOfWeek;
// Buttons
- (void)chartToggleButtonPressed:(id)sender;

// Helpers
- (void)initFakeData;
- (NSArray *)largestLineData; // largest collection of fake line data


@end

@interface ARSummaryGraphViewController (){
  int previousStepperValue;
  int totalNumber;
}
@end

@implementation ARSummaryGraphViewController

@synthesize graphStyle = _graphStyle;
@synthesize selectedDate = _selectedDate;
#pragma mark - Alloc/Init

- (id)init
{
  self = [super init];
  if (self)
  {
    [self initFakeData];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self)
  {
    [self initFakeData];
  }
  return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self)
  {
    [self initFakeData];
  }
  return self;
}

#pragma mark - Data

- (void)initFakeData
{
  NSMutableArray *mutableLineCharts = [NSMutableArray array];
  for (int lineIndex=0; lineIndex<JBLineChartLineCount; lineIndex++)
  {
    NSMutableArray *mutableChartData = [NSMutableArray array];
    for (int i=0; i<kJBLineChartViewControllerMaxNumChartPoints; i++)
    {
      [mutableChartData addObject:[NSNumber numberWithFloat:((double)arc4random() / ARC4RANDOM_MAX)]]; // random number between 0 and 1
    }
    [mutableLineCharts addObject:mutableChartData];
  }
  _chartData = [NSArray arrayWithArray:mutableLineCharts];
  _daysOfWeek = [[[NSDateFormatter alloc] init] shortWeekdaySymbols];
}

- (NSArray *)largestLineData
{
  NSArray *largestLineData = nil;
  for (NSArray *lineData in self.chartData)
  {
    if ([lineData count] > [largestLineData count])
    {
      largestLineData = lineData;
    }
  }
  return largestLineData;
}

#pragma mark - View Lifecycle

- (void)loadView
{
  [super loadView];
  
  self.view.backgroundColor = kJBColorLineChartControllerBackground;
  self.navigationItem.rightBarButtonItem = [self chartToggleButtonWithTarget:self action:@selector(chartToggleButtonPressed:)];
  
  self.lineChartView = [[JBLineChartView alloc] init];
  self.lineChartView.frame = CGRectMake(kJBLineChartViewControllerChartPadding, kJBLineChartViewControllerChartPadding, self.view.bounds.size.width - (kJBLineChartViewControllerChartPadding * 2), kJBLineChartViewControllerChartHeight);
  self.lineChartView.delegate = self;
  self.lineChartView.dataSource = self;
  self.lineChartView.headerPadding = kJBLineChartViewControllerChartHeaderPadding;
  self.lineChartView.backgroundColor = kJBColorLineChartBackground;
  
  JBChartHeaderView *headerView = [[JBChartHeaderView alloc] initWithFrame:CGRectMake(kJBLineChartViewControllerChartPadding, ceil(self.view.bounds.size.height * 0.5) - ceil(kJBLineChartViewControllerChartHeaderHeight * 0.5), self.view.bounds.size.width - (kJBLineChartViewControllerChartPadding * 2), kJBLineChartViewControllerChartHeaderHeight)];
  headerView.titleLabel.text = [kJBStringLabelAverageDailyRainfall uppercaseString];
  headerView.titleLabel.textColor = kJBColorLineChartHeader;
  headerView.titleLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:0.25];
  headerView.titleLabel.shadowOffset = CGSizeMake(0, 1);
  headerView.subtitleLabel.text = kJBStringLabel2013;
  headerView.subtitleLabel.textColor = kJBColorLineChartHeader;
  headerView.subtitleLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:0.25];
  headerView.subtitleLabel.shadowOffset = CGSizeMake(0, 1);
  headerView.separatorColor = kJBColorLineChartHeaderSeparatorColor;
  self.lineChartView.headerView = headerView;
  
  JBLineChartFooterView *footerView = [[JBLineChartFooterView alloc] initWithFrame:CGRectMake(kJBLineChartViewControllerChartPadding, ceil(self.view.bounds.size.height * 0.5) - ceil(kJBLineChartViewControllerChartFooterHeight * 0.5), self.view.bounds.size.width - (kJBLineChartViewControllerChartPadding * 2), kJBLineChartViewControllerChartFooterHeight)];
  footerView.backgroundColor = [UIColor clearColor];
  footerView.leftLabel.text = [[self.daysOfWeek firstObject] uppercaseString];
  footerView.leftLabel.textColor = [UIColor whiteColor];
  footerView.rightLabel.text = [[self.daysOfWeek lastObject] uppercaseString];;
  footerView.rightLabel.textColor = [UIColor whiteColor];
  footerView.sectionCount = [[self largestLineData] count];
  self.lineChartView.footerView = footerView;
  
  [self.view addSubview:self.lineChartView];
  
  self.informationView = [[JBChartInformationView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, CGRectGetMaxY(self.lineChartView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.lineChartView.frame) - CGRectGetMaxY(self.navigationController.navigationBar.frame))];
  [self.informationView setValueAndUnitTextColor:[UIColor colorWithWhite:1.0 alpha:0.75]];
  [self.informationView setTitleTextColor:kJBColorLineChartHeader];
  [self.informationView setTextShadowColor:nil];
  [self.informationView setSeparatorColor:kJBColorLineChartHeaderSeparatorColor];
  [self.view addSubview:self.informationView];
  
  [self.lineChartView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self.lineChartView setState:JBChartViewStateExpanded];
}

#pragma mark - JBLineChartViewDelegate

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
  return [[[self.chartData objectAtIndex:lineIndex] objectAtIndex:horizontalIndex] floatValue];
}

- (void)lineChartView:(JBLineChartView *)lineChartView didSelectLineAtIndex:(NSUInteger)lineIndex horizontalIndex:(NSUInteger)horizontalIndex touchPoint:(CGPoint)touchPoint
{
  NSNumber *valueNumber = [[self.chartData objectAtIndex:lineIndex] objectAtIndex:horizontalIndex];
  [self.informationView setValueText:[NSString stringWithFormat:@"%.2f", [valueNumber floatValue]] unitText:kJBStringLabelMm];
  [self.informationView setTitleText:lineIndex == JBLineChartLineSolid ? kJBStringLabelMetropolitanAverage : kJBStringLabelNationalAverage];
  [self.informationView setHidden:NO animated:YES];
  [self setTooltipVisible:YES animated:YES atTouchPoint:touchPoint];
  [self.tooltipView setText:[[self.daysOfWeek objectAtIndex:horizontalIndex] uppercaseString]];
}

- (void)didUnselectLineInLineChartView:(JBLineChartView *)lineChartView
{
  [self.informationView setHidden:YES animated:YES];
  [self setTooltipVisible:NO animated:YES];
}

#pragma mark - JBLineChartViewDataSource

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView
{
  return [self.chartData count];
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
  return [[self.chartData objectAtIndex:lineIndex] count];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex
{
  return (lineIndex == JBLineChartLineSolid) ? kJBColorLineChartDefaultSolidLineColor: kJBColorLineChartDefaultDashedLineColor;
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex
{
  return (lineIndex == JBLineChartLineSolid) ? kJBLineChartViewControllerChartSolidLineWidth: kJBLineChartViewControllerChartDashedLineWidth;
}

- (UIColor *)verticalSelectionColorForLineChartView:(JBLineChartView *)lineChartView
{
  return [UIColor whiteColor];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView selectionColorForLineAtLineIndex:(NSUInteger)lineIndex
{
  return (lineIndex == JBLineChartLineSolid) ? kJBColorLineChartDefaultSolidSelectedLineColor: kJBColorLineChartDefaultDashedSelectedLineColor;
}

- (JBLineChartViewLineStyle)lineChartView:(JBLineChartView *)lineChartView lineStyleForLineAtLineIndex:(NSUInteger)lineIndex
{
  return (lineIndex == JBLineChartLineSolid) ? JBLineChartViewLineStyleSolid : JBLineChartViewLineStyleDashed;
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView showsDotsForLineAtLineIndex:(NSUInteger)lineIndex
{
  return lineIndex == JBLineChartViewLineStyleDashed;
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex
{
  return lineIndex == JBLineChartViewLineStyleSolid;
}

#pragma mark - Buttons

- (void)chartToggleButtonPressed:(id)sender
{
	UIView *buttonImageView = [self.navigationItem.rightBarButtonItem valueForKey:kJBLineChartViewControllerNavButtonViewKey];
  buttonImageView.userInteractionEnabled = NO;
  
  CGAffineTransform transform = self.lineChartView.state == JBChartViewStateExpanded ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformMakeRotation(0);
  buttonImageView.transform = transform;
  
  [self.lineChartView setState:self.lineChartView.state == JBChartViewStateExpanded ? JBChartViewStateCollapsed : JBChartViewStateExpanded animated:YES callback:^{
    buttonImageView.userInteractionEnabled = YES;
  }];
}

#pragma mark - Overrides

- (JBChartView *)chartView
{
  return self.lineChartView;
}

/*
- (id)initwithStyle:(ARSummaryGraphCellStyle)style
{
  [self setFunctionStyle:style];
  return self;
}

- (void)viewDidLoad
{
 
  [super viewDidLoad];
  self.title = @"Detail";
  self.view.backgroundColor = [UIColor colorWithRed:212.0/255.0 green:222.0/255.0 blue:230.0/255.0 alpha:1.0];//    d4dee6


  [self queryDataPoints];



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

- (void) setFunctionStyle: (ARSummaryGraphCellStyle) style{
  self.graphStyle = style;
}

- (void) queryDataPoints
{
  PFQuery *query = [ARDataPoint query];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd"];
  NSLog(@"seletedDate is %@", [formatter stringFromDate:self.selectedDate]);
//  [query whereKey:@"dateRecord" equalTo:[formatter stringFromDate:self.selectedDate]];
//  [query whereKey:@"player" equalTo:[PFUser currentUser]];

  
//  NSMutableArray *keys = [[NSMutableArray alloc] init];
//  [keys addObject:@"speed"];
//  [keys addObject:@"acceleration"];
//  [keys addObject:@"verticalDrop"];
//  [query orderByDescending:@"createdAt"];
//  [query orderByAscending:@"createdAt"];
//  [keys addObject:@"createdAt"];
//  [query selectKeys:keys];
  [query setLimit:100];
//  [query setSkip:skip];
//  if (self.createdAt != nil) {
//    NSLog(@"called!");
//    [query whereKey:@"createdAt" lessThanOrEqualTo:self.createdAt];
//  }
  [query findObjectsInBackgroundWithBlock:^(id objects, NSError *error) {
    if (!error && ([objects count] != 0)) {
      NSArray *array = objects;
      NSString *data;
      if (_graphStyle == ARSummaryGraphCellStyleMaxSpeed) {
        data = @"speed";
      } else if (_graphStyle == ARSummaryGraphCellStyleAcceleration) {
        data = @"acceleration";
      } else if (_graphStyle == ARSummaryGraphCellStyleVerticalDrop) {
        data = @"verticalDrop";
      }
      for (int i = 0; i < [array count]; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        [self.dataPoints addObject:[dict objectForKey:data]];
        [self.timePoints addObject:[[dict objectForKey:@"timeRecord"]substringToIndex:5]];


      }
      NSLog(@"dataPoints %@",self.dataPoints);
      NSLog(@"timePoints %@", self.timePoints);
      //reloadGraph[self.myGraph reloadGraph];
      PFObject *object = [array lastObject];
      if ([[object createdAt] isEqual:self.createdAt])
        return;
      else
        self.createdAt = [object createdAt];
    }
   // redraw

    NSLog(@"data count is %lu", (unsigned long)self.dataPoints.count);
//    [self.view setNeedsDisplay];
//    NSLog(@"createAt %@", self.createdAt);
//    if (self.dataPoints.count < 500) {
//      [self queryDataPoints];
//    }
  }];
}
*/

 /*
  //units:
  UIColor *unit_color = [UIColor colorWithRed:90/255.0f green:90/255.0f blue:90/255.0f alpha:1];

  UILabel * speed_unit = [[UILabel alloc] initWithFrame:CGRectMake(240, 355, 100, 40)];
  speed_unit.font = [UIFont fontWithName:@"Avenir-Medium" size:10];
  speed_unit.numberOfLines = 2;
  speed_unit.text = @"mph\nMax speed";
  speed_unit.textColor = unit_color;
  UILabel * vdrop_unit = [[UILabel alloc] initWithFrame:CGRectMake(240, 355, 100, 40)];
  vdrop_unit.font = [UIFont fontWithName:@"Avenir-Medium" size:10];
  vdrop_unit.numberOfLines = 2;
  vdrop_unit.text = @"feet\nMax vdrop";
  vdrop_unit.textColor = unit_color;
  UILabel * acce_unit = [[UILabel alloc] initWithFrame:CGRectMake(240, 355, 100, 40)];
  acce_unit.font = [UIFont fontWithName:@"Avenir-Medium" size:10];
  acce_unit.numberOfLines = 2;
  acce_unit.text = @"ft/s2\nMax accel";
  acce_unit.textColor = unit_color;
 
  UILabel * trip_number = [[UILabel alloc] initWithFrame:CGRectMake(140, 390 ,90, 51)];
  trip_number.font = [UIFont fontWithName:@"Helvetica Neue" size:20.0];
  trip_number.textAlignment = UITextAlignmentRight;
  trip_number.text = @"3";
  UILabel * trip_number_unit = [[UILabel alloc] initWithFrame:CGRectMake(240, 395, 100, 40)];
  trip_number_unit.font = [UIFont fontWithName:@"Avenir-Medium" size:10];
  trip_number_unit.numberOfLines = 2;
  trip_number_unit.text = @"Times";
  trip_number_unit.textColor = unit_color;

  
  
  UIImage *maxpeed_frame =[UIImage imageNamed:@"MasSpeedCard_bg"];
  UIImage *vdp_frame = [UIImage imageNamed:@"VDCard_bg"];
  UIImage *acce_frame = [UIImage imageNamed:@"Acce_card"];
  UIImageView* labelValueFrame;
  if(self.graphStyle == ARSummaryGraphCellStyleMaxSpeed){
    labelValueFrame = [[UIImageView alloc] initWithImage: maxpeed_frame];
    [self.view addSubview:speed_unit];
    self.labelMax.text = @"22.54";
  }else if(self.graphStyle == ARSummaryGraphCellStyleVerticalDrop){
    labelValueFrame = [[UIImageView alloc] initWithImage: vdp_frame];
    [self.view addSubview:vdrop_unit];
    self.labelMax.text = @"347.49";
  }else if(self.graphStyle == ARSummaryGraphCellStyleAcceleration){
    labelValueFrame = [[UIImageView alloc] initWithImage: acce_frame];
    [self.view addSubview:acce_unit];
    self.labelMax.text = @"5.016";
  }
  labelValueFrame.frame = CGRectMake(30, 345, maxpeed_frame.size.width, maxpeed_frame.size.height);
  [labelValueFrame addSubview:self.labelValues];
  [labelValueFrame addSubview:self.labelTime];
  


  //--------------------color options start---------------------
  UIColor *purpleColor   = [UIColor colorWithRed:161/255.0f green:138/255.0f blue:193/255.0f alpha:1];
  UIColor *neonblueColor = [UIColor colorWithRed:47/255.0f green:179/255.0f blue:182/255.0f alpha:1];
  UIColor *orangeColor   = [UIColor colorWithRed:238/255.0f green:150/255.0f blue:47/255.0f alpha:1];
  UIColor *color = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
  if(self.graphStyle == ARSummaryGraphCellStyleMaxSpeed){
    color = purpleColor;
    self.myGraph.enableBezierCurve = YES;
  }else if(self.graphStyle == ARSummaryGraphCellStyleVerticalDrop){
    color = neonblueColor;
    self.myGraph.enableBezierCurve = NO;
  }else if(self.graphStyle == ARSummaryGraphCellStyleAcceleration){
    color = orangeColor;
    self.myGraph.enableBezierCurve = YES;

  }
  //  color = [UIColor colorWithRed:255.0/255.0 green:187.0/255.0 blue:31.0/255.0 alpha:1.0];
  //  color = [UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0];
//  myGraph.colorTop = color;
  self.myGraph.colorBottom = color;
  self.myGraph.backgroundColor = color;
  //self.view.tintColor = [UIColor blackColor];
  self.labelValues.textColor = color;
  //  self.navigationController.navigationBar.tintColor = color;
  self.myGraph.enableTouchReport = YES;
  self.myGraph.colorLine = [UIColor whiteColor];
  self.myGraph.colorXaxisLabel = [UIColor whiteColor];

  self.myGraph.widthLine = 3.0;

  self.myGraph.animationGraphEntranceSpeed = 100;
  //--------------------color options end ----------------------
  [self.view addSubview:self.myGraph];
  [self.view addSubview:labelValueFrame];
  [self.view addSubview:self.labelMax];
  [self.view addSubview:trip_number];
  [self.view addSubview:trip_number_unit];

}
  */

@end
