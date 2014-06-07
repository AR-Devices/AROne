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
CGFloat const kJBBarChartViewControllerChartHeight = 250.0f;
CGFloat const kJBBarChartViewControllerChartPadding = 10.0f;
CGFloat const kJBBarChartViewControllerChartHeaderHeight = 80.0f;
CGFloat const kJBBarChartViewControllerChartHeaderPadding = 10.0f;
CGFloat const kJBBarChartViewControllerChartFooterHeight = 25.0f;
CGFloat const kJBBarChartViewControllerChartFooterPadding = 5.0f;
CGFloat const kJBBarChartViewControllerBarPadding = 1;
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
    self.dataPoints = [NSMutableArray new];
    self.timePoints = [NSMutableArray new];
    [self queryDataPoints];
  }
  return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self)
  {
    self.dataPoints = [NSMutableArray new];
    self.timePoints = [NSMutableArray new];
    [self queryDataPoints];
  }
  return self;
}

#pragma mark - Data

- (void)importData
{
  NSMutableArray *mutableChartData = [NSMutableArray array];
  for (int i=0; i<[self.dataPoints count]; i++)
  {
    [mutableChartData addObject:[self.dataPoints objectAtIndex:i]];
    
  }

  _chartData = [NSArray arrayWithArray:mutableChartData];
  _daysOfWeek = self.timePoints;//[[[NSDateFormatter alloc] init] shortWeekdaySymbols];
}



#pragma mark - View Lifecycle

- (void)loadView
{
  [super loadView];
  
  //content switching
  if (_graphStyle == ARSummaryGraphCellStyleMaxSpeed) {
    self.mybackgroundcolor = mypurpleColor;
    self.mygraphtitle = @"SPEED";
  } else if (_graphStyle == ARSummaryGraphCellStyleAcceleration) {
    self.mybackgroundcolor = myorangeColor;
    self.mygraphtitle = @"ACCELERATION";
  } else if (_graphStyle == ARSummaryGraphCellStyleVerticalDrop) {
    self.mybackgroundcolor = myneonblueColor;
    self.mygraphtitle = @"VERTICAL DROP";
  }
  
  
  self.view.backgroundColor = self.mybackgroundcolor;
  self.navigationItem.rightBarButtonItem = [self chartToggleButtonWithTarget:self action:@selector(chartToggleButtonPressed:)];
  
  self.barChartView = [[JBBarChartView alloc] init];
  self.barChartView.frame = CGRectMake(kJBBarChartViewControllerChartPadding, kJBBarChartViewControllerChartPadding, self.view.bounds.size.width - (kJBBarChartViewControllerChartPadding * 2), kJBBarChartViewControllerChartHeight);
  self.barChartView.delegate = self;
  self.barChartView.dataSource = self;
  self.barChartView.headerPadding = kJBBarChartViewControllerChartHeaderPadding;
  self.barChartView.backgroundColor = kJBColorBarChartBackground;
  
  JBChartHeaderView *headerView = [[JBChartHeaderView alloc] initWithFrame:CGRectMake(kJBBarChartViewControllerChartPadding, ceil(self.view.bounds.size.height * 0.5) - ceil(kJBBarChartViewControllerChartHeaderHeight * 0.5), self.view.bounds.size.width - (kJBBarChartViewControllerChartPadding * 2), kJBBarChartViewControllerChartHeaderHeight)];
  headerView.titleLabel.text = self.mygraphtitle;
  headerView.subtitleLabel.text = kJBStringLabel2012;
  headerView.separatorColor = kJBColorBarChartHeaderSeparatorColor;
  self.barChartView.headerView = headerView;
  
  JBBarChartFooterView *footerView = [[JBBarChartFooterView alloc] initWithFrame:CGRectMake(kJBBarChartViewControllerChartPadding, ceil(self.view.bounds.size.height * 0.5) - ceil(kJBBarChartViewControllerChartFooterHeight * 0.5), self.view.bounds.size.width - (kJBBarChartViewControllerChartPadding * 2), kJBBarChartViewControllerChartFooterHeight)];
  footerView.padding = kJBBarChartViewControllerChartFooterPadding;
  footerView.leftLabel.text = [[self.timePoints firstObject] uppercaseString];
  footerView.leftLabel.textColor = [UIColor whiteColor];
  footerView.rightLabel.text = [[self.timePoints lastObject] uppercaseString];
  footerView.rightLabel.textColor = [UIColor whiteColor];
  self.barChartView.footerView = footerView;
  
  self.informationView = [[JBChartInformationView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, CGRectGetMaxY(self.barChartView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.barChartView.frame) - CGRectGetMaxY(self.navigationController.navigationBar.frame))];
  [self.view addSubview:self.informationView];
  
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
  return kJBBarChartViewControllerNumBars;
}

- (NSUInteger)barPaddingForBarChartView:(JBBarChartView *)barChartView
{
  return kJBBarChartViewControllerBarPadding;
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
  [self.informationView setValueText:[NSString stringWithFormat:kJBStringLabelDegreesFahrenheit, [valueNumber intValue], kJBStringLabelDegreeSymbol] unitText:nil];
  [self.informationView setTitleText:kJBStringLabelWorldwideAverage];
  [self.informationView setHidden:NO animated:YES];
  [self setTooltipVisible:YES animated:YES atTouchPoint:touchPoint];
  [self.tooltipView setText:[[self.timePoints objectAtIndex:index] uppercaseString]];
}

- (void)didUnselectBarChartView:(JBBarChartView *)barChartView
{
  [self.informationView setHidden:YES animated:YES];
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
      float sum = 0.0;
      NSInteger valid_count = 0;
      self.most_negative_acce = 0.0;
      
      for (int i = 0; i < [array count]; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        [self.dataPoints addObject:[dict objectForKey:data]];
        [self.timePoints addObject:[[dict objectForKey:@"timeRecord"]substringToIndex:5]];
        if([(NSNumber *)[dict objectForKey:data] floatValue] != 0.0){
          sum = sum +  [(NSNumber *)[dict objectForKey:data] floatValue];
          NSLog(@" value is %f", [(NSNumber *)[dict objectForKey:data] floatValue]);
          NSLog(@" and sum is %f",   sum);
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
