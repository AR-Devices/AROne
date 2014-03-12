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

#import "ARDataPoint.h"


@interface ARSummaryGraphViewController ()
@property (nonatomic) NSMutableArray *dataPoints;

@end

@implementation ARSummaryGraphViewController
@synthesize graphStyle = _graphStyle;
@synthesize selectedDate = _selectedDate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
      self.title = @"SPEED";//FIXME this information will need to be extracted from parent
      //    d4dee6
      self.tableView.backgroundColor = [UIColor colorWithRed:212.0/255.0 green:222.0/255.0 blue:230.0/255.0 alpha:1.0];
//      self.tableView.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (id)initwithStyle:(ARSummaryGraphCellStyle)style
{
  [self setFunctionStyle:style];
  return self;
}
- (void)viewDidLoad
{
  [super viewDidLoad];
  self.dataPoints = [[NSMutableArray alloc]init];
}

- (void)viewWillAppear:(BOOL)animated
{
  [self queryDataPoints];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 300;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"--------------------1--------------");

  NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%ld",(long)indexPath.section];
  UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
  if (indexPath.section == 0) {
    cell = [ARSummaryGraphCell cellWithStyle:self.graphStyle andValues:self.dataPoints];
  }
  //number cgrect 394 136
  cell.selectionStyle = UITableViewCellEditingStyleNone;
  cell.backgroundColor = [UIColor clearColor];
  
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//  NSLog(@"SummaryFunctionGraph clicked at %d", indexPath.section);
//  NSLog(@"----------------------------------");
//
//  ARSummaryGraphDetailViewController *summaryTabGraph = [[ARSummaryGraphDetailViewController alloc] init];
//  [self.navigationController pushViewController:summaryTabGraph animated:YES];
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

/**
 * @desc CCZ: Quick Personal View is the top view with Shao Peng's face
 * @param null
 * @return configured UIView
 */
- (UIView *) createQuickPersonalView
{
  NSLog(@"--------------------2--------------");

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

//- (void) querySummaryData {
//  PFQuery *query = [ARSummary query];
//  //FIXIT: Need to compare with selected date from Top calender bar, and this query has to be
//  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//  [formatter setDateFormat:@"yyyy-MM-dd"];
//  [query whereKey:@"date" equalTo:[formatter stringFromDate:self.myDate]];
//  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//    if (!error && ([objects count] != 0)) {
//      ARSummary *firstMeasurement = objects[0];
//      NSLog(@"firstMeasuremetn is %@", firstMeasurement);
//      // ...
//      self.max_speed_value = [NSString stringWithFormat:@"%0.1f",firstMeasurement.maxSpeed];
//      self.vertical_drop_value = [NSString stringWithFormat:@"%d", firstMeasurement.verticalDrop];
//      self.acceleration_value = [NSString stringWithFormat:@"%0.1f", firstMeasurement.maxAcceleration];
//    } else {
//      self.max_speed_value = @"0";
//      self.vertical_drop_value = @"0";
//      self.acceleration_value = @"0";
//    }
//    [self.tableView reloadData];
//  }];
//}

- (void) queryDataPoints
{
  PFQuery *query = [ARDataPoint query];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd"];
  NSLog(@"seletedDate is %@", [formatter stringFromDate:self.selectedDate]);
  [query whereKey:@"dateRecord" equalTo:[formatter stringFromDate:self.selectedDate]];
  [query whereKey:@"player" equalTo:[PFUser currentUser]];
//  [query getObjectInBackgroundWithId:@"speed" block:^(PFObject *object, NSError *error) {
//    NSLog(@"objects %@", object);
//  }];
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
        data = @"verticleDrop";
      }
      for (int i = 0; i < [array count]; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        [self.dataPoints addObject:[dict objectForKey:@"speed"]];
//        NSLog(@"%@", [dict objectForKey:@"speed"]);
        
      }
      [self.tableView reloadData];
//      ARDataPoint *dataPoint = objects[0];
      
    }
  }];
  
}



@end
