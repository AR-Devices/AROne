//
//  ARSummaryBarGraphViewController.m
//  AROne
//
//  Created by Jerry Wu on 6/7/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARSummaryBarGraphViewController.h"

#import "ARDataPoint.h"
#import "PAImageView.h"

// Views
#import "JBBarChartView.h"
#import "JBChartHeaderView.h"
#import "JBBarChartFooterView.h"
#import "JBChartInformationView.h"


// Numerics
CGFloat const kJBBarChartViewControllerChartYLocation = 300.0f;
CGFloat const kJBBarChartViewControllerChartHeight = 150.0f;
CGFloat const kJBBarChartViewControllerChartPadding = 10.0f;
CGFloat const kJBBarChartViewControllerChartPadding_2nd = 180.0f;
CGFloat const kJBBarChartViewControllerChartHeaderHeight = 80.0f;
CGFloat const kJBBarChartViewControllerChartHeaderPadding = 10.0f;
CGFloat const kJBBarChartViewControllerChartFooterHeight = 25.0f;
CGFloat const kJBBarChartViewControllerChartFooterPadding = 5.0f;
CGFloat const kJBBarChartViewControllerBarPadding = 5;
NSInteger const kJBBarChartViewControllerNumBars = 12;
NSInteger const kJBBarChartViewControllerMaxBarHeight = 10;
NSInteger const kJBBarChartViewControllerMinBarHeight = 5;

// Strings
NSString * const kJBBarChartViewControllerNavButtonViewKey = @"view";



@interface ARSummaryBarGraphViewController ()
@property (nonatomic) NSDate *createdAt;
@property (nonatomic) NSMutableArray *dataPoints;
@property (nonatomic) NSMutableArray *timePoints;
@property (nonatomic) float average;
@property (nonatomic) float most_negative_acce;
@property (nonatomic, strong) JBBarChartView *barChartView;
@property (nonatomic, strong) JBChartInformationView *informationView;
@property (nonatomic, strong) JBChartInformationView *informationView_time;
@property (nonatomic, strong) JBChartInformationView *informationView_ave;

@property (nonatomic, strong) NSArray *chartData;
@property (nonatomic, strong) NSArray *daysOfWeek;
// Buttons
- (void)chartToggleButtonPressed:(id)sender;

// Helpers
- (void)initFakeData;
- (NSArray *)largestLineData; // largest collection of fake line data
// content switching variables
@property(nonatomic, strong) UIColor *mybackgroundcolor;
@property(nonatomic, strong) NSString * mygraphtitle;
@property(nonatomic, strong) NSString * myunits;

@property(nonatomic, strong) UIColor *mylinecolor;

@end

@interface ARSummaryBarGraphViewController (){
  int previousStepperValue;
  int totalNumber;
}
@end

@implementation ARSummaryBarGraphViewController

@synthesize graphStyle = _graphStyle;
@synthesize selectedDate = _selectedDate;
#pragma mark - Alloc/Init

- (id)init
{
  self = [super init];
  if (self)
  {
    self.dataPoints = [NSMutableArray new];
    self.timePoints = [NSMutableArray new];
    [self queryDataPoints];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self)
  {

  }
  return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self)
  {

  }
  return self;
}

#pragma mark - Data

- (void)importData
{
  NSMutableArray *mutableChartData = [NSMutableArray array];
  NSLog(@" dataPoint count is %lu", (unsigned long)[self.dataPoints count]);
  NSLog(@" timePoint count is %lu", (unsigned long)[self.timePoints count]);

  for (int i=0; i<[self.dataPoints count]; i++)
  {
    [mutableChartData addObject:[self.dataPoints objectAtIndex:i]];
  }
  _chartData = [NSArray arrayWithArray:mutableChartData];
  _daysOfWeek = self.timePoints;
}



#pragma mark - View Lifecycle

