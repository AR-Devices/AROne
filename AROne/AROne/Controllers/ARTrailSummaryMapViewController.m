//
//  ARTrailSummaryMapViewController.m
//  AROne
//
//  Created by Jerry Wu on 2/10/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARTrailSummaryMapViewController.h"
#import "ARTrailSummaryViewController.h"
#import "trailPathView.h"

@interface ARTrailSummaryMapViewController () <UIScrollViewDelegate, trailPathSource>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIImageView *imageView;
@property BOOL zoomed;
@property BOOL trailOn;
@property (nonatomic) trailPathView* trailPath;
@property (nonatomic) UIImage * map;

@end

@implementation ARTrailSummaryMapViewController

#pragma mark - trailPathSource methods

- (NSArray *)trailPathViewData:(trailPathView *)graphView
{
  

  NSArray *lumberJack = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(266.5, 189)],   //LUMBERJACK
                         [NSValue valueWithCGPoint:CGPointMake(262.5, 197)],
                         [NSValue valueWithCGPoint:CGPointMake(259.5, 204)],
                         [NSValue valueWithCGPoint:CGPointMake(255.5, 214)],    //rows should be 5+3x lanes
                         [NSValue valueWithCGPoint:CGPointMake(252.5, 222)],
                         [NSValue valueWithCGPoint:CGPointMake(250.5, 229)],
                         [NSValue valueWithCGPoint:CGPointMake(247.5, 239)],
                         [NSValue valueWithCGPoint:CGPointMake(242.5, 247)],
                         [NSValue valueWithCGPoint:CGPointMake(232.5, 254)],
                         [NSValue valueWithCGPoint:CGPointMake(225.5, 259)],
                         [NSValue valueWithCGPoint:CGPointMake(221.5, 265)],
                         [NSValue valueWithCGPoint:CGPointMake(217.5, 273)],
                         [NSValue valueWithCGPoint:CGPointMake(213.5, 280)],
                         [NSValue valueWithCGPoint:CGPointMake(211.5, 288)],
                         [NSValue valueWithCGPoint:CGPointMake(207.5, 299)], nil];
