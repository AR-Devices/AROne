//
//  HomeViewController.m
//  TrailSummary
//
//  Created by Chenchen Zheng on 12/17/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "HomeViewController.h"
#import "trailPathView.h"

@interface HomeViewController () <UIScrollViewDelegate, trailPathSource>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIImageView *imageView;
@property BOOL zoomed;

@end

@implementation HomeViewController

#pragma mark - trailPathSource methods

- (NSArray *)trailPathViewData:(trailPathView *)graphView
{
    NSArray *points = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(0, 50)],
                       [NSValue valueWithCGPoint:CGPointMake(10, 25)],
                       [NSValue valueWithCGPoint:CGPointMake(2, 50)],
                       [NSValue valueWithCGPoint:CGPointMake(30, 75)],
                       [NSValue valueWithCGPoint:CGPointMake(40, 60)],
                       [NSValue valueWithCGPoint:CGPointMake(50, 30)],
                       [NSValue valueWithCGPoint:CGPointMake(60, 45)],
                       [NSValue valueWithCGPoint:CGPointMake(78, 45)],
                       [NSValue valueWithCGPoint:CGPointMake(57, 23)],
                       nil];
  NSArray *points2 = [[NSArray alloc] initWithObjects:
                     [NSValue valueWithCGPoint:CGPointMake(0, 50)],
                     [NSValue valueWithCGPoint:CGPointMake(10, 25)],
                     [NSValue valueWithCGPoint:CGPointMake(2, 50)],
                     [NSValue valueWithCGPoint:CGPointMake(30, 75)],
                     [NSValue valueWithCGPoint:CGPointMake(40, 60)],
                     [NSValue valueWithCGPoint:CGPointMake(50, 30)],
                     [NSValue valueWithCGPoint:CGPointMake(60, 45)],
                     [NSValue valueWithCGPoint:CGPointMake(78, 45)],
                     [NSValue valueWithCGPoint:CGPointMake(57, 23)],
                     nil];
  NSMutableArray *pointsArray = [NSMutableArray new];
  [pointsArray addObject:points];
  
    
  return pointsArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"innitWithNibName");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.zoomed = NO;

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

- (void)tapTwice:(UIGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:self.scrollView];
    NSLog(@"point.x = %f, point.y = %f", point.x, point.y);
    if (self.zoomed) {
        //zoom out
        NSLog(@"zoomed out");
        
        point = CGPointMake(point.x - self.scrollView.bounds.size.width/2, point.y - self.scrollView.bounds.size.height/2);
            NSLog(@"point.x = %f, point.y = %f", point.x, point.y);
        CGRect rect = CGRectMake(point.x, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        [self.scrollView zoomToRect:rect animated:YES];
        self.zoomed = NO;
    } else {
        //zoom in
        NSLog(@"zoomed in");
        point = CGPointMake(point.x - self.scrollView.bounds.size.width/4, point.y - self.scrollView.bounds.size.height/4);
        CGRect rect = CGRectMake(point.x, point.y, self.scrollView.bounds.size.width/2, self.scrollView.bounds.size.height/2);
        //on a double tap, call zoomToRect in UIScrollView
        [self.scrollView zoomToRect:rect animated:YES];
        self.zoomed = YES;
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
