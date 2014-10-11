//
//  trailPathView.m
//  TrailSummary
//
//  Created by Chenchen Zheng on 1/16/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "trailPathView.h"

@implementation trailPathView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

    // Drawing code
//    [self drawPathInRect:self.bounds From:CGPointMake(100, 100) To:CGPointMake(500, 500)];
    
  NSArray *data = [self.dataSource trailPathViewData:self];
  for (NSArray *points in data) {
    [self drawPathInRect:self.bounds data:points];
  }
}


- (UIBezierPath *)drawPathInRect:(CGRect)rect From:(CGPoint)start To:(CGPoint)end
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat lineWidth = 10.0;
    [path setLineWidth:lineWidth];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    // Inset so that path does not ever go beyond the frame of the graph.
    rect = CGRectInset(rect, lineWidth / 2.0, lineWidth);
    [path moveToPoint:start];
    [path addLineToPoint:end];
    [[UIColor whiteColor] setStroke];
    [path stroke];
    
    return path;
}

- (UIBezierPath *)drawPathInRect:(CGRect)rect data:(NSArray *)data
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat lineWidth = 5.0;
    [path setLineWidth:lineWidth];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    // Inset so that path does not ever go beyond the frame of the graph.
    rect = CGRectInset(rect, lineWidth / 2.0, lineWidth);
    NSValue *val = [data objectAtIndex:0];
//    CGPoint p = [val CGPointValue];
//    [path moveToPoint:p];
  int count = 0;
  CGPoint pts[5];
  pts[0] = [[data objectAtIndex:0] CGPointValue];
  [path moveToPoint:pts[0]];
    for (int i = 1; i < [data count]; i++) {
//        val = [data objectAtIndex:i];
//        p = [val CGPointValue];
//        [path addLineToPoint:p];
      count++;
      val = [data objectAtIndex:i];
      pts[count] = [val CGPointValue];
      if (count == 4) {
        pts[3] = CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0); // move the endpoint to the middle of the line joining the second control point of the first Bezier segment and the first control point of the second Bezier segment
        [path moveToPoint:pts[0]];
        [path addCurveToPoint:pts[3] controlPoint1:pts[1] controlPoint2:pts[2]]; // add a cubic Bezier from pt[0] to pt[3], with control points pt[1] and pt[2]
        [self setNeedsDisplay];
        // replace points and get ready to handle the next segment
        pts[0] = pts[3];
        pts[1] = pts[4];
        count = 1;
      }
    }
  
    [[UIColor colorWithRed:0 green:0 blue:102/255.0 alpha:0.6] setStroke];
    [path stroke];
    
    return path;
}

@end