//  
//  
  NSArray *lowerMainStreet = [[NSArray alloc] initWithObjects:
                              [NSValue valueWithCGPoint:CGPointMake(207.5, 300)],  //LOWER MAIN STREET
                              [NSValue valueWithCGPoint:CGPointMake(203.5, 305)],
                              [NSValue valueWithCGPoint:CGPointMake(198.5, 310)],
                              [NSValue valueWithCGPoint:CGPointMake(193.5, 317)],
                              [NSValue valueWithCGPoint:CGPointMake(189.5, 323)],
                              [NSValue valueWithCGPoint:CGPointMake(183.5, 331)],
                              [NSValue valueWithCGPoint:CGPointMake(178.5, 337)],
                              [NSValue valueWithCGPoint:CGPointMake(172.5, 343)], nil];
  NSArray *theGulch = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(214.5, 317)],   //THE GULCH
                       [NSValue valueWithCGPoint:CGPointMake(212.5, 321)],
                      [NSValue valueWithCGPoint:CGPointMake(210.5, 324)],
                      [NSValue valueWithCGPoint:CGPointMake(207.5, 328)],
                     [NSValue valueWithCGPoint:CGPointMake(204.5, 330)],
                      [NSValue valueWithCGPoint:CGPointMake(201.5, 335)],
                       [NSValue valueWithCGPoint:CGPointMake(197.5, 338)],
                       [NSValue valueWithCGPoint:CGPointMake(193.5, 340)],
                      [NSValue valueWithCGPoint:CGPointMake(189.5, 343)],
                       [NSValue valueWithCGPoint:CGPointMake(185.5, 347)],
                       [NSValue valueWithCGPoint:CGPointMake(193.5, 340.5)],
                       [NSValue valueWithCGPoint:CGPointMake(190.5, 342.5)],
                       [NSValue valueWithCGPoint:CGPointMake(186.5, 344.5)],
                       [NSValue valueWithCGPoint:CGPointMake(182.5, 350.5)],nil];
  
    NSArray *Skidtrail = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(220.5, 158.5)],
                         [NSValue valueWithCGPoint:CGPointMake(228.5, 162.5)],
                         [NSValue valueWithCGPoint:CGPointMake(238.5, 169.5)],
                         [NSValue valueWithCGPoint:CGPointMake(245.5, 174.5)],
                         [NSValue valueWithCGPoint:CGPointMake(253.5, 181.5)],
                         [NSValue valueWithCGPoint:CGPointMake(262.5, 186.5)],
                         [NSValue valueWithCGPoint:CGPointMake(168.5, 191.5)],nil];

  NSArray *Magicmoglus = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(212, 164)],
                       [NSValue valueWithCGPoint:CGPointMake(217, 167)],
                       [NSValue valueWithCGPoint:CGPointMake(221, 173)],
                       [NSValue valueWithCGPoint:CGPointMake(225, 177)],
                       [NSValue valueWithCGPoint:CGPointMake(230, 182)],
                       [NSValue valueWithCGPoint:CGPointMake(236, 187)],
                       [NSValue valueWithCGPoint:CGPointMake(241, 190)],
                       [NSValue valueWithCGPoint:CGPointMake(245, 194)],
                       [NSValue valueWithCGPoint:CGPointMake(249, 198)],
                       [NSValue valueWithCGPoint:CGPointMake(254, 203)],
                       [NSValue valueWithCGPoint:CGPointMake(259, 208)],nil];

  NSArray *Sidewinder = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(190.5, 161.5)],
                       [NSValue valueWithCGPoint:CGPointMake(194.5, 168.5)],
                       [NSValue valueWithCGPoint:CGPointMake(196.5, 174.5)],
                       [NSValue valueWithCGPoint:CGPointMake(200.5, 181.5)],
                       [NSValue valueWithCGPoint:CGPointMake(203.5, 188.5)],
                       [NSValue valueWithCGPoint:CGPointMake(206.5, 197.5)],
                       [NSValue valueWithCGPoint:CGPointMake(210.5, 210.5)],
                       [NSValue valueWithCGPoint:CGPointMake(210.5, 218.5)],
                       [NSValue valueWithCGPoint:CGPointMake(210.5, 228.5)],
                       [NSValue valueWithCGPoint:CGPointMake(212.5, 244.5)],
                       [NSValue valueWithCGPoint:CGPointMake(214.5, 253.5)],
                       [NSValue valueWithCGPoint:CGPointMake(213.5, 264.5)],nil];

  
  NSArray *Forerunner = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(218, 180)],
                         [NSValue valueWithCGPoint:CGPointMake(218, 185)],
                         [NSValue valueWithCGPoint:CGPointMake(216, 192)],
                         [NSValue valueWithCGPoint:CGPointMake(217, 198)],
                         [NSValue valueWithCGPoint:CGPointMake(218, 204)],
                         [NSValue valueWithCGPoint:CGPointMake(215.5, 212)],
                         [NSValue valueWithCGPoint:CGPointMake(214.5, 218)],
                         [NSValue valueWithCGPoint:CGPointMake(214.5, 228)],
                         [NSValue valueWithCGPoint:CGPointMake(214.5, 237)],nil];
  
  NSArray *Moonshine = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(179.5, 171.5)],
                         [NSValue valueWithCGPoint:CGPointMake(182.5, 178.5)],
                         [NSValue valueWithCGPoint:CGPointMake(186.5, 185.5)],
                         [NSValue valueWithCGPoint:CGPointMake(187.5, 195.5)],
                         [NSValue valueWithCGPoint:CGPointMake(190.5, 206.5)],
                         [NSValue valueWithCGPoint:CGPointMake(192.5, 216.5)],
                         [NSValue valueWithCGPoint:CGPointMake(197.5, 238.5)],
                         [NSValue valueWithCGPoint:CGPointMake(199.5, 246.5)],
                         [NSValue valueWithCGPoint:CGPointMake(201.5, 254.5)],
                         [NSValue valueWithCGPoint:CGPointMake(206.5, 263.5)],
                         [NSValue valueWithCGPoint:CGPointMake(213.5, 272.5)],nil];
  
  NSArray *Pinball = [[NSArray alloc] initWithObjects:
                        [NSValue valueWithCGPoint:CGPointMake(172, 186)],
                        [NSValue valueWithCGPoint:CGPointMake(176, 194)],
                        [NSValue valueWithCGPoint:CGPointMake(176, 201)],
                        [NSValue valueWithCGPoint:CGPointMake(175, 208)],
                        [NSValue valueWithCGPoint:CGPointMake(179, 216.5)],
                        [NSValue valueWithCGPoint:CGPointMake(179, 224.5)],
                        [NSValue valueWithCGPoint:CGPointMake(180, 234.5)],
                        [NSValue valueWithCGPoint:CGPointMake(179, 242)],
                        [NSValue valueWithCGPoint:CGPointMake(179, 249.5)],
                        [NSValue valueWithCGPoint:CGPointMake(183, 255.5)],
                        [NSValue valueWithCGPoint:CGPointMake(189, 266.5)],
                        [NSValue valueWithCGPoint:CGPointMake(191, 275.5)],
                        [NSValue valueWithCGPoint:CGPointMake(192, 284.5)],
                        [NSValue valueWithCGPoint:CGPointMake(193, 294.5)],
                        [NSValue valueWithCGPoint:CGPointMake(196, 308.5)],nil];
  
  NSArray *Thestairs = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(167.5, 190.5)],
                         [NSValue valueWithCGPoint:CGPointMake(166.5, 197.5)],
                         [NSValue valueWithCGPoint:CGPointMake(165.5, 210.5)],
                         [NSValue valueWithCGPoint:CGPointMake(164.5, 220.5)],
                         [NSValue valueWithCGPoint:CGPointMake(164.5, 231.5)],
                         [NSValue valueWithCGPoint:CGPointMake(163.5, 244.5)],
                         [NSValue valueWithCGPoint:CGPointMake(165.5, 254)],
                         [NSValue valueWithCGPoint:CGPointMake(170.5, 261)],nil];
  
  NSArray *Pipeline = [[NSArray alloc] initWithObjects:
                        [NSValue valueWithCGPoint:CGPointMake(172.5, 263.5)],
                        [NSValue valueWithCGPoint:CGPointMake(177.5, 271.5)],
                        [NSValue valueWithCGPoint:CGPointMake(178.5, 279.5)],
                        [NSValue valueWithCGPoint:CGPointMake(179.5, 292.5)],
                        [NSValue valueWithCGPoint:CGPointMake(176.5, 299.5)],nil];
  
  NSArray *Dropoff = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(149, 182)],
                      [NSValue valueWithCGPoint:CGPointMake(148, 190)],
                      [NSValue valueWithCGPoint:CGPointMake(147, 200)],
                      [NSValue valueWithCGPoint:CGPointMake(144, 211)],
                      [NSValue valueWithCGPoint:CGPointMake(142, 221)],
                      [NSValue valueWithCGPoint:CGPointMake(141, 232)],
                      [NSValue valueWithCGPoint:CGPointMake(144, 241)],
                      [NSValue valueWithCGPoint:CGPointMake(153, 249)],
                      [NSValue valueWithCGPoint:CGPointMake(154, 259)],
                      [NSValue valueWithCGPoint:CGPointMake(155, 268)],
                      [NSValue valueWithCGPoint:CGPointMake(160, 279)],
                      [NSValue valueWithCGPoint:CGPointMake(168, 292)],
                      [NSValue valueWithCGPoint:CGPointMake(173, 301)],nil];
  
  NSArray *Woodchuck = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(123.5, 249.5)],
                      [NSValue valueWithCGPoint:CGPointMake(128.5, 252.5)],
                      [NSValue valueWithCGPoint:CGPointMake(132.5, 257.5)],
                      [NSValue valueWithCGPoint:CGPointMake(128.5, 252.5)],
                      [NSValue valueWithCGPoint:CGPointMake(132.5, 257.5)],
                      [NSValue valueWithCGPoint:CGPointMake(136.5, 261.5)],
                      [NSValue valueWithCGPoint:CGPointMake(142.5, 267.5)],
                      [NSValue valueWithCGPoint:CGPointMake(147.5, 272.5)],
                      [NSValue valueWithCGPoint:CGPointMake(154.5, 275.5)],
                      [NSValue valueWithCGPoint:CGPointMake(160.5, 281.5)],nil];
  
  NSArray *Loggersloop = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(142, 185)],
                      [NSValue valueWithCGPoint:CGPointMake(136.5, 193)],
                      [NSValue valueWithCGPoint:CGPointMake(130, 201)],
                      [NSValue valueWithCGPoint:CGPointMake(124, 207)],
                      [NSValue valueWithCGPoint:CGPointMake(121.5, 215)],
                      [NSValue valueWithCGPoint:CGPointMake(122, 223)],
                      [NSValue valueWithCGPoint:CGPointMake(122, 232)],
                      [NSValue valueWithCGPoint:CGPointMake(122, 240)],
                      [NSValue valueWithCGPoint:CGPointMake(117, 248)],
                      [NSValue valueWithCGPoint:CGPointMake(109, 255)],
                      [NSValue valueWithCGPoint:CGPointMake(102, 261)],
                      [NSValue valueWithCGPoint:CGPointMake(92, 265)],
                      [NSValue valueWithCGPoint:CGPointMake(86.5, 268)],
                      [NSValue valueWithCGPoint:CGPointMake(80, 271)],
                      [NSValue valueWithCGPoint:CGPointMake(80, 279)],
                      [NSValue valueWithCGPoint:CGPointMake(81.5, 288)],
                      [NSValue valueWithCGPoint:CGPointMake(81.5, 293.5)],
                      [NSValue valueWithCGPoint:CGPointMake(85.5, 297.5)],
                      [NSValue valueWithCGPoint:CGPointMake(91.5, 301.5)],
                      [NSValue valueWithCGPoint:CGPointMake(98.5, 305.5)],
                      [NSValue valueWithCGPoint:CGPointMake(107.5, 309.5)],
                      [NSValue valueWithCGPoint:CGPointMake(116.5, 315.5)],
                      [NSValue valueWithCGPoint:CGPointMake(125.5, 319.5)],
                      [NSValue valueWithCGPoint:CGPointMake(133.5, 323.5)],
                      [NSValue valueWithCGPoint:CGPointMake(143.5, 325.5)],
                      [NSValue valueWithCGPoint:CGPointMake(154.5, 330.5)],nil];
  
  NSArray *Catsface = [[NSArray alloc] initWithObjects: //Cat's face
                        [NSValue valueWithCGPoint:CGPointMake(96.5, 271)],
                        [NSValue valueWithCGPoint:CGPointMake(93.5, 275)],
                        [NSValue valueWithCGPoint:CGPointMake(89.5, 280)],
                        [NSValue valueWithCGPoint:CGPointMake(87.5, 286)],
                        [NSValue valueWithCGPoint:CGPointMake(88.5, 291)],
                        [NSValue valueWithCGPoint:CGPointMake(88.5, 294)],nil];
  
  NSArray *Thewoods = [[NSArray alloc] initWithObjects:
                          [NSValue valueWithCGPoint:CGPointMake(57, 349)],
                          [NSValue valueWithCGPoint:CGPointMake(52, 356)],
                          [NSValue valueWithCGPoint:CGPointMake(48, 366)],
                          [NSValue valueWithCGPoint:CGPointMake(45, 372)],
                          [NSValue valueWithCGPoint:CGPointMake(43, 377)],
                          [NSValue valueWithCGPoint:CGPointMake(46, 385)],
                          [NSValue valueWithCGPoint:CGPointMake(50, 388)],
                          [NSValue valueWithCGPoint:CGPointMake(53, 391)],
                          [NSValue valueWithCGPoint:CGPointMake(52, 398)],
                          [NSValue valueWithCGPoint:CGPointMake(49, 403)],
                          [NSValue valueWithCGPoint:CGPointMake(48, 406)],
                          [NSValue valueWithCGPoint:CGPointMake(47, 413)],
                          [NSValue valueWithCGPoint:CGPointMake(45, 417)],
                          [NSValue valueWithCGPoint:CGPointMake(43, 423)],
                          [NSValue valueWithCGPoint:CGPointMake(47, 432)],
                          [NSValue valueWithCGPoint:CGPointMake(50, 438)],
                          [NSValue valueWithCGPoint:CGPointMake(55, 443)],
                          [NSValue valueWithCGPoint:CGPointMake(60, 448)],
                          [NSValue valueWithCGPoint:CGPointMake(65, 453)],
                          [NSValue valueWithCGPoint:CGPointMake(72, 464)],nil];
  NSArray *Condorun = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(90, 420)],
                       [NSValue valueWithCGPoint:CGPointMake(84, 429)],
                       [NSValue valueWithCGPoint:CGPointMake(81, 437)],
                       [NSValue valueWithCGPoint:CGPointMake(77, 442)],
                       [NSValue valueWithCGPoint:CGPointMake(73, 448)],
                       [NSValue valueWithCGPoint:CGPointMake(69, 454)],
                       [NSValue valueWithCGPoint:CGPointMake(67, 459)],nil];
  NSArray *Villagerun = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(130, 383.5)],
                       [NSValue valueWithCGPoint:CGPointMake(125, 385.5)],
                       [NSValue valueWithCGPoint:CGPointMake(121, 388.5)],
                       [NSValue valueWithCGPoint:CGPointMake(113, 392.5)],
                       [NSValue valueWithCGPoint:CGPointMake(104, 397)],
                       [NSValue valueWithCGPoint:CGPointMake(99, 402.5)],
                       [NSValue valueWithCGPoint:CGPointMake(91, 409.5)],
                       [NSValue valueWithCGPoint:CGPointMake(87, 412)],
                       [NSValue valueWithCGPoint:CGPointMake(84.5, 415.5)],nil];
  NSArray *Coyotefork = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(150, 417.5)],
                         [NSValue valueWithCGPoint:CGPointMake(144, 417.5)],
                         [NSValue valueWithCGPoint:CGPointMake(138, 419.5)],
                         [NSValue valueWithCGPoint:CGPointMake(132, 423.5)],
                         [NSValue valueWithCGPoint:CGPointMake(125, 429.5)],
                         [NSValue valueWithCGPoint:CGPointMake(120, 433.5)],
                         [NSValue valueWithCGPoint:CGPointMake(115, 438.5)],
                         [NSValue valueWithCGPoint:CGPointMake(113, 440.5)],
                         [NSValue valueWithCGPoint:CGPointMake(115, 445.5)],
                         [NSValue valueWithCGPoint:CGPointMake(117, 453.5)],nil];
  NSArray *Homerun = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(163, 424)],
                       [NSValue valueWithCGPoint:CGPointMake(168.5, 417.5)],
                       [NSValue valueWithCGPoint:CGPointMake(176.5, 414.5)],
                       [NSValue valueWithCGPoint:CGPointMake(184.5, 408.5)],
                       [NSValue valueWithCGPoint:CGPointMake(192.5, 405.5)],
                       [NSValue valueWithCGPoint:CGPointMake(201.5, 400.5)],
                       [NSValue valueWithCGPoint:CGPointMake(208.5, 395.5)],
                       [NSValue valueWithCGPoint:CGPointMake(217.5, 390.5)],
                       [NSValue valueWithCGPoint:CGPointMake(225.5, 386.5)],
                       [NSValue valueWithCGPoint:CGPointMake(230.5, 377.5)],
                       [NSValue valueWithCGPoint:CGPointMake(233.5, 369.5)],
                       [NSValue valueWithCGPoint:CGPointMake(242.5, 367.5)],
                       [NSValue valueWithCGPoint:CGPointMake(251.5, 362.5)],
                       [NSValue valueWithCGPoint:CGPointMake(256.5, 352.5)],
                       [NSValue valueWithCGPoint:CGPointMake(260.5, 341.5)],
                       [NSValue valueWithCGPoint:CGPointMake(267.5, 335.5)],
                       [NSValue valueWithCGPoint:CGPointMake(276.5, 323.5)],
                       [NSValue valueWithCGPoint:CGPointMake(281.5, 322.5)],
                       [NSValue valueWithCGPoint:CGPointMake(288.5, 318.5)],
                       [NSValue valueWithCGPoint:CGPointMake(295.5, 315.5)],nil];
  
  
