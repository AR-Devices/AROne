//
//  ARSummaryFunctionGraphViewController.m
//  AROne
//
//  Created by Jerry Wu on 9/10/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "ARSummaryGraphViewController.h"
#import "ARSummaryGraphDetailViewController.h"
#import "BEMSimpleLineGraphView.h"

#import "ARDataPoint.h"
#import "PAImageView.h"


@interface ARSummaryGraphViewController ()
@property (nonatomic) NSMutableArray *dataPoints;
@property (nonatomic) NSMutableArray *timePoints;

@property (nonatomic) NSDate *createdAt;

@property (strong, nonatomic)  BEMSimpleLineGraphView *myGraph;
@property (strong, nonatomic) UILabel *labelValues;
@property (strong, nonatomic) UILabel *labelMax;
@property (strong, nonatomic) UILabel *labelTime;;

@end

@interface ARSummaryGraphViewController (){
  int previousStepperValue;
  int totalNumber;
}
@end
@implementation ARSummaryGraphViewController
@synthesize graphStyle = _graphStyle;
@synthesize selectedDate = _selectedDate;



- (id)initwithStyle:(ARSummaryGraphCellStyle)style
{
  [self setFunctionStyle:style];
  return self;
}

- (void)viewDidLoad
{
  
  [super viewDidLoad];
  self.title = @"Detail";//FIXME this information will need to be extracted from parent
  //    d4dee6
  self.view.backgroundColor = [UIColor colorWithRed:212.0/255.0 green:222.0/255.0 blue:230.0/255.0 alpha:1.0];

  self.dataPoints = [NSMutableArray new];
  self.timePoints = [NSMutableArray new];

  UIView *header = [self createQuickPersonalView];
  [self.view addSubview:header];
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


#pragma mark - Private Methods

- (UIView *) createQuickPersonalView
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  UIImage *icon = [UIImage imageWithData:[defaults objectForKey:@"userIcon"]];
  NSString *userName = [defaults objectForKey:@"userName"];
  
  UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,100)];
  header.backgroundColor = [UIColor clearColor];
  header.autoresizingMask = UIViewAutoresizingNone;
  
  CGRect imageRect = CGRectMake(10, 10, 76/1.9, 75/1.9);
//  UIImageView *personIcon = [[UIImageView alloc] initWithFrame:imageRect];
//  personIcon.image = icon;
  UIColor *ringColor = [UIColor colorWithRed:57/255.0 green:137/255.0 blue:194/255.0 alpha:1.0];
  PAImageView *avatarView = [[PAImageView alloc] initWithFrame:imageRect backgroundProgressColor:ringColor progressColor:[UIColor blueColor]];
  [avatarView setImage:icon];

  [header addSubview:avatarView];
  
  //  user Name, in the future
  UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, self.view.bounds.size.width - 90, 75/1.9)];
  name.font = [UIFont fontWithName:@"Avenir-Medium" size:30.0/1.9];
  name.textColor = [UIColor colorWithRed:109.0/255.0f green:109.0/255.0f blue:109.0/255.0f alpha:1.0];
  name.text = userName;
  name.backgroundColor = [UIColor clearColor];
  [header addSubview:name];
  return header;
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
  [query whereKey:@"dateRecord" equalTo:[formatter stringFromDate:self.selectedDate]];
//  [query whereKey:@"player" equalTo:[PFUser currentUser]];

  
//  NSMutableArray *keys = [[NSMutableArray alloc] init];
//  [keys addObject:@"speed"];
//  [keys addObject:@"acceleration"];
//  [keys addObject:@"verticalDrop"];
//  [query orderByDescending:@"createdAt"];
//  [query orderByAscending:@"createdAt"];
//  [keys addObject:@"createdAt"];
//  [query selectKeys:keys];
  [query setLimit:500];
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
      NSLog(@"JERRY %@", data);

      for (int i = 0; i < [array count]; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        [self.dataPoints addObject:[dict objectForKey:data]];
        [self.timePoints addObject:[[dict objectForKey:@"timeRecord"]substringToIndex:5]];


      }
      NSLog(@"dataPoints %@",self.dataPoints);
      NSLog(@"timePoints %@", self.timePoints);
      [self.myGraph reloadGraph];
      PFObject *object = [array lastObject];
      if ([[object createdAt] isEqual:self.createdAt])
        return;
      else
        self.createdAt = [object createdAt];
    }
    [self drawData];

    NSLog(@"data count is %lu", (unsigned long)self.dataPoints.count);
