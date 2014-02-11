//
//  ARTrailSummaryMapViewController.m
//  AROne
//
//  Created by Jerry Wu on 2/10/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARTrailSummaryMapViewController.h"
#import "trailPathView.h"

@interface ARTrailSummaryMapViewController () <UIScrollViewDelegate, trailPathSource>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIImageView *imageView;
@property BOOL zoomed;

@end

@implementation ARTrailSummaryMapViewController

#pragma mark - trailPathSource methods

- (NSArray *)trailPathViewData:(trailPathView *)graphView
{
  
  //    NSArray *points = [[NSArray alloc] initWithObjects:
  //                       [NSValue valueWithCGPoint:CGPointMake(571, 405.5)],   //LUMBERJACK
  //                       [NSValue valueWithCGPoint:CGPointMake(564.5, 419)],
  //                       [NSValue valueWithCGPoint:CGPointMake(558.5, 432)],
  //                       [NSValue valueWithCGPoint:CGPointMake(553, 439.5)],    //rows should be 5+3x lanes
  //                       [NSValue valueWithCGPoint:CGPointMake(544, 459.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(536, 488.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(527, 508)],
  //                       [NSValue valueWithCGPoint:CGPointMake(520.5, 525.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(505.5, 533)],
  //                       [NSValue valueWithCGPoint:CGPointMake(488.5, 547.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(474, 564.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(469.5, 575.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(463.5, 589)],
  //                       [NSValue valueWithCGPoint:CGPointMake(457, 612)],
  //                       [NSValue valueWithCGPoint:CGPointMake(444, 636)],
  //                       [NSValue valueWithCGPoint:CGPointMake(444, 636)],
  //                       [NSValue valueWithCGPoint:CGPointMake(444, 636)],
  
  //                       [NSValue valueWithCGPoint:CGPointMake(444, 636)],  //LOWER MAIN STREET
  //                       [NSValue valueWithCGPoint:CGPointMake(436, 646.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(420, 663.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(412.5, 676.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(404, 686.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(394, 700.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(384.5, 710)],
  //                       [NSValue valueWithCGPoint:CGPointMake(368.5, 729.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(358, 743.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(358, 743.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(358, 743.5)],
  
  
  //                       [NSValue valueWithCGPoint:CGPointMake(457, 673)],   //THE GULCH
  //                       [NSValue valueWithCGPoint:CGPointMake(451.5, 685.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(435, 706)],
  //                       [NSValue valueWithCGPoint:CGPointMake(426, 713.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(398.5, 735)],
  //                       [NSValue valueWithCGPoint:CGPointMake(368.5, 765.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(368.5, 765.5)],
  //                       [NSValue valueWithCGPoint:CGPointMake(368.5, 765.5)],
  //                       nil];
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
  //  CHCSVParser *parser = [[CHCSVParser alloc] initWithContentsOfCSVFile:@"data.csv"];
  //  parser.delegate = self;
  //  [parser parse];
  
//  NSArray *data = [NSArray arrayWithContentsOfCSVFile: [[NSBundle mainBundle] pathForResource:@"up1" ofType:@"csv"]];
//  NSMutableArray *up1 = [[NSMutableArray alloc] init];
//  NSMutableArray *up2 = [[NSMutableArray alloc] init];
//  NSMutableArray *down1 = [NSMutableArray new];
//  NSMutableArray *down2 = [NSMutableArray new];
//  for (NSArray *dataPoint in data) {
//    [up1 addObject:[NSValue valueWithCGPoint:CGPointMake([[dataPoint objectAtIndex:0] floatValue], [[dataPoint objectAtIndex:1] floatValue])]];
//  }
//  data = [NSArray arrayWithContentsOfCSVFile: [[NSBundle mainBundle] pathForResource:@"up2" ofType:@"csv"]];
//  for (NSArray *dataPoint in data) {
//    [up2 addObject:[NSValue valueWithCGPoint:CGPointMake([[dataPoint objectAtIndex:0] floatValue], [[dataPoint objectAtIndex:1] floatValue])]];
//  }
//  data = [NSArray arrayWithContentsOfCSVFile: [[NSBundle mainBundle] pathForResource:@"down1" ofType:@"csv"]];
//  for (NSArray *dataPoint in data) {
//    [down1 addObject:[NSValue valueWithCGPoint:CGPointMake([[dataPoint objectAtIndex:0] floatValue], [[dataPoint objectAtIndex:1] floatValue])]];
//  }
//  data = [NSArray arrayWithContentsOfCSVFile: [[NSBundle mainBundle] pathForResource:@"down2" ofType:@"csv"]];
//  for (NSArray *dataPoint in data) {
//    [down2 addObject:[NSValue valueWithCGPoint:CGPointMake([[dataPoint objectAtIndex:0] floatValue], [[dataPoint objectAtIndex:1] floatValue])]];
//  }
//  
//  
  NSMutableArray *pointsArray = [NSMutableArray new];
//  [pointsArray addObject:up1];
//  [pointsArray addObject:up2];
//  [pointsArray addObject:down1];
//  [pointsArray addObject:down2];
  [pointsArray addObject:lumberJack];
  [pointsArray addObject:lowerMainStreet];
  [pointsArray addObject:theGulch];
  
  return pointsArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  NSLog(@"innitWithNibName");
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    self.zoomed = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
  }
  return self;
}