- (void)loadView
{
  [super loadView];
  
  //content switching
  if (_graphStyle == ARSummaryGraphCellStyleMaxSpeed) {
    self.mybackgroundcolor = mypurpleColor;
    self.mygraphtitle = @"Max Speed";
    self.myunits = @"mph";
  } else if (_graphStyle == ARSummaryGraphCellStyleAcceleration) {
    self.mybackgroundcolor = myorangeColor;
    self.mygraphtitle = @"Max Acceleration";
    self.myunits = @"m/s2";
  } else if (_graphStyle == ARSummaryGraphCellStyleVerticalDrop) {
    self.mybackgroundcolor = myneonblueColor;
    self.mygraphtitle = @"Max Vertical Drop";
    self.myunits = @"feet";
  }
  
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.navigationItem.rightBarButtonItem = [self chartToggleButtonWithTarget:self action:@selector(chartToggleButtonPressed:)];
  
  self.barChartView = [[JBBarChartView alloc] init];
  self.barChartView.frame = CGRectMake(kJBBarChartViewControllerChartPadding, kJBBarChartViewControllerChartYLocation, self.view.bounds.size.width - (kJBBarChartViewControllerChartPadding * 2), kJBBarChartViewControllerChartHeight);
  self.barChartView.delegate = self;
  self.barChartView.dataSource = self;
  self.barChartView.headerPadding = kJBBarChartViewControllerChartHeaderPadding;
  self.barChartView.backgroundColor = [UIColor colorWithRed:212.0/255.0 green:222.0/255.0 blue:230.0/255.0 alpha:1.0];
  
//  JBChartHeaderView *headerView = [[JBChartHeaderView alloc] initWithFrame:CGRectMake(kJBBarChartViewControllerChartPadding, ceil(self.view.bounds.size.height * 0.5) - ceil(kJBBarChartViewControllerChartHeaderHeight * 0.5), self.view.bounds.size.width - (kJBBarChartViewControllerChartPadding * 2), kJBBarChartViewControllerChartHeaderHeight)];
//  headerView.titleLabel.text = self.mygraphtitle;
//  headerView.subtitleLabel.text = kJBStringLabel2012;
//  headerView.separatorColor = kJBColorBarChartHeaderSeparatorColor;
//  self.barChartView.headerView = headerView;
  
  JBBarChartFooterView *footerView = [[JBBarChartFooterView alloc] initWithFrame:CGRectMake(kJBBarChartViewControllerChartPadding, ceil(self.view.bounds.size.height * 0.5) - ceil(kJBBarChartViewControllerChartFooterHeight * 0.5), self.view.bounds.size.width - (kJBBarChartViewControllerChartPadding * 2), kJBBarChartViewControllerChartFooterHeight)];
  footerView.backgroundColor = [UIColor clearColor];
  footerView.padding = kJBBarChartViewControllerChartFooterPadding;
  footerView.leftLabel.text = (NSString*)[self.daysOfWeek firstObject] ;
  footerView.leftLabel.textColor = [UIColor whiteColor];
  footerView.rightLabel.text = (NSString*)[self.daysOfWeek lastObject];
  footerView.rightLabel.textColor = [UIColor whiteColor];
  self.barChartView.footerView = footerView;
  
  self.informationView = [[JBChartInformationView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, kJBBarChartViewControllerChartPadding, self.view.bounds.size.width, self.view.bounds.size.height -  kJBBarChartViewControllerChartYLocation-100)];
  self.informationView_time = [[JBChartInformationView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, kJBBarChartViewControllerChartPadding_2nd, self.view.bounds.size.width /2, self.view.bounds.size.height -  kJBBarChartViewControllerChartYLocation-180)];
  self.informationView_ave = [[JBChartInformationView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x+self.view.bounds.size.width /2, kJBBarChartViewControllerChartPadding_2nd, self.view.bounds.size.width /2, self.view.bounds.size.height -  kJBBarChartViewControllerChartYLocation-180)];
//  self.informationView.backgroundColor = [UIColor orangeColor];
//  self.informationView_time.backgroundColor = [UIColor redColor];
//  self.informationView_ave.backgroundColor = [UIColor grayColor];

  [self.view addSubview:self.informationView];
  [self.view addSubview:self.informationView_time];
  [self.view addSubview:self.informationView_ave];

  [self.view addSubview:self.barChartView];
  [self.barChartView reloadData];

  
  }
- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self.barChartView setState:JBChartViewStateExpanded];
}

#pragma mark - JBBarChartViewDelegate

