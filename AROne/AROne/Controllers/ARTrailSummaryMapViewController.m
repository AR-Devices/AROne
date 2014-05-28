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
  NSArray *Theglades = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(229, 416.5)],
                       [NSValue valueWithCGPoint:CGPointMake(228, 421.5)],
                       [NSValue valueWithCGPoint:CGPointMake(230, 426.5)],
                       [NSValue valueWithCGPoint:CGPointMake(233, 430.5)],
                       [NSValue valueWithCGPoint:CGPointMake(236, 434.5)],
                       [NSValue valueWithCGPoint:CGPointMake(241, 437.5)],
                       [NSValue valueWithCGPoint:CGPointMake(244, 441.5)],
                       [NSValue valueWithCGPoint:CGPointMake(249, 447.5)],nil];
  
  NSArray *Timberline = [[NSArray alloc] initWithObjects:
                        [NSValue valueWithCGPoint:CGPointMake(243.5, 427.5)],
                        [NSValue valueWithCGPoint:CGPointMake(241.5, 420)],
                        [NSValue valueWithCGPoint:CGPointMake(240.5, 416.5)],
                        [NSValue valueWithCGPoint:CGPointMake(235.5, 409.5)],
                        [NSValue valueWithCGPoint:CGPointMake(232.5, 405.5)],
                        [NSValue valueWithCGPoint:CGPointMake(229.5, 403.5)],
                        [NSValue valueWithCGPoint:CGPointMake(227.5, 378.5)],
                        [NSValue valueWithCGPoint:CGPointMake(225.5, 370.5)],
                        [NSValue valueWithCGPoint:CGPointMake(225.5, 365.5)],nil];
  NSArray *Woodcutter = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(187, 357)],
                         [NSValue valueWithCGPoint:CGPointMake(191, 355.5)],
                         [NSValue valueWithCGPoint:CGPointMake(195, 355.5)],
                         [NSValue valueWithCGPoint:CGPointMake(201, 354.5)],
                         [NSValue valueWithCGPoint:CGPointMake(206, 352.5)],
                         [NSValue valueWithCGPoint:CGPointMake(211, 351.5)],
                         [NSValue valueWithCGPoint:CGPointMake(215, 349.5)],
                         [NSValue valueWithCGPoint:CGPointMake(221, 348.5)],
                         [NSValue valueWithCGPoint:CGPointMake(224, 348.5)],nil];
  
  NSArray *Easystreet = [[NSArray alloc] initWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(212.5, 336.5)],
                         [NSValue valueWithCGPoint:CGPointMake(219.5, 340.5)],
                         [NSValue valueWithCGPoint:CGPointMake(224.5, 346.5)],
                         [NSValue valueWithCGPoint:CGPointMake(227.5, 353.5)],
                         [NSValue valueWithCGPoint:CGPointMake(228.5, 356.5)],
                         [NSValue valueWithCGPoint:CGPointMake(229.5, 362.5)],nil];
  NSArray *Hornetsnest = [[NSArray alloc] initWithObjects:  //    Black Hornet's nest
                         [NSValue valueWithCGPoint:CGPointMake(122.5, 270)],
                         [NSValue valueWithCGPoint:CGPointMake(125.5, 275)],
                         [NSValue valueWithCGPoint:CGPointMake(127.5, 285)],
                         [NSValue valueWithCGPoint:CGPointMake(129.5, 293)],
                         [NSValue valueWithCGPoint:CGPointMake(130.5, 298)],
                         [NSValue valueWithCGPoint:CGPointMake(130.5, 304)],
                         [NSValue valueWithCGPoint:CGPointMake(130.5, 310)],
                         [NSValue valueWithCGPoint:CGPointMake(130.5, 310)],
                         [NSValue valueWithCGPoint:CGPointMake(130.5, 320)],nil];
  NSArray *Surprise = [[NSArray alloc] initWithObjects:  //    Black Hornet's nest
                          [NSValue valueWithCGPoint:CGPointMake(136.5, 281.5)],
                          [NSValue valueWithCGPoint:CGPointMake(138.5, 286.5)],
                          [NSValue valueWithCGPoint:CGPointMake(139.5, 291.5)],
                          [NSValue valueWithCGPoint:CGPointMake(139.5, 297.5)],
                          [NSValue valueWithCGPoint:CGPointMake(141.4, 304.5)],
                          [NSValue valueWithCGPoint:CGPointMake(143.5, 314.5)],
                          [NSValue valueWithCGPoint:CGPointMake(145.5, 317.5)],
                          [NSValue valueWithCGPoint:CGPointMake(147.5, 320.5)],nil];
  NSArray *Lowerlionswy = [[NSArray alloc] initWithObjects:  //    Green
                       [NSValue valueWithCGPoint:CGPointMake(253.5, 356)],
                       [NSValue valueWithCGPoint:CGPointMake(249.5, 359)],
                       [NSValue valueWithCGPoint:CGPointMake(243.5, 363)],
                       [NSValue valueWithCGPoint:CGPointMake(237.5, 365)],
                       [NSValue valueWithCGPoint:CGPointMake(232.5, 365)],
                       [NSValue valueWithCGPoint:CGPointMake(225.5, 367)],
                       [NSValue valueWithCGPoint:CGPointMake(219.5, 367)],
                       [NSValue valueWithCGPoint:CGPointMake(214.5, 365)],nil];
  NSArray *Upperlionswy = [[NSArray alloc] initWithObjects:  //    Blue
                           [NSValue valueWithCGPoint:CGPointMake(260.5, 322.5)],
                           [NSValue valueWithCGPoint:CGPointMake(259.5, 328.5)],
                           [NSValue valueWithCGPoint:CGPointMake(257.5, 334.5)],
                           [NSValue valueWithCGPoint:CGPointMake(257.5, 339.5)],
                           [NSValue valueWithCGPoint:CGPointMake(256.6, 343.5)],
                           [NSValue valueWithCGPoint:CGPointMake(254.5, 348.5)],
                           [NSValue valueWithCGPoint:CGPointMake(253.5, 351.5)],
                           [NSValue valueWithCGPoint:CGPointMake(251.5, 355.5)],
                           [NSValue valueWithCGPoint:CGPointMake(249.5, 358.5)],nil];
  NSArray *Eastridge = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(356.5, 57)],
                      [NSValue valueWithCGPoint:CGPointMake(347.5, 59)],
                      [NSValue valueWithCGPoint:CGPointMake(339.5, 62)],
                      [NSValue valueWithCGPoint:CGPointMake(330.5, 63)],
                      [NSValue valueWithCGPoint:CGPointMake(315, 68)],
                      [NSValue valueWithCGPoint:CGPointMake(304, 71)],
                      [NSValue valueWithCGPoint:CGPointMake(294, 76)],
                      [NSValue valueWithCGPoint:CGPointMake(284, 80)],
                      [NSValue valueWithCGPoint:CGPointMake(270, 83)],
                      [NSValue valueWithCGPoint:CGPointMake(263, 88)],
                      [NSValue valueWithCGPoint:CGPointMake(251, 91)],
                      [NSValue valueWithCGPoint:CGPointMake(236, 94)],
                      [NSValue valueWithCGPoint:CGPointMake(206, 103)],
                      [NSValue valueWithCGPoint:CGPointMake(197, 107)],
                      [NSValue valueWithCGPoint:CGPointMake(188, 111)],
                      [NSValue valueWithCGPoint:CGPointMake(180, 117)],
                      [NSValue valueWithCGPoint:CGPointMake(177, 123)],
                      [NSValue valueWithCGPoint:CGPointMake(177, 128)],nil];
  
  NSArray *Delight = [[NSArray alloc] initWithObjects:  //    Black
                           [NSValue valueWithCGPoint:CGPointMake(187.5, 123.5)],
                           [NSValue valueWithCGPoint:CGPointMake(187.5, 126)],
                           [NSValue valueWithCGPoint:CGPointMake(187.5, 130)],
                           [NSValue valueWithCGPoint:CGPointMake(187.5, 130.5)],
                           [NSValue valueWithCGPoint:CGPointMake(187.5, 140)],
                           [NSValue valueWithCGPoint:CGPointMake(187.5, 143)],
                           [NSValue valueWithCGPoint:CGPointMake(187.5, 149)],
                           [NSValue valueWithCGPoint:CGPointMake(187.5, 154.5)],nil];
  NSArray *Dutchman = [[NSArray alloc] initWithObjects:  //    Black
                      [NSValue valueWithCGPoint:CGPointMake(207.5, 113.5)],
                      [NSValue valueWithCGPoint:CGPointMake(208.5, 118.5)],
                      [NSValue valueWithCGPoint:CGPointMake(209.5, 125.5)],
                      [NSValue valueWithCGPoint:CGPointMake(210.5, 128.5)],
                      [NSValue valueWithCGPoint:CGPointMake(211.5, 132.5)],
                      [NSValue valueWithCGPoint:CGPointMake(211.5, 136.5)],
                      [NSValue valueWithCGPoint:CGPointMake(213.5, 139.5)],
                      [NSValue valueWithCGPoint:CGPointMake(214.5, 146.5)],
                      [NSValue valueWithCGPoint:CGPointMake(216.5, 149.5)],nil];
  NSArray *Thechute = [[NSArray alloc] initWithObjects:  //    Black
                       [NSValue valueWithCGPoint:CGPointMake(236, 114.5)],
                       [NSValue valueWithCGPoint:CGPointMake(238, 117.5)],
                       [NSValue valueWithCGPoint:CGPointMake(241, 124.5)],
                       [NSValue valueWithCGPoint:CGPointMake(242, 130.5)],
                       [NSValue valueWithCGPoint:CGPointMake(243, 136.5)],
                       [NSValue valueWithCGPoint:CGPointMake(242, 141.5)],
                       [NSValue valueWithCGPoint:CGPointMake(242, 145.5)],
                       [NSValue valueWithCGPoint:CGPointMake(243, 150.5)],nil];
  NSArray *Toninis = [[NSArray alloc] initWithObjects:  //    Black
                       [NSValue valueWithCGPoint:CGPointMake(265.5, 106.5)],
                       [NSValue valueWithCGPoint:CGPointMake(267.5, 116.5)],
                       [NSValue valueWithCGPoint:CGPointMake(267.5, 124.5)],
                       [NSValue valueWithCGPoint:CGPointMake(266.5, 129.5)],
                       [NSValue valueWithCGPoint:CGPointMake(266.5, 136.5)],
                       [NSValue valueWithCGPoint:CGPointMake(267.5, 141.5)],
                       [NSValue valueWithCGPoint:CGPointMake(267.5, 146.5)],nil];
  NSArray *Crosscut = [[NSArray alloc] initWithObjects:  //    Black
                      [NSValue valueWithCGPoint:CGPointMake(294, 95.5)],
                      [NSValue valueWithCGPoint:CGPointMake(295, 101.5)],
                      [NSValue valueWithCGPoint:CGPointMake(295, 105.5)],
                      [NSValue valueWithCGPoint:CGPointMake(295, 114.5)],
                      [NSValue valueWithCGPoint:CGPointMake(294, 118.5)],
                      [NSValue valueWithCGPoint:CGPointMake(292, 122.5)],
                      [NSValue valueWithCGPoint:CGPointMake(289, 127.5)],
                      [NSValue valueWithCGPoint:CGPointMake(288, 133.5)],nil];
  NSArray *Rendezvousglade = [[NSArray alloc] initWithObjects:  //    Black
                       [NSValue valueWithCGPoint:CGPointMake(296.5, 83)],
                       [NSValue valueWithCGPoint:CGPointMake(298.5, 87)],
                       [NSValue valueWithCGPoint:CGPointMake(299.5, 90)],
                       [NSValue valueWithCGPoint:CGPointMake(300.5, 93)],
                       [NSValue valueWithCGPoint:CGPointMake(302.5, 100)],
                       [NSValue valueWithCGPoint:CGPointMake(301.5, 105.5)],
                       [NSValue valueWithCGPoint:CGPointMake(301.5, 110.5)],
                       [NSValue valueWithCGPoint:CGPointMake(299.5, 116.5)],
                       [NSValue valueWithCGPoint:CGPointMake(298.5, 122.5)],
                       [NSValue valueWithCGPoint:CGPointMake(295.5, 129.5)],
                       [NSValue valueWithCGPoint:CGPointMake(292.5, 133.5)],
                       [NSValue valueWithCGPoint:CGPointMake(289.5, 139.5)],
                       [NSValue valueWithCGPoint:CGPointMake(285.5, 146.5)],
                       [NSValue valueWithCGPoint:CGPointMake(284.5, 151.5)],nil];
  NSArray *Theflume = [[NSArray alloc] initWithObjects:  //    Blue
                       [NSValue valueWithCGPoint:CGPointMake(309, 89)],
                       [NSValue valueWithCGPoint:CGPointMake(316, 92)],
                       [NSValue valueWithCGPoint:CGPointMake(322, 94)],
                       [NSValue valueWithCGPoint:CGPointMake(329, 95)],
                       [NSValue valueWithCGPoint:CGPointMake(336, 96)],
                       [NSValue valueWithCGPoint:CGPointMake(341, 98)],
                       [NSValue valueWithCGPoint:CGPointMake(345, 98)],
                       [NSValue valueWithCGPoint:CGPointMake(349, 98)],nil];
  NSArray *Powderbowl = [[NSArray alloc] initWithObjects:  //    Black
                       [NSValue valueWithCGPoint:CGPointMake(323, 73.5)],
                       [NSValue valueWithCGPoint:CGPointMake(323, 81.5)],
                       [NSValue valueWithCGPoint:CGPointMake(321, 93.5)],
                       [NSValue valueWithCGPoint:CGPointMake(321, 99.5)],
                       [NSValue valueWithCGPoint:CGPointMake(317, 107.5)],
                       [NSValue valueWithCGPoint:CGPointMake(314, 115.5)],
                       [NSValue valueWithCGPoint:CGPointMake(311, 121.5)],
                       [NSValue valueWithCGPoint:CGPointMake(308, 125.5)],
                       [NSValue valueWithCGPoint:CGPointMake(306, 130.5)],
                       [NSValue valueWithCGPoint:CGPointMake(303, 134.5)],nil];
  NSArray *Powderbowlblue = [[NSArray alloc] initWithObjects:  //    Blue     // Same name, blue and black "Powder bowl"
                         [NSValue valueWithCGPoint:CGPointMake(309.5, 126)],
                         [NSValue valueWithCGPoint:CGPointMake(305.5, 130)],
                         [NSValue valueWithCGPoint:CGPointMake(299.5, 136)],
                         [NSValue valueWithCGPoint:CGPointMake(295.5, 140)],
                         [NSValue valueWithCGPoint:CGPointMake(291.5, 146)],
                         [NSValue valueWithCGPoint:CGPointMake(287.5, 154)],
                         [NSValue valueWithCGPoint:CGPointMake(282.5, 160)],
                         [NSValue valueWithCGPoint:CGPointMake(279.5, 165)],
                         [NSValue valueWithCGPoint:CGPointMake(277.5, 171)],nil];
  NSArray *Uppergrousealley = [[NSArray alloc] initWithObjects:  //    Black
                         [NSValue valueWithCGPoint:CGPointMake(369.6, 61)],
                         [NSValue valueWithCGPoint:CGPointMake(367.5, 67)],
                         [NSValue valueWithCGPoint:CGPointMake(364.5, 72)],
                         [NSValue valueWithCGPoint:CGPointMake(361.5, 78)],
                         [NSValue valueWithCGPoint:CGPointMake(356.5, 85)],
                         [NSValue valueWithCGPoint:CGPointMake(351.5, 92)],
                         [NSValue valueWithCGPoint:CGPointMake(348.5, 97)],
                         [NSValue valueWithCGPoint:CGPointMake(343.5, 102)],
                         [NSValue valueWithCGPoint:CGPointMake(339.5, 105)],
                         [NSValue valueWithCGPoint:CGPointMake(335.5, 107)],
                         [NSValue valueWithCGPoint:CGPointMake(330.5, 111)],
                         [NSValue valueWithCGPoint:CGPointMake(327.5, 116)],nil];
  NSArray *Lowergrousealley = [[NSArray alloc] initWithObjects:  //    Blue
                               [NSValue valueWithCGPoint:CGPointMake(332.5, 110)],
                               [NSValue valueWithCGPoint:CGPointMake(329.5, 114)],
                               [NSValue valueWithCGPoint:CGPointMake(326.5, 118)],
                               [NSValue valueWithCGPoint:CGPointMake(324.5, 120)],
                               [NSValue valueWithCGPoint:CGPointMake(320.5, 125)],
                               [NSValue valueWithCGPoint:CGPointMake(317.5, 130)],
                               [NSValue valueWithCGPoint:CGPointMake(314.5, 134)],
                               [NSValue valueWithCGPoint:CGPointMake(310.5, 138)],
                               [NSValue valueWithCGPoint:CGPointMake(307.5, 144)],
                               [NSValue valueWithCGPoint:CGPointMake(305.5, 147)],
                               [NSValue valueWithCGPoint:CGPointMake(301.5, 152)],
                               [NSValue valueWithCGPoint:CGPointMake(296.5, 160)],nil];
  
  NSArray *Axhandle = [[NSArray alloc] initWithObjects:  //    Blue
                               [NSValue valueWithCGPoint:CGPointMake(375, 114)],
                               [NSValue valueWithCGPoint:CGPointMake(368, 116)],
                               [NSValue valueWithCGPoint:CGPointMake(361, 120)],
                               [NSValue valueWithCGPoint:CGPointMake(355, 123.5)],
                               [NSValue valueWithCGPoint:CGPointMake(346, 130)],
                               [NSValue valueWithCGPoint:CGPointMake(342, 132)],
                               [NSValue valueWithCGPoint:CGPointMake(336, 134)],
                               [NSValue valueWithCGPoint:CGPointMake(331, 138)],
                               [NSValue valueWithCGPoint:CGPointMake(325, 143)],
                               [NSValue valueWithCGPoint:CGPointMake(320, 148)],
                               [NSValue valueWithCGPoint:CGPointMake(314, 151)],
                               [NSValue valueWithCGPoint:CGPointMake(309, 155)],
                               [NSValue valueWithCGPoint:CGPointMake(302, 159)],
                               [NSValue valueWithCGPoint:CGPointMake(297, 163)],
                               [NSValue valueWithCGPoint:CGPointMake(294, 167)],
                               [NSValue valueWithCGPoint:CGPointMake(291, 169)],
                               [NSValue valueWithCGPoint:CGPointMake(287, 173)],
                               [NSValue valueWithCGPoint:CGPointMake(286, 175)],
                               [NSValue valueWithCGPoint:CGPointMake(284, 178)],
                               [NSValue valueWithCGPoint:CGPointMake(283, 183)],
                               [NSValue valueWithCGPoint:CGPointMake(283, 186)],nil];
  NSArray *Cascades = [[NSArray alloc] initWithObjects:  //    Blue
                       [NSValue valueWithCGPoint:CGPointMake(276.5, 208)],
                       [NSValue valueWithCGPoint:CGPointMake(273.5, 214)],
                       [NSValue valueWithCGPoint:CGPointMake(269.5, 220)],
                       [NSValue valueWithCGPoint:CGPointMake(268.5, 223)],
                       [NSValue valueWithCGPoint:CGPointMake(264.5, 230)],
                       [NSValue valueWithCGPoint:CGPointMake(262.5, 232)],
                       [NSValue valueWithCGPoint:CGPointMake(260.5, 236)],
                       [NSValue valueWithCGPoint:CGPointMake(259.5, 238)],
                       [NSValue valueWithCGPoint:CGPointMake(257.5, 241)],nil];
  NSArray *Uppermainstreet = [[NSArray alloc] initWithObjects:  //    Blue
                       [NSValue valueWithCGPoint:CGPointMake(249.5, 250)],
                       [NSValue valueWithCGPoint:CGPointMake(245.5, 255)],
                       [NSValue valueWithCGPoint:CGPointMake(242.5, 260)],
                       [NSValue valueWithCGPoint:CGPointMake(239.5, 265)],
                       [NSValue valueWithCGPoint:CGPointMake(234.5, 271)],
                       [NSValue valueWithCGPoint:CGPointMake(230.5, 275)],
                       [NSValue valueWithCGPoint:CGPointMake(227.5, 280)],
                       [NSValue valueWithCGPoint:CGPointMake(223.5, 282)],
                       [NSValue valueWithCGPoint:CGPointMake(221.5, 285)],
                       [NSValue valueWithCGPoint:CGPointMake(218.5, 287)],nil];
  NSArray *Corridor = [[NSArray alloc] initWithObjects:  //    Black
                              [NSValue valueWithCGPoint:CGPointMake(370.5, 71.5)],
                              [NSValue valueWithCGPoint:CGPointMake(368.5, 75.5)],
                              [NSValue valueWithCGPoint:CGPointMake(366.5, 79.5)],
                              [NSValue valueWithCGPoint:CGPointMake(363.5, 82.5)],
                              [NSValue valueWithCGPoint:CGPointMake(361.5, 85.5)],
                              [NSValue valueWithCGPoint:CGPointMake(359.5, 89.5)],
                              [NSValue valueWithCGPoint:CGPointMake(357.5, 92.5)],
                              [NSValue valueWithCGPoint:CGPointMake(355.5, 95.5)],
                              [NSValue valueWithCGPoint:CGPointMake(353.5, 98.5)],
                              [NSValue valueWithCGPoint:CGPointMake(352.5, 100.5)],nil];
  NSArray *Theplunge = [[NSArray alloc] initWithObjects:  //    Black
                       [NSValue valueWithCGPoint:CGPointMake(379.5, 71)],
                       [NSValue valueWithCGPoint:CGPointMake(376.5, 77)],
                       [NSValue valueWithCGPoint:CGPointMake(373.5, 80.5)],
                       [NSValue valueWithCGPoint:CGPointMake(370.5, 84.5)],
                       [NSValue valueWithCGPoint:CGPointMake(368.5, 88.5)],
                       [NSValue valueWithCGPoint:CGPointMake(363.5, 94.5)],
                       [NSValue valueWithCGPoint:CGPointMake(361.5, 98.5)],
                       [NSValue valueWithCGPoint:CGPointMake(358.5, 100.5)],
                       [NSValue valueWithCGPoint:CGPointMake(355.5, 107.5)],nil];
  
  NSArray *Springboard = [[NSArray alloc] initWithObjects:  //    Black
                        [NSValue valueWithCGPoint:CGPointMake(385.5, 95.5)],
                        [NSValue valueWithCGPoint:CGPointMake(380.5, 98.5)],
                        [NSValue valueWithCGPoint:CGPointMake(375.5, 102.5)],
                        [NSValue valueWithCGPoint:CGPointMake(371.5, 106.5)],
                        [NSValue valueWithCGPoint:CGPointMake(368.5, 108.5)],
                        [NSValue valueWithCGPoint:CGPointMake(365.5, 110.5)],
                        [NSValue valueWithCGPoint:CGPointMake(361.5, 113.5)],
                        [NSValue valueWithCGPoint:CGPointMake(355.5, 114.5)],
                        [NSValue valueWithCGPoint:CGPointMake(352.5, 116.5)],
                        [NSValue valueWithCGPoint:CGPointMake(348, 117.5)],nil];
  NSArray *Stumpalley = [[NSArray alloc] initWithObjects:  //    Blue
                         [NSValue valueWithCGPoint:CGPointMake(362.5, 135.5)],
                         [NSValue valueWithCGPoint:CGPointMake(354.4, 138.5)],
                         [NSValue valueWithCGPoint:CGPointMake(349.5, 142.5)],
                         [NSValue valueWithCGPoint:CGPointMake(346.5, 145.5)],
                         [NSValue valueWithCGPoint:CGPointMake(343.5, 148.5)],
                         [NSValue valueWithCGPoint:CGPointMake(337.5, 151.5)],
                         [NSValue valueWithCGPoint:CGPointMake(333.5, 155.5)],
                         [NSValue valueWithCGPoint:CGPointMake(330.5, 159.5)],
                         [NSValue valueWithCGPoint:CGPointMake(323.5, 162)],nil];
  
  NSArray *Luggis = [[NSArray alloc] initWithObjects:  //    Blue
                         [NSValue valueWithCGPoint:CGPointMake(340.5, 162)],
                         [NSValue valueWithCGPoint:CGPointMake(334.5, 165)],
                         [NSValue valueWithCGPoint:CGPointMake(328.5, 167)],
                         [NSValue valueWithCGPoint:CGPointMake(323.5, 171)],
                         [NSValue valueWithCGPoint:CGPointMake(318.5, 172)],
                         [NSValue valueWithCGPoint:CGPointMake(313.5, 174)],
                         [NSValue valueWithCGPoint:CGPointMake(310.5, 175)],nil];
  NSArray *Goldmine = [[NSArray alloc] initWithObjects:  //    Blue
                     [NSValue valueWithCGPoint:CGPointMake(297, 196.5)],
                     [NSValue valueWithCGPoint:CGPointMake(301, 198)],
                     [NSValue valueWithCGPoint:CGPointMake(304, 199)],
                     [NSValue valueWithCGPoint:CGPointMake(309, 201)],
                     [NSValue valueWithCGPoint:CGPointMake(314, 202)],
                     [NSValue valueWithCGPoint:CGPointMake(319, 204)],
                     [NSValue valueWithCGPoint:CGPointMake(323, 205)],
                     [NSValue valueWithCGPoint:CGPointMake(326, 205)],
                     [NSValue valueWithCGPoint:CGPointMake(330, 206)],nil];
  
  NSArray *Bibboom = [[NSArray alloc] initWithObjects:  //    Black
                       [NSValue valueWithCGPoint:CGPointMake(309.5, 214)],
                       [NSValue valueWithCGPoint:CGPointMake(302.5, 217)],
                       [NSValue valueWithCGPoint:CGPointMake(297.5, 220)],
                       [NSValue valueWithCGPoint:CGPointMake(293.5, 225)],
                       [NSValue valueWithCGPoint:CGPointMake(289.5, 226)],
                       [NSValue valueWithCGPoint:CGPointMake(286, 229)],
                       [NSValue valueWithCGPoint:CGPointMake(279, 233)],
                       [NSValue valueWithCGPoint:CGPointMake(275, 235)],
                       [NSValue valueWithCGPoint:CGPointMake(268, 239)],nil];
  
  NSArray *Sodergrens = [[NSArray alloc] initWithObjects:  //    Blue
                      [NSValue valueWithCGPoint:CGPointMake(261.5, 275.5)],
                      [NSValue valueWithCGPoint:CGPointMake(265.5, 273.5)],
                      [NSValue valueWithCGPoint:CGPointMake(271.5, 268.5)],
                      [NSValue valueWithCGPoint:CGPointMake(276.5, 262.5)],
                      [NSValue valueWithCGPoint:CGPointMake(281.5, 259.5)],
                      [NSValue valueWithCGPoint:CGPointMake(286.5, 255.5)],
                      [NSValue valueWithCGPoint:CGPointMake(290.5, 253.5)],
                      [NSValue valueWithCGPoint:CGPointMake(292.5, 248.5)],
                      [NSValue valueWithCGPoint:CGPointMake(298.5, 248.5)],nil];
  
  NSArray *Christmastree = [[NSArray alloc] initWithObjects:  //    Blue
                         [NSValue valueWithCGPoint:CGPointMake(319.5, 237)],
                         [NSValue valueWithCGPoint:CGPointMake(313.5, 239)],
                         [NSValue valueWithCGPoint:CGPointMake(307.5, 241)],
                         [NSValue valueWithCGPoint:CGPointMake(302.5, 242)],
                         [NSValue valueWithCGPoint:CGPointMake(296.5, 242)],
                         [NSValue valueWithCGPoint:CGPointMake(291.5, 243)],
                         [NSValue valueWithCGPoint:CGPointMake(283.5, 245)],
                         [NSValue valueWithCGPoint:CGPointMake(278.5, 246)],
                         [NSValue valueWithCGPoint:CGPointMake(273.5, 247)],
                         [NSValue valueWithCGPoint:CGPointMake(269.5, 247)],
                         [NSValue valueWithCGPoint:CGPointMake(264.5, 247)],nil];
  
  NSArray *Thestash = [[NSArray alloc] initWithObjects:  //    Blue
                            [NSValue valueWithCGPoint:CGPointMake(287.5, 294)],
                            [NSValue valueWithCGPoint:CGPointMake(281.5, 295)],
                            [NSValue valueWithCGPoint:CGPointMake(275.5, 299)],
                            [NSValue valueWithCGPoint:CGPointMake(269.5, 301)],
                            [NSValue valueWithCGPoint:CGPointMake(261.5, 304)],
                            [NSValue valueWithCGPoint:CGPointMake(257.5, 305)],
                            [NSValue valueWithCGPoint:CGPointMake(253.5, 307)],
                            [NSValue valueWithCGPoint:CGPointMake(250.5, 308)],nil];
  
  NSArray *Hootowl = [[NSArray alloc] initWithObjects:  //    Blue
                       [NSValue valueWithCGPoint:CGPointMake(304.5, 294)],
                       [NSValue valueWithCGPoint:CGPointMake(300.5, 296)],
                       [NSValue valueWithCGPoint:CGPointMake(297.5, 297)],
                       [NSValue valueWithCGPoint:CGPointMake(293.5, 299)],
                       [NSValue valueWithCGPoint:CGPointMake(288.5, 302)],
                       [NSValue valueWithCGPoint:CGPointMake(285.5, 302)],
                       [NSValue valueWithCGPoint:CGPointMake(280.5, 305)],
                       [NSValue valueWithCGPoint:CGPointMake(274.5, 307)],
                       [NSValue valueWithCGPoint:CGPointMake(270.5, 308)],nil];
  
  NSArray *Lowerpionner = [[NSArray alloc] initWithObjects:  //    Blue
                      [NSValue valueWithCGPoint:CGPointMake(306, 300)],
                      [NSValue valueWithCGPoint:CGPointMake(295.5, 305)],
                      [NSValue valueWithCGPoint:CGPointMake(288.5, 307)],
                      [NSValue valueWithCGPoint:CGPointMake(283.5, 310)],
                      [NSValue valueWithCGPoint:CGPointMake(278, 312)],
                      [NSValue valueWithCGPoint:CGPointMake(273, 314)],
                      [NSValue valueWithCGPoint:CGPointMake(269, 317)],
                      [NSValue valueWithCGPoint:CGPointMake(265, 319)],nil];
  
  NSArray *Upperpionner = [[NSArray alloc] initWithObjects:  //    Blue
                           [NSValue valueWithCGPoint:CGPointMake(351.5, 244.5)],
                           [NSValue valueWithCGPoint:CGPointMake(349.5, 248.5)],
                           [NSValue valueWithCGPoint:CGPointMake(347.5, 252.5)],
                           [NSValue valueWithCGPoint:CGPointMake(343.5, 257.5)],
                           [NSValue valueWithCGPoint:CGPointMake(342.5, 260.5)],
                           [NSValue valueWithCGPoint:CGPointMake(340.5, 264.5)],
                           [NSValue valueWithCGPoint:CGPointMake(335.5, 269.5)],
                           [NSValue valueWithCGPoint:CGPointMake(331.5, 275.5)],
                           [NSValue valueWithCGPoint:CGPointMake(328.5, 280.5)],
                           [NSValue valueWithCGPoint:CGPointMake(323.5, 285.5)],
                           [NSValue valueWithCGPoint:CGPointMake(320.5, 287.5)],nil];
  
  NSArray *Thegully = [[NSArray alloc] initWithObjects:  //    Blue
                           [NSValue valueWithCGPoint:CGPointMake(321, 264.5)],
                           [NSValue valueWithCGPoint:CGPointMake(317, 267.5)],
                           [NSValue valueWithCGPoint:CGPointMake(312, 270.5)],
                           [NSValue valueWithCGPoint:CGPointMake(308, 272.5)],
                           [NSValue valueWithCGPoint:CGPointMake(303, 275.5)],
                           [NSValue valueWithCGPoint:CGPointMake(296, 278.5)],
                           [NSValue valueWithCGPoint:CGPointMake(292, 279.5)],
                           [NSValue valueWithCGPoint:CGPointMake(288, 280.5)],
                           [NSValue valueWithCGPoint:CGPointMake(284, 280.5)],
                           [NSValue valueWithCGPoint:CGPointMake(280, 282.5)],nil];
  
  NSArray *Boondocks = [[NSArray alloc] initWithObjects:  //    Blue
                           [NSValue valueWithCGPoint:CGPointMake(380.5, 273.5)],
                           [NSValue valueWithCGPoint:CGPointMake(375.5, 275.5)],
                           [NSValue valueWithCGPoint:CGPointMake(371.5, 277.5)],
                           [NSValue valueWithCGPoint:CGPointMake(369.5, 279.5)],
                           [NSValue valueWithCGPoint:CGPointMake(365.5, 281.5)],
                           [NSValue valueWithCGPoint:CGPointMake(358.5, 284.5)],
                           [NSValue valueWithCGPoint:CGPointMake(353.5, 287.5)],
                           [NSValue valueWithCGPoint:CGPointMake(345.5, 291.5)],
                           [NSValue valueWithCGPoint:CGPointMake(335.5, 296.5)],
                           [NSValue valueWithCGPoint:CGPointMake(326.5, 300.5)],
                           [NSValue valueWithCGPoint:CGPointMake(318.5, 302.5)],
                           [NSValue valueWithCGPoint:CGPointMake(312.5, 306.5)],
                           [NSValue valueWithCGPoint:CGPointMake(302.5, 310.5)],
                           [NSValue valueWithCGPoint:CGPointMake(295.5, 314.5)],
                           [NSValue valueWithCGPoint:CGPointMake(293.5, 317.5)],
                           [NSValue valueWithCGPoint:CGPointMake(289.5, 320.5)],
                           [NSValue valueWithCGPoint:CGPointMake(285.5, 323.5)],nil];
  
  NSArray *Overlandtrail = [[NSArray alloc] initWithObjects:  //    Blue
                       [NSValue valueWithCGPoint:CGPointMake(262.5, 359.5)],
                       [NSValue valueWithCGPoint:CGPointMake(271.5, 359)],
                       [NSValue valueWithCGPoint:CGPointMake(274.5, 357.5)],
                       [NSValue valueWithCGPoint:CGPointMake(283.5, 360.5)],
                       [NSValue valueWithCGPoint:CGPointMake(289.5, 362)],nil];
  
  NSArray *Northernlights = [[NSArray alloc] initWithObjects:  //    Blue
                        [NSValue valueWithCGPoint:CGPointMake(342, 217)],
                        [NSValue valueWithCGPoint:CGPointMake(334, 221)],
                        [NSValue valueWithCGPoint:CGPointMake(328, 223)],
                        [NSValue valueWithCGPoint:CGPointMake(319, 228)],
                        [NSValue valueWithCGPoint:CGPointMake(314, 230)],
                        [NSValue valueWithCGPoint:CGPointMake(310, 232)],
                        [NSValue valueWithCGPoint:CGPointMake(306, 234)],
                        [NSValue valueWithCGPoint:CGPointMake(302, 236)],
                        [NSValue valueWithCGPoint:CGPointMake(297, 238)],nil];
  
  NSArray *Flyingsqurrel = [[NSArray alloc] initWithObjects:  //    Black
                             [NSValue valueWithCGPoint:CGPointMake(340, 198.5)],
                             [NSValue valueWithCGPoint:CGPointMake(335, 203.5)],
                             [NSValue valueWithCGPoint:CGPointMake(330, 207.5)],
                             [NSValue valueWithCGPoint:CGPointMake(327, 210.5)],
                             [NSValue valueWithCGPoint:CGPointMake(324, 213.5)],
                             [NSValue valueWithCGPoint:CGPointMake(320, 216.5)],
                             [NSValue valueWithCGPoint:CGPointMake(316, 220.5)],
                             [NSValue valueWithCGPoint:CGPointMake(309, 223.5)],
                             [NSValue valueWithCGPoint:CGPointMake(305, 226.5)],
                             [NSValue valueWithCGPoint:CGPointMake(300, 228.5)],
                             [NSValue valueWithCGPoint:CGPointMake(295, 230.5)],nil];
  
  NSArray *Lookoutroad = [[NSArray alloc] initWithObjects:  //    Blue
                            [NSValue valueWithCGPoint:CGPointMake(360.5, 173.5)],
                            [NSValue valueWithCGPoint:CGPointMake(363.5, 177.5)],
                            [NSValue valueWithCGPoint:CGPointMake(364.5, 181.5)],
                            [NSValue valueWithCGPoint:CGPointMake(365.5, 184.5)],
                            [NSValue valueWithCGPoint:CGPointMake(367.5, 189.5)],
                            [NSValue valueWithCGPoint:CGPointMake(368.5, 192.5)],
                            [NSValue valueWithCGPoint:CGPointMake(368.5, 197.5)],
                            [NSValue valueWithCGPoint:CGPointMake(369.5, 200.5)],nil];
  
  NSArray *Cowboypass = [[NSArray alloc] initWithObjects:  //    Black
                          [NSValue valueWithCGPoint:CGPointMake(333.5, 213)],
                          [NSValue valueWithCGPoint:CGPointMake(337.5, 211)],
                          [NSValue valueWithCGPoint:CGPointMake(343.5, 209)],
                          [NSValue valueWithCGPoint:CGPointMake(348.5, 207)],
                          [NSValue valueWithCGPoint:CGPointMake(354.5, 204)],
                          [NSValue valueWithCGPoint:CGPointMake(360.5, 202)],
                          [NSValue valueWithCGPoint:CGPointMake(365.5, 197)],
                          [NSValue valueWithCGPoint:CGPointMake(368.5, 195)],nil];
  
  NSArray *Upperjibboom = [[NSArray alloc] initWithObjects:  //    Blue
                         [NSValue valueWithCGPoint:CGPointMake(353, 172)],
                         [NSValue valueWithCGPoint:CGPointMake(348, 176)],
                         [NSValue valueWithCGPoint:CGPointMake(341, 179)],
                         [NSValue valueWithCGPoint:CGPointMake(336, 183)],
                         [NSValue valueWithCGPoint:CGPointMake(332, 188)],
                         [NSValue valueWithCGPoint:CGPointMake(329, 191)],
                         [NSValue valueWithCGPoint:CGPointMake(325, 194)],
                         [NSValue valueWithCGPoint:CGPointMake(322, 196)],
                         [NSValue valueWithCGPoint:CGPointMake(320, 198)],
                         [NSValue valueWithCGPoint:CGPointMake(318, 200)],
                         [NSValue valueWithCGPoint:CGPointMake(315, 203)],nil];
  
  NSArray *Comstockglade = [[NSArray alloc] initWithObjects:  //    Black
                           [NSValue valueWithCGPoint:CGPointMake(355.5, 161)],
                           [NSValue valueWithCGPoint:CGPointMake(349.5, 163)],
                           [NSValue valueWithCGPoint:CGPointMake(345.5, 166)],
                           [NSValue valueWithCGPoint:CGPointMake(340.5, 169)],
                           [NSValue valueWithCGPoint:CGPointMake(336.5, 171)],
                           [NSValue valueWithCGPoint:CGPointMake(332.5, 174)],
                           [NSValue valueWithCGPoint:CGPointMake(328.5, 177)],
                           [NSValue valueWithCGPoint:CGPointMake(326.5, 179)],
                           [NSValue valueWithCGPoint:CGPointMake(322.5, 180)],
                           [NSValue valueWithCGPoint:CGPointMake(320.5, 183)],
                           [NSValue valueWithCGPoint:CGPointMake(317.5, 185)],
                           [NSValue valueWithCGPoint:CGPointMake(315.5, 188)],
                           [NSValue valueWithCGPoint:CGPointMake(313.5, 190)],
                           [NSValue valueWithCGPoint:CGPointMake(311.5, 192)],nil];
  NSArray *Westridge = [[NSArray alloc] initWithObjects:  //    Blue
                            [NSValue valueWithCGPoint:CGPointMake(380, 127)],
                            [NSValue valueWithCGPoint:CGPointMake(375, 130)],
                            [NSValue valueWithCGPoint:CGPointMake(372, 135)],
                            [NSValue valueWithCGPoint:CGPointMake(370, 139)],
                            [NSValue valueWithCGPoint:CGPointMake(368, 143)],
                            [NSValue valueWithCGPoint:CGPointMake(364, 148)],
                            [NSValue valueWithCGPoint:CGPointMake(361, 153)],
                            [NSValue valueWithCGPoint:CGPointMake(359, 157)],
                            [NSValue valueWithCGPoint:CGPointMake(359, 159)],nil];
  
  NSArray *Lookoutbypass = [[NSArray alloc] initWithObjects:  //    Blue
                            [NSValue valueWithCGPoint:CGPointMake(362, 251)],
                            [NSValue valueWithCGPoint:CGPointMake(361, 258)],
                            [NSValue valueWithCGPoint:CGPointMake(357, 267)],
                            [NSValue valueWithCGPoint:CGPointMake(355, 273)],
                            [NSValue valueWithCGPoint:CGPointMake(352, 278)],
                            [NSValue valueWithCGPoint:CGPointMake(348, 286)],
                            [NSValue valueWithCGPoint:CGPointMake(343, 292)],
                            [NSValue valueWithCGPoint:CGPointMake(334, 300)],
                            [NSValue valueWithCGPoint:CGPointMake(325, 307)],
                            [NSValue valueWithCGPoint:CGPointMake(317, 314)],
                            [NSValue valueWithCGPoint:CGPointMake(308, 323)],
                            [NSValue valueWithCGPoint:CGPointMake(302, 330)],
                            [NSValue valueWithCGPoint:CGPointMake(301, 339)],
                            [NSValue valueWithCGPoint:CGPointMake(304, 352)],
                            [NSValue valueWithCGPoint:CGPointMake(305, 360)],
                            [NSValue valueWithCGPoint:CGPointMake(309, 367)],
                            [NSValue valueWithCGPoint:CGPointMake(314, 372)],
                            [NSValue valueWithCGPoint:CGPointMake(321, 376)],
                            [NSValue valueWithCGPoint:CGPointMake(328, 379)],
                            [NSValue valueWithCGPoint:CGPointMake(334, 381)],nil];
  
  NSArray *Drifterconnector = [[NSArray alloc] initWithObjects:  //    Blue
                            [NSValue valueWithCGPoint:CGPointMake(375.5, 146)],
                            [NSValue valueWithCGPoint:CGPointMake(375.5, 151)],
                            [NSValue valueWithCGPoint:CGPointMake(374.5, 157)],
                            [NSValue valueWithCGPoint:CGPointMake(376.5, 163)],
                            [NSValue valueWithCGPoint:CGPointMake(375.5, 170)],
                            [NSValue valueWithCGPoint:CGPointMake(377.5, 182)],
                            [NSValue valueWithCGPoint:CGPointMake(379.5, 190)],
                            [NSValue valueWithCGPoint:CGPointMake(380.5, 195)],
                            [NSValue valueWithCGPoint:CGPointMake(382.5, 200)],
                            [NSValue valueWithCGPoint:CGPointMake(383.5, 205)],
                            [NSValue valueWithCGPoint:CGPointMake(388.5, 208)],
                            [NSValue valueWithCGPoint:CGPointMake(377.5, 166)],nil];
  
  NSArray *Theface = [[NSArray alloc] initWithObjects:  //    Black
                               [NSValue valueWithCGPoint:CGPointMake(382, 250.5)],
                               [NSValue valueWithCGPoint:CGPointMake(377, 255.5)],
                               [NSValue valueWithCGPoint:CGPointMake(374, 257.5)],
                               [NSValue valueWithCGPoint:CGPointMake(369, 259)],
                               [NSValue valueWithCGPoint:CGPointMake(365, 261)],
                               [NSValue valueWithCGPoint:CGPointMake(362, 262)],
                               [NSValue valueWithCGPoint:CGPointMake(358, 266)],nil];
  
  NSArray *Sierragrande = [[NSArray alloc] initWithObjects:  //    Black
                      [NSValue valueWithCGPoint:CGPointMake(422, 44)],
                      [NSValue valueWithCGPoint:CGPointMake(429, 44)],
                      [NSValue valueWithCGPoint:CGPointMake(436, 45)],
                      [NSValue valueWithCGPoint:CGPointMake(445, 47)],
                      [NSValue valueWithCGPoint:CGPointMake(452.5, 49)],
                      [NSValue valueWithCGPoint:CGPointMake(459.5, 50)],
                      [NSValue valueWithCGPoint:CGPointMake(466.6, 53)],
                      [NSValue valueWithCGPoint:CGPointMake(471.5, 57)],
                           [NSValue valueWithCGPoint:CGPointMake(474.500000, 61.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(479.500000, 66.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(483.500000, 69.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(490.500000, 72.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(493.500000, 74.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(496.500000, 78.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(501.500000, 83.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(506.500000, 88.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(511.500000, 94.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(516.500000, 101.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(522.500000, 108.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(527.500000, 111.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(531.500000, 116.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(538.500000, 120.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(543.500000, 123.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(551.500000, 128.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(558.500000, 134.500000)],
                           [NSValue valueWithCGPoint:CGPointMake(563.500000, 138.500000)],nil];
  
  NSArray *Challenger = [[NSArray alloc] initWithObjects:  //    Black
                         [NSValue valueWithCGPoint:CGPointMake(508.000000, 72.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(514.000000, 76.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(518.000000, 81.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(524.000000, 85.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(531.000000, 89.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(544.000000, 93.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(551.000000, 96.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(550.500000, 98.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(561.500000, 101.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(569.500000, 105.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(578.500000, 107.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(585.500000, 110.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(592.500000, 110.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(600.500000, 113.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(609.500000, 116.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(613.500000, 118.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(620.500000, 121.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(624.500000, 124.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(620.500000, 131.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(615.500000, 135.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(611.500000, 140.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(607.500000, 143.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(603.500000, 146.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(599.500000, 149.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(596.500000, 153.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(593.500000, 156.500000)],nil];
  
  NSArray *Followme = [[NSArray alloc] initWithObjects:  //    Black
                         [NSValue valueWithCGPoint:CGPointMake(563.500000, 113.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(566.500000, 119.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(569.500000, 125.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(571.500000, 131.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(575.500000, 137.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(578.500000, 143.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(580.500000, 148.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(583.500000, 152.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(587.500000, 155.500000)],nil];
  
  NSArray *Railspiltter = [[NSArray alloc] initWithObjects:  //    Black
                         [NSValue valueWithCGPoint:CGPointMake(438.000000, 56.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(442.000000, 60.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(448.500000, 64.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(454.500000, 69.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(461.500000, 73.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(466.500000, 79.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(474.500000, 82.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(482.500000, 88.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(491.500000, 95.000000)],
                         [NSValue valueWithCGPoint:CGPointMake(495.500000, 98.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(501.500000, 103.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(506.500000, 107.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(513.500000, 113.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(520.500000, 118.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(527.500000, 123.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(536.500000, 128.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(543.500000, 132.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(550.500000, 137.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(560.500000, 142.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(569.500000, 147.500000)],
                         [NSValue valueWithCGPoint:CGPointMake(579.500000, 151.500000)],nil];
  
  NSArray *Monumentglade = [[NSArray alloc] initWithObjects:  //    Black
                           [NSValue valueWithCGPoint:CGPointMake(454.500000, 82.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(460.500000, 87.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(468.500000, 92.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(474.500000, 98.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(483.500000, 104.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(489.500000, 109.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(497.500000, 115.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(506.500000, 122.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(514.500000, 127.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(522.500000, 133.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(529.500000, 139.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(539.500000, 146.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(548.500000, 150.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(560.500000, 158.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(566.500000, 164.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(573.500000, 169.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(579.500000, 173.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(586.500000, 176.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(589.500000, 182.000000)],
                           [NSValue valueWithCGPoint:CGPointMake(591.500000, 187.000000)],nil];
  
  NSArray *Burnout = [[NSArray alloc] initWithObjects:  //    Black
                            [NSValue valueWithCGPoint:CGPointMake(410.500000, 59.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(417.500000, 65.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(427.500000, 71.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(437.500000, 81.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(444.500000, 85.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(451.500000, 91.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(459.500000, 98.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(467.500000, 105.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(475.500000, 111.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(482.500000, 117.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(490.500000, 123.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(497.500000, 130.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(504.500000, 135.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(510.500000, 140.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(516.500000, 145.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(523.500000, 151.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(531.500000, 156.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(537.500000, 161.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(544.500000, 165.000000)],
                            [NSValue valueWithCGPoint:CGPointMake(549.500000, 170.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(556.500000, 174.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(562.500000, 178.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(570.500000, 185.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(576.500000, 187.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(582.500000, 192.000000)],nil];
  
  
  NSArray *Therapids = [[NSArray alloc] initWithObjects:  //    Black
                      [NSValue valueWithCGPoint:CGPointMake(409.000000, 66.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(414.000000, 71.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(418.000000, 75.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(423.000000, 81.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(429.000000, 86.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(435.000000, 93.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(440.000000, 98.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(446.000000, 103.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(452.000000, 109.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(458.000000, 117.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(465.000000, 124.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(472.000000, 131.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(478.000000, 139.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(485.000000, 147.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(492.000000, 155.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(499.000000, 162.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(507.000000, 172.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(516.000000, 181.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(521.000000, 187.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(528.000000, 194.00000)],
                      [NSValue valueWithCGPoint:CGPointMake(536.000000, 202.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(547.000000, 212.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(561.000000, 224.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(569.000000, 236.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(581.000000, 243.000000)],
                      [NSValue valueWithCGPoint:CGPointMake(591.000000, 250.000000)],nil];
  
  
  NSArray *Polaris = [[NSArray alloc] initWithObjects:  //    Black
                        [NSValue valueWithCGPoint:CGPointMake(404.500000, 77.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(408.500000, 82.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(418.500000, 92.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(425.500000, 99.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(429.000000, 86.000000)],
                        [NSValue valueWithCGPoint:CGPointMake(431.500000, 103.50000)],
                        [NSValue valueWithCGPoint:CGPointMake(437.500000, 111.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(443.500000, 117.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(448.500000, 121.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(455.500000, 133.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(461.500000, 138.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(467.500000, 146.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(472.500000, 153.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(476.500000, 160.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(482.500000, 169.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(488.500000, 174.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(495.500000, 180.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(501.500000, 186.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(508.500000, 191.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(512.500000, 196.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(518.500000, 199.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(526.500000, 204.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(533.500000, 210.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(539.500000, 215.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(543.500000, 219.500000)],
                        [NSValue valueWithCGPoint:CGPointMake(550.500000, 225.500000)],
                      [NSValue valueWithCGPoint:CGPointMake(554.500000, 230.500000)],
                      [NSValue valueWithCGPoint:CGPointMake(561.500000, 237.500000)],
                      [NSValue valueWithCGPoint:CGPointMake(569.500000, 244.500000)],
                      [NSValue valueWithCGPoint:CGPointMake(577.500000, 251.500000)],
                      [NSValue valueWithCGPoint:CGPointMake(587.500000, 257.500000)],
                      [NSValue valueWithCGPoint:CGPointMake(595.500000, 258.500000)],nil];
  


  NSMutableArray *pointsArray = [NSMutableArray new];
  [pointsArray addObject:Hornetsnest];
  [pointsArray addObject:Polaris];
  [pointsArray addObject:Therapids];
  [pointsArray addObject:Burnout];
  [pointsArray addObject:Monumentglade];
  [pointsArray addObject:Railspiltter];
  [pointsArray addObject:Followme];
  [pointsArray addObject:Challenger];
  [pointsArray addObject:Sierragrande];
  [pointsArray addObject:Theface];
  [pointsArray addObject:Drifterconnector];
  [pointsArray addObject:Lookoutbypass];
  [pointsArray addObject:Westridge];
  [pointsArray addObject:Upperjibboom];
  [pointsArray addObject:Comstockglade];
  [pointsArray addObject:Cowboypass];
  [pointsArray addObject:Lookoutroad];
  [pointsArray addObject:Flyingsqurrel];
  [pointsArray addObject:Northernlights];
  [pointsArray addObject:Overlandtrail];
  [pointsArray addObject:Boondocks];
  [pointsArray addObject:Lowerpionner];
  [pointsArray addObject:Thestash];
  [pointsArray addObject:Thegully];
  [pointsArray addObject:Upperpionner];
  [pointsArray addObject:Hootowl];
  [pointsArray addObject:Christmastree];
  [pointsArray addObject:Sodergrens];
  [pointsArray addObject:Goldmine];
  [pointsArray addObject:Luggis];
  [pointsArray addObject:Bibboom];
  [pointsArray addObject:Stumpalley];
  [pointsArray addObject:Springboard];
  [pointsArray addObject:Theplunge];
  [pointsArray addObject:Corridor];
  [pointsArray addObject:Cascades];
  [pointsArray addObject:Uppermainstreet];
  [pointsArray addObject:Axhandle];
  [pointsArray addObject:Uppergrousealley];
  [pointsArray addObject:Lowergrousealley];
  [pointsArray addObject:Powderbowlblue];
  [pointsArray addObject:Powderbowl];
  [pointsArray addObject:Theflume];
  [pointsArray addObject:Rendezvousglade];
  [pointsArray addObject:Crosscut];
  [pointsArray addObject:Toninis];
  [pointsArray addObject:Thechute];
  [pointsArray addObject:Dutchman];
  [pointsArray addObject:Delight];
  [pointsArray addObject:Eastridge];
  [pointsArray addObject:Upperlionswy];
  [pointsArray addObject:Lowerlionswy];
  [pointsArray addObject:Surprise];
  [pointsArray addObject:Loggersloop];
  [pointsArray addObject:Easystreet];
  [pointsArray addObject:Woodcutter];
  [pointsArray addObject:Timberline];
  [pointsArray addObject:Theglades];
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