//  NSArray *theGulch = [[NSArray alloc] initWithObjects:
//                       [NSValue valueWithCGPoint:CGPointMake()],
//                       [NSValue valueWithCGPoint:CGPointMake()],
//                       [NSValue valueWithCGPoint:CGPointMake()],
//                       [NSValue valueWithCGPoint:CGPointMake()],
//                       [NSValue valueWithCGPoint:CGPointMake()],
//                       [NSValue valueWithCGPoint:CGPointMake()],
//                       [NSValue valueWithCGPoint:CGPointMake()],
//                       [NSValue valueWithCGPoint:CGPointMake()],
//                       [NSValue valueWithCGPoint:CGPointMake()],
//                       [NSValue valueWithCGPoint:CGPointMake()],
//                       [NSValue valueWithCGPoint:CGPointMake()],nil];

  NSMutableArray *pointsArray = [NSMutableArray new];
  [pointsArray addObject:Loggersloop];
  [pointsArray addObject:Homerun];
  [pointsArray addObject:Coyotefork];
  [pointsArray addObject:Villagerun];
  [pointsArray addObject:Condorun];
  [pointsArray addObject:Thewoods];
  [pointsArray addObject:Catsface];
  [pointsArray addObject:Woodchuck];
  [pointsArray addObject:Moonshine];
  [pointsArray addObject:Pipeline];
  [pointsArray addObject:Dropoff];
  [pointsArray addObject:Thestairs];
  [pointsArray addObject:Pinball];
  [pointsArray addObject:Forerunner];
  [pointsArray addObject:Sidewinder];
  [pointsArray addObject:Magicmoglus];
  [pointsArray addObject:Skidtrail];
  [pointsArray addObject:lumberJack];
  [pointsArray addObject:lowerMainStreet];
  [pointsArray addObject:theGulch];
  
  return pointsArray;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//  NSLog(@"innitWithNibName");
