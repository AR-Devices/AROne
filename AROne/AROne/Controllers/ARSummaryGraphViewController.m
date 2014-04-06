//
//  ARSummaryFunctionGraphViewController.m
//  AROne
//
//  Created by Jerry Wu on 9/10/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "ARSummaryGraphViewController.h"
//#import "UIViewController+AKTabBarController.h"
#import "ARSummaryGraphDetailViewController.h"
#import "BEMSimpleLineGraphView.h"

#import "ARDataPoint.h"


@interface ARSummaryGraphViewController ()
@property (nonatomic) NSMutableArray *dataPoints;
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
  self.ArrayOfValues = [[NSMutableArray alloc] init];
  self.ArrayOfDates = [[NSMutableArray alloc] init];
  
  [super viewDidLoad];
  self.title = @"SPEED";//FIXME this information will need to be extracted from parent
  //    d4dee6
  self.view.backgroundColor = [UIColor colorWithRed:212.0/255.0 green:222.0/255.0 blue:230.0/255.0 alpha:1.0];

  self.dataPoints = [[NSMutableArray alloc]init];
  UIView *header = [self createQuickPersonalView];
  [self.view addSubview:header];
  
  for (int i = 0; i < 9; i++) {
    [self.ArrayOfValues addObject:[NSNumber numberWithInteger:(arc4random() % 70000)]]; // Random values for the graph
    [self.ArrayOfDates addObject:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:2000 + i]]]; // Dates for the X-Axis of the graph
    NSLog(@"JERRY %d  %d",i, [[self.ArrayOfValues objectAtIndex:i] intValue]);
    NSLog(@"JERRY %d  %d",i, [[self.ArrayOfDates objectAtIndex:i] intValue]);

    totalNumber = totalNumber + [[self.ArrayOfValues objectAtIndex:i] intValue]; // All of the values added together
  }
  

   BEMSimpleLineGraphView *myGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, 60, 320, 250)];
   myGraph.delegate = self;
  
  
  self.labelValues = [[UILabel alloc] initWithFrame:CGRectMake(20, 318, 280, 51)];
  self.labelValues.font = [UIFont fontWithName:@"Helvetica Neue" size:40.0];
  self.labelValues.text = [NSString stringWithFormat:@"%i", [[myGraph calculatePointValueSum] intValue]];
  self.labelValues.textAlignment = NSTextAlignmentCenter;
  //--------------------color options start---------------------
  UIColor *color;
  color = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
//  color = [UIColor colorWithRed:255.0/255.0 green:187.0/255.0 blue:31.0/255.0 alpha:1.0];
//  color = [UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0];
  myGraph.colorTop = color;
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

- (void)viewWillAppear:(BOOL)animated
{
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
  name.text = @"Peng Shao";
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
      NSLog(@"objects %@", objects);
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
      }
      PFObject *object = [array lastObject];
      if ([[object createdAt] isEqual:self.createdAt])
        return;
      else
        self.createdAt = [object createdAt];
    }
    
    NSLog(@"data count is %lu", (unsigned long)self.dataPoints.count);
 //   [self.tableView reloadData];

//    NSLog(@"createAt %@", self.createdAt);
//    if (self.dataPoints.count < 500) {
//      [self queryDataPoints];
//    }
  }];
}
#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
  return (int)[self.ArrayOfValues count];
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
  return [[self.ArrayOfValues objectAtIndex:index] floatValue];
}

#pragma mark - SimpleLineGraph Delegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
  return 1;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
  return [self.ArrayOfDates objectAtIndex:index];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
  self.labelValues.text = [NSString stringWithFormat:@"%@", [self.ArrayOfValues objectAtIndex:index]];
//  self.labelDates.text = [NSString stringWithFormat:@"in %@", [self.ArrayOfDates objectAtIndex:index]];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
  [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    self.labelValues.alpha = 0.0;
//    self.labelDates.alpha = 0.0;
  } completion:^(BOOL finished){
    
    self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
//    self.labelDates.text = [NSString stringWithFormat:@"between 2000 and %@", [self.ArrayOfDates lastObject]];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
      self.labelValues.alpha = 1.0; 
//      self.labelDates.alpha = 1.0;
    } completion:nil];
  }];
}

- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
  self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
//  self.labelDates.text = [NSString stringWithFormat:@"between 2000 and %@", [self.ArrayOfDates lastObject]];
}

@end
