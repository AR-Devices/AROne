//
//  ARSummaryFunctionGraphTouchViewController.m
//  AROne
//
//  Created by Jerry Wu on 10/8/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "ARSummaryGraphDetailViewController.h"
#import "ARSummaryGraphTouchView.h"

@interface ARSummaryGraphDetailViewController ()

@end

@implementation ARSummaryGraphDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.title = @"SPEED detail";//FIXME this information will need to be extracted from parent
      //    d4dee6
      self.view.backgroundColor = [UIColor colorWithRed:212.0/255.0 green:222.0/255.0 blue:230.0/255.0 alpha:1.0];
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  UIView *graphView = [[ARSummaryGraphTouchView alloc] initWithFrame:CGRectMake(50,0,400, 200)];
  [self.view addSubview:graphView];
}

@end