//  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//  if (self) {
//    // Custom initialization
//    self.zoomed = NO;
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//  }
//  return self;
//}


- (id)initWithMap:(UIImage*) map
{
  self = [super init];
  if (self) {
    self.map = map;
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

  self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (self.map.size.width*(self.view.bounds.size.height/self.map.size.height)), self.view.bounds.size.height)];
//  self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, (self.view.bounds.size.height * image.size.height / image.size.width))];

  NSLog(@"imageview width is %f, height is %f", self.imageView.bounds.size.width, self.imageView.bounds.size.height);
  self.imageView.image = self.map;
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
  
  self.scrollView.minimumZoomScale=1;
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
  [self.scrollView addGestureRecognizer:tapOnce];
  [self.scrollView addGestureRecognizer:tapTwice];
  [self drawNavigationInputs];
  
  self.trailPath = [[trailPathView alloc] initWithFrame:self.imageView.bounds];
  self.trailPath.dataSource = self;
  [self.imageView addSubview:self.trailPath];
  self.trailOn = YES;
  
}

- (void)drawNavigationInputs
{
  UIImage *background = [UIImage imageNamed:@"mapbutton_bg"];
  UIImageView *bgView = [[UIImageView alloc] initWithImage:background];
  UIView *buttons = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-10-background.size.width, 30, background.size.width+10, background.size.height+10)];
  [buttons addSubview:bgView];
  [buttons sendSubviewToBack:bgView];
  UIImage *zoomOut = [UIImage imageNamed:@"exitfullscreen_button"];