//    [self.view setNeedsDisplay];
//    NSLog(@"createAt %@", self.createdAt);
//    if (self.dataPoints.count < 500) {
//      [self queryDataPoints];
//    }
  }];
}
#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
  return (int)[self.dataPoints count];
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
  return [[self.dataPoints objectAtIndex:index] floatValue];
}

#pragma mark - SimpleLineGraph Delegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
  return 15;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
  return [self.timePoints objectAtIndex:index];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
  self.labelValues.text = [NSString stringWithFormat:@"%@", [self.dataPoints objectAtIndex:index]];
  self.labelTime.text = [NSString stringWithFormat:@"%@", [self.timePoints objectAtIndex:index]];
 //DONT REMOVE self.labelMax.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueAverage] intValue]];

//  self.labelDates.text = [NSString stringWithFormat:@"in %@", [self.timePoints objectAtIndex:index]];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
  [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    self.labelValues.alpha = 0.0;
//    self.labelDates.alpha = 0.0;
  } completion:^(BOOL finished){
    
    //self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
//    self.labelDates.text = [NSString stringWithFormat:@"between 2000 and %@", [self.timePoints lastObject]];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
      self.labelValues.alpha = 1.0; 
//      self.labelDates.alpha = 1.0;
    } completion:nil];
  }];
}

- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
  //self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
//  self.labelDates.text = [NSString stringWithFormat:@"between 2000 and %@", [self.timePoints lastObject]];
}
- (void)drawData{
  if([self.dataPoints count]==0){
    for (int i = 0; i < 2 ; i++) {
      [self.dataPoints addObject:@"loading"]; // Random values for the graph
      [self.timePoints addObject:[NSString stringWithFormat:@"%@",@"AROne"]]; // Dates for the X-Axis of the graph
      totalNumber = totalNumber + [[self.dataPoints objectAtIndex:i] intValue]; // All of the values added together
    }
  }else{
    for (int i = 0; i < [self.dataPoints count]; i++) {
      totalNumber = totalNumber + [[self.dataPoints objectAtIndex:i] intValue]; // All of the values added together
    }
  }
  
  
  self.myGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, 250)];
  self.myGraph.delegate = self;

  
  self.labelValues = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 100, 51)];
  self.labelValues.font = [UIFont fontWithName:@"Big Caslon" size:20.0];
  self.labelValues.text = [NSString stringWithFormat:@"%@", [self.dataPoints objectAtIndex:0]];
  self.labelValues.textAlignment = NSTextAlignmentCenter;
  
  self.labelMax = [[UILabel alloc] initWithFrame:CGRectMake(140, 350 ,90, 51)];
  self.labelMax.font = [UIFont fontWithName:@"Helvetica Neue" size:20.0];
  self.labelMax.textAlignment = UITextAlignmentRight;
  
  self.labelTime = [[UILabel alloc] initWithFrame:CGRectMake(30, -10, 100, 51)];
  self.labelTime.font = [UIFont fontWithName:@"Helvetica Neue" size:10.0];
  self.labelTime.text = [NSString stringWithFormat:@"%@", [self.timePoints objectAtIndex:0]];
  self.labelTime.textAlignment = NSTextAlignmentCenter;
  
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
  UIImage *acce_frame = [UIImage imageNamed:@"MasSpeedCard_bg"];
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
  self.myGraph.enableTouchReport = YES;

  self.myGraph.animationGraphEntranceSpeed = 0;
  //--------------------color options end ----------------------
  [self.view addSubview:self.myGraph];
  [self.view addSubview:labelValueFrame];
  [self.view addSubview:self.labelMax];
  [self.view addSubview:trip_number];
  [self.view addSubview:trip_number_unit];

}

@end
