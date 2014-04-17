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

@property (weak, nonatomic)  BEMSimpleLineGraphView *myGraph;
@property (strong, nonatomic) UILabel *labelValues;
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



//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//  NSLog(@"--------------------1--------------");
//
//  NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%ld",(long)indexPath.section];
//  UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    
//  if (indexPath.section == 0) {
//    cell = [ARSummaryGraphCell cellWithStyle:self.graphStyle andValues:self.dataPoints];
//  }
//  cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//  //number cgrect 394 136
//  cell.backgroundColor = [UIColor clearColor];
//  
//    return cell;
//}


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
        [self.timePoints addObject:[dict objectForKey:@"timeRecord"]];


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
  return 10;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
  return [self.timePoints objectAtIndex:index];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
  self.labelValues.text = [NSString stringWithFormat:@"%@", [self.dataPoints objectAtIndex:index]];
//  self.labelDates.text = [NSString stringWithFormat:@"in %@", [self.timePoints objectAtIndex:index]];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
  [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    self.labelValues.alpha = 0.0;
//    self.labelDates.alpha = 0.0;
  } completion:^(BOOL finished){
    
    self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
//    self.labelDates.text = [NSString stringWithFormat:@"between 2000 and %@", [self.timePoints lastObject]];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
      self.labelValues.alpha = 1.0; 
//      self.labelDates.alpha = 1.0;
    } completion:nil];
  }];
}

- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
  self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
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
  
  
  BEMSimpleLineGraphView *myGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(-10, 60, 330, 250)];
  myGraph.delegate = self;
  
  
  self.labelValues = [[UILabel alloc] initWithFrame:CGRectMake(20, 318, 280, 51)];
  self.labelValues.font = [UIFont fontWithName:@"Helvetica Neue" size:40.0];
  self.labelValues.text = [NSString stringWithFormat:@"%i", [[myGraph calculatePointValueSum] intValue]];
  self.labelValues.textAlignment = NSTextAlignmentCenter;
  //--------------------color options start---------------------
  UIColor *color = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
  //  color = [UIColor colorWithRed:255.0/255.0 green:187.0/255.0 blue:31.0/255.0 alpha:1.0];
  //  color = [UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0];
//  myGraph.colorTop = color;
  myGraph.colorBottom = color;
  myGraph.backgroundColor = color;
  self.view.tintColor = color;
  self.labelValues.textColor = color;
  self.navigationController.navigationBar.tintColor = color;
  myGraph.enableTouchReport = YES;
  myGraph.colorLine = [UIColor whiteColor];
  myGraph.colorXaxisLabel = [UIColor whiteColor];

  myGraph.widthLine = 3.0;
  myGraph.enableTouchReport = YES;
  myGraph.enableBezierCurve = YES;
  //--------------------color options end ----------------------
  [self.view addSubview:myGraph];
  [self.view addSubview:self.labelValues];
}

@end