- (CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtAtIndex:(NSUInteger)index
{
  return [[self.chartData objectAtIndex:index] floatValue];
}

#pragma mark - JBBarChartViewDataSource

- (NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView
{
  return [self.dataPoints count];
}

- (NSUInteger)barPaddingForBarChartView:(JBBarChartView *)barChartView
{
  return kJBBarChartViewControllerBarPadding; //FIXME should use view.width / count
}

- (UIView *)barChartView:(JBBarChartView *)barChartView barViewAtIndex:(NSUInteger)index
{
  UIView *barView = [[UIView alloc] init];
  barView.backgroundColor = (index % 2 == 0) ? kJBColorBarChartBarBlue : kJBColorBarChartBarGreen;
  return barView;
}

- (UIColor *)barSelectionColorForBarChartView:(JBBarChartView *)barChartView
{
  return [UIColor whiteColor];
}

- (void)barChartView:(JBBarChartView *)barChartView didSelectBarAtIndex:(NSUInteger)index touchPoint:(CGPoint)touchPoint
{
  NSNumber *valueNumber = [self.chartData objectAtIndex:index];
  [self.informationView setValueText:[NSString stringWithFormat:@"%d", [valueNumber intValue]] unitText:self.myunits];
  [self.informationView setTitleText:self.mygraphtitle];
  [self.informationView setTitleTextColor:[UIColor grayColor]];
  [self.informationView setValueAndUnitTextColor:self.mybackgroundcolor];
  [self.informationView setHidden:NO animated:YES];
  [self.informationView setTextShadowColor:[UIColor clearColor]];
  
  NSString *valueTime = [self.daysOfWeek objectAtIndex:index];
  [self.informationView_time setValueText:[NSString stringWithFormat:@"%@", valueTime] unitText:@""];
  [self.informationView_time setTitleText:@"Time"];
  [self.informationView_time setTitleTextColor:[UIColor grayColor]];
  [self.informationView_time setValueAndUnitTextColor:[UIColor blackColor]];
  [self.informationView_time setHidden:NO animated:YES];
  [self.informationView_time setTextShadowColor:[UIColor clearColor]];
  [self.informationView_time setTitleFont:kJBFontInformationTitle_time];
  [self.informationView_time setValueFont:kJBFontInformationValue_time];
  [self.informationView_time setSeparatorColor:[UIColor clearColor]];

  [self.informationView_ave setValueText:[NSString stringWithFormat:@"%0.3f", self.average] unitText:@""];
  [self.informationView_ave setTitleText:@"Avg. Speed"];
  [self.informationView_ave setTitleTextColor:[UIColor grayColor]];
  [self.informationView_ave setValueAndUnitTextColor:[UIColor blackColor]];
  [self.informationView_ave setHidden:NO animated:YES];
  [self.informationView_ave setTextShadowColor:[UIColor clearColor]];
  [self.informationView_ave setTitleFont:kJBFontInformationTitle_time];
  [self.informationView_ave setValueFont:kJBFontInformationValue_time];
  [self.informationView_ave setSeparatorColor:[UIColor clearColor]];
//  [self setTooltipVisible:YES animated:YES atTouchPoint:touchPoint];
//  [self.tooltipView setText:[[self.daysOfWeek objectAtIndex:index] uppercaseString]];
}

- (void)didUnselectBarChartView:(JBBarChartView *)barChartView
{
//  [self.informationView setHidden:YES animated:YES];
  [self setTooltipVisible:NO animated:YES];
}

#pragma mark - Buttons

- (void)chartToggleButtonPressed:(id)sender
{
  UIView *buttonImageView = [self.navigationItem.rightBarButtonItem valueForKey:kJBBarChartViewControllerNavButtonViewKey];
  buttonImageView.userInteractionEnabled = NO;
  
  CGAffineTransform transform = self.barChartView.state == JBChartViewStateExpanded ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformMakeRotation(0);
  buttonImageView.transform = transform;
  
  [self.barChartView setState:self.barChartView.state == JBChartViewStateExpanded ? JBChartViewStateCollapsed : JBChartViewStateExpanded animated:YES callback:^{
    buttonImageView.userInteractionEnabled = YES;
  }];
}

#pragma mark - Overrides

- (JBChartView *)chartView
{
  return self.barChartView;
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
  [query setLimit:20];
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
      float sum = 0.0;
      NSInteger valid_count = 0;
      self.most_negative_acce = 0.0;
      
      for (int i = 0; i < [array count]; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        [self.dataPoints addObject:[dict objectForKey:data]];
        [self.timePoints addObject:[[dict objectForKey:@"timeRecord"]substringToIndex:5]];
        if([(NSNumber *)[dict objectForKey:data] floatValue] != 0.0){
          sum = sum +  [(NSNumber *)[dict objectForKey:data] floatValue];
//          NSLog(@" value is %f", [(NSNumber *)[dict objectForKey:data] floatValue]);
//          NSLog(@" and sum is %f",   sum);
          valid_count++;
        }
        if ([(NSNumber *)[dict objectForKey:data] floatValue] < self.most_negative_acce){
          self.most_negative_acce = [(NSNumber *)[dict objectForKey:data] floatValue];
        }
      }
      self.average = sum / valid_count;
      //      NSLog(@"dataPoints %@",self.dataPoints);
      //      NSLog(@"timePoints %@", self.timePoints);
      
      
      [self importData];
      PFObject *object = [array lastObject];
      if ([[object createdAt] isEqual:self.createdAt])
        return;
      else
        self.createdAt = [object createdAt];
    }
      [self.barChartView reloadData];
    
    NSLog(@"data count is %lu", (unsigned long)self.dataPoints.count);
  }];
}
@end
