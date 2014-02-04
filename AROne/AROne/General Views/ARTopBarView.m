//
//  ARTopBarView.m
//  AROne
//
//  Created by Chenchen Zheng on 9/9/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "ARTopBarView.h"

@implementation ARTopBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithStyle:(ARTopBarViewStyle)style viewBounds:(CGRect)frame withBlock:(void (^)(ARTopBarView *segment))callbackBlock
{
  
  NSDictionary *redText = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIColor colorWithRed:211.0/255.0 green:23.0/255.0 blue:50.0/255.0 alpha:1.0],
                                  NSForegroundColorAttributeName,
                                  [UIFont fontWithName:@"Avenir-Medium" size:34.0/1.9],
                                  NSFontAttributeName,
                                  nil];
  NSDictionary *orangeText = [NSDictionary dictionaryWithObjectsAndKeys:
                              [UIColor colorWithRed:238.0/255.0 green:150.0/255.0 blue:47.0/255.0 alpha:1.0],
                              NSForegroundColorAttributeName,
                              [UIFont fontWithName:@"Avenir-Medium" size:34.0/1.9],
                              NSFontAttributeName,
                              nil];
  NSDictionary *greenText = [NSDictionary dictionaryWithObjectsAndKeys:
                              [UIColor colorWithRed:47.0/255.0 green:179.0/255.0 blue:182.0/255.0 alpha:1.0],
                              NSForegroundColorAttributeName,
                              [UIFont fontWithName:@"Avenir-Medium" size:34.0/1.9],
                              NSFontAttributeName,
                              nil];
  
  switch (style) {
    case ARTopBarViewStyleCalendar:
    {
      NSLog(@"ATTopBarViewStyleCalendar called");
      NSArray *itemArray = [NSArray arrayWithObjects: @"<", @"Today", @">", nil];
      self = [[ARTopBarView alloc] initWithItems:itemArray];
      self.frame = CGRectMake( 0, 0, CGRectGetWidth(frame), 32.5);;
      [self setBackgroundImage:[UIImage imageNamed:@"calendar_middle"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
      [self setBackgroundImage:[UIImage imageNamed:@"calendar_selected"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
      self.selectedSegmentIndex = -1;
//      self.segmentedControlStyle = UISegmentedControlStyleBar;
      self.momentary = YES;
      self.alpha = 0.9;
      [self setWidth:40 forSegmentAtIndex:0];
      [self setBackgroundColor: [UIColor clearColor]];
      [self setWidth:CGRectGetWidth(frame) - 80 forSegmentAtIndex:1];
      [self setWidth:40 forSegmentAtIndex:2];
      [self setBackgroundColor:[UIColor clearColor]];
      break;
    }
    case ARTopBarViewStyleDWM:
    {
      NSLog(@"ARTopBarViewStyleDWM");
      CGRect rect = CGRectMake( 0, 0, CGRectGetWidth(frame), 32.5);
      NSArray *itemArray = [NSArray arrayWithObjects: @"DAY", @"WEEK", @"MONTH", nil];
      self = [[ARTopBarView alloc] initWithItems:itemArray];
      self.frame = rect;
      [self setTitleTextAttributes:greenText forState:UIControlStateSelected];
      [self setBackgroundImage:[UIImage imageNamed:@"calendar_selected"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
      [self setBackgroundImage:[UIImage imageNamed:@"calendar_selected"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
      self.selectedSegmentIndex = 0;
//      self.segmentedControlStyle = UISegmentedControlStyleBar;
      self.alpha = 0.9;
      [self setBackgroundColor: [UIColor clearColor]];
      [self setWidth:CGRectGetWidth(frame)/3 forSegmentAtIndex:0];
      [self setWidth:CGRectGetWidth(frame)/3 forSegmentAtIndex:1];
      [self setWidth:CGRectGetWidth(frame)/3 forSegmentAtIndex:2];
      break;
    }
    case ARTopBarViewStyleSelector:
    {
      NSLog(@"ARTopBarViewStyleSelector");
      CGRect rect = CGRectMake( 0, 0, CGRectGetWidth(frame), 32.5);
      NSArray *activityArray = [NSArray arrayWithObjects:@"SPEED", @"V.DROP", @"ACCEL.", nil];
      self = [[ARTopBarView alloc] initWithItems:activityArray];
      self.frame = rect;
      [self setTitleTextAttributes:greenText forState:UIControlStateSelected];
      [self setBackgroundImage:[UIImage imageNamed:@"calendar_selected"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
      [self setBackgroundImage:[UIImage imageNamed:@"calendar_selected"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
      self.selectedSegmentIndex = 0;
      //      self.segmentedControlStyle = UISegmentedControlStyleBar;
      self.alpha = 0.9;
      [self setBackgroundColor: [UIColor clearColor]];
      [self setWidth:CGRectGetWidth(frame)/3 forSegmentAtIndex:0];
      [self setWidth:CGRectGetWidth(frame)/3 forSegmentAtIndex:1];
      [self setWidth:CGRectGetWidth(frame)/3 forSegmentAtIndex:2];
      break;
    }
    case ARTopBarViewStyleDWMSmall:
    {
      NSLog(@"ARTopBarViewStyleDWMSmall");
      CGRect rect = CGRectMake(CGRectGetWidth(frame)-100, 0, 100, 32.5);
      NSArray *dateArray = [NSArray arrayWithObjects: @"1D", @"1W", @"1M", nil];
      self = [[ARTopBarView alloc] initWithItems:dateArray];
      [self setDividerImage:[self imageWithColor:[UIColor clearColor]]
                  forLeftSegmentState:UIControlStateNormal
                    rightSegmentState:UIControlStateNormal
                           barMetrics:UIBarMetricsDefault];
      [self setDividerImage:[self imageWithColor:[UIColor clearColor]]
        forLeftSegmentState:UIControlStateSelected
          rightSegmentState:UIControlStateNormal
                 barMetrics:UIBarMetricsDefault];
      [self setDividerImage:[self imageWithColor:[UIColor clearColor]]
        forLeftSegmentState:UIControlStateNormal
          rightSegmentState:UIControlStateSelected
                 barMetrics:UIBarMetricsDefault];

      self.frame = rect;
      [self setTitleTextAttributes:orangeText forState:UIControlStateSelected];
//      [self setBackgroundImage:[UIImage imageNamed:@"calendar_selected"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//      [self setBackgroundImage:[UIImage imageNamed:@"calendar_selected"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
      self.selectedSegmentIndex = 0;
      //      self.segmentedControlStyle = UISegmentedControlStyleBar;
      self.alpha = 0.9;
      [self setBackgroundColor: [UIColor clearColor]];
      [self setWidth:100/3 forSegmentAtIndex:0];
      [self setWidth:100/3 forSegmentAtIndex:1];
      [self setWidth:100/3 forSegmentAtIndex:2];
      break;
    }
  }
  callbackBlock(self);
  return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (UIImage *)imageWithColor:(UIColor *)color {
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

@end