- (void)viewDidLoad
{
  NSLog(@"viewDidLoad");
  [super viewDidLoad];
  //get image from library
  UIImage* image = [UIImage imageNamed:@"northstar-trail-map.jpg"];
  NSLog(@"view width is %f, height is %f", self.view.bounds.size.width, self.view.bounds.size.height);
  NSLog(@"image width is %f, height is %f", image.size.width, image.size.height);
  self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
  NSLog(@"imageview width is %f, height is %f", self.imageView.bounds.size.width, self.imageView.bounds.size.height);
  self.imageView.image = image;
  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  NSLog(@"scrollView width is %f, height is %f", self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
  
  self.scrollView.scrollEnabled = YES;
  self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.imageView.frame), CGRectGetHeight(self.imageView.frame));
  self.scrollView.showsHorizontalScrollIndicator = YES;
  self.scrollView.showsVerticalScrollIndicator = YES;
  //    self.scrollView.scrollsToTop = NO;
  self.scrollView.delegate = self;
  [self.scrollView addSubview:self.imageView];
  [self.view addSubview:self.scrollView];
  
  self.scrollView.minimumZoomScale=0.4;
  self.scrollView.maximumZoomScale=6.0;
  //    self.scrollView.contentSize=CGSizeMake(1280, 960);
  //    self.scrollView.delegate=self
  //    tap gestures
  //target - what object is going to handle the gesture when it gets recognised
  //the argument for tap: is the gesture that caused this message to be sent
  UITapGestureRecognizer *tapOnce = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapOnce:)];
  UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapTwice:)];
  
  tapOnce.numberOfTapsRequired = 1;
  tapTwice.numberOfTapsRequired = 2;
  
  //stops tapOnce from overriding tapTwice
  [tapOnce requireGestureRecognizerToFail:tapTwice];
  
  //then need to add the gesture recogniser to a view - this will be the view that recognises the gesture
  //    [self.scrollView addGestureRecognizer:tapOnce];
  [self.scrollView addGestureRecognizer:tapTwice];
  
  trailPathView *trailView = [[trailPathView alloc] initWithFrame:self.imageView.bounds];
  trailView.dataSource = self;
  [self.imageView addSubview:trailView];
  
}


- (void)tapOnce:(UIGestureRecognizer *)gesture
{
  //    NSLog(@"gesture is ", [gesture locationInView:self.scrollView]);
  
  //step 1: find where is being touched
  CGPoint point = [gesture locationInView:self.scrollView];
  //step 2: create a top left point
  point = CGPointMake(point.x - self.scrollView.bounds.size.height/2, point.y - self.scrollView.bounds.size.width/2);
  //step 3: create a rect using that point
  CGRect rect = CGRectMake(point.x, point.y, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
  //on a single  tap, call zoomToRect in UIScrollView
  [self.scrollView zoomToRect:rect animated:YES];
}


- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
  
  CGRect zoomRect;
  
  zoomRect.size.height = [_imageView frame].size.height / scale;
  zoomRect.size.width  = [_imageView frame].size.width  / scale;
  
  center = [_imageView convertPoint:center fromView:self.scrollView];
  
  zoomRect.origin.x    = center.x - ((zoomRect.size.width / 2.0));
  zoomRect.origin.y    = center.y - ((zoomRect.size.height / 2.0));
  
  return zoomRect;
}

- (void)tapTwice:(UIGestureRecognizer *)recognizer
{
  float newScale = [self.scrollView zoomScale] * 6.0;
  
  if (self.scrollView.zoomScale > self.scrollView.minimumZoomScale)
  {
    [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
  }
  else
  {
    CGRect zoomRect = [self zoomRectForScale:newScale
                                  withCenter:[recognizer locationInView:recognizer.view]];
    [self.scrollView zoomToRect:zoomRect animated:YES];
  }
}












- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
  //reset zoomScale back to 1 so that contentSize can be modified correctly
  self.scrollView.zoomScale = 1;
  //blah
  self.scrollView.frame = self.view.bounds;
  // reset scrolling area equal to size of image
  self.scrollView.contentSize = self.imageView.bounds.size;
  
  //reset the image frame to the size of the image
  self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
  
  //set the zoomScale to what we actually want
  //    self.scrollView.zoomScale = [self findZoomScale];
}

- (void)viewWillAppear:(BOOL)animated
{
  NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
  NSLog(@"viewDidAppear");
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  //    NSLog(@"viewForZoomingInScrollView");
  return self.imageView;
}



@end