//  UIImage *zoomOut = [UIImage imageNamed:@"fullscreen_button"];
  UIButton *homeView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, zoomOut.size.width, zoomOut.size.height)];
  homeView.center = CGPointMake(background.size.width/2, background.size.height/3.9);
  [homeView addTarget:self action:@selector(homeAction:) forControlEvents:UIControlEventTouchUpInside];
  [homeView setBackgroundImage:zoomOut forState:UIControlStateNormal];
  [buttons addSubview:homeView];
  
  UIImage *switchImage = [UIImage imageNamed:@"viewHighlight_button"];
  UIButton *viewSwitch = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, switchImage.size.width, switchImage.size.height)];
  viewSwitch.center = CGPointMake(background.size.width/2, background.size.height/2 + background.size.height/3.9);
  [viewSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
  [viewSwitch setBackgroundImage:switchImage forState:UIControlStateNormal];
  [buttons addSubview:viewSwitch];
  [self.view addSubview: buttons];
  
}

-(void)switchAction:(id)sender
{
  self.trailPath.hidden = self.trailOn;
  self.trailOn = !self.trailOn;
//  if (self.trailOn) {
//    self.trailPath.hidden = YES;
//    self.trailOn = NO;
//  }
}
-(void)homeAction:(id)sender
{
   [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)tapOnce:(UIGestureRecognizer *)gesture
{
  NSLog(@"point is %f, %f", [gesture locationInView:gesture.view].x, [gesture locationInView:gesture.view].y);
  
//  //step 1: find where is being touched
//  CGPoint point = [gesture locationInView:self.scrollView];
//  //step 2: create a top left point
//  point = CGPointMake(point.x - self.scrollView.bounds.size.height/2, point.y - self.scrollView.bounds.size.width/2);
//  //step 3: create a rect using that point
//  CGRect rect = CGRectMake(point.x, point.y, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
//  //on a single  tap, call zoomToRect in UIScrollView
//  [self.scrollView zoomToRect:rect animated:YES];
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
  NSLog(@"point is %f, %f", [recognizer locationInView:recognizer.view].x, [recognizer locationInView:recognizer.view].y);
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
