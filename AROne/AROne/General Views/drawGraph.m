//
//  drawGraph.m
//  AROne
//
//  Created by Jerry Wu on 10/2/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "drawGraph.h"
#import <QuartzCore/QuartzCore.h>

@implementation drawGraph
{
  CGPoint _touchPoint;
  CGFloat _myVolume;
}

- (void)drawRect:(CGRect)rect
{
  if ([self.data count] == 0) {
    return;
  }

  if(self.isVolumeGraph)
    [self drawVolumeDataInRect:self.bounds];
  else
    [self pathFromDataInRect:self.bounds];

}

#pragma mark - Background Gradient

/*****************************************************************************************************
 *************************************volume graph****************************************************
 ****************************************************************************************************/
- (void)drawVolumeDataInRect:(CGRect)volumeGraphRect {
  CGFloat maxVolume =  [[self.data valueForKeyPath:@"@max.self"] floatValue];
  CGFloat minVolume = [[self.data valueForKeyPath:@"@min.self"] floatValue];
//  CGFloat verticalScale = CGRectGetHeight(volumeGraphRect) / (maxVolume - minVolume);
  
//  NSArray *array = [self.dataSource graphViewData];
  NSInteger count = [self.data count];
  
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGContextSaveGState(ctx);
  CGFloat lineSpacing = rint(CGRectGetWidth(volumeGraphRect) / (count + 1));
  [[UIColor whiteColor] setStroke];
  
  for (int i = 0; i < count; i++) {
    UIBezierPath *path = [UIBezierPath new];
    if (lineSpacing > 10) {
      [path setLineWidth:10.0];
    } else [path setLineWidth:lineSpacing];
    CGFloat dataPoint = [[self.data objectAtIndex:i] floatValue];
    if (maxVolume != minVolume) {
      [path moveToPoint:CGPointMake((i+1)*lineSpacing, CGRectGetHeight(volumeGraphRect) - minVolume)];
      [path addLineToPoint:CGPointMake((i+1)*lineSpacing, CGRectGetHeight(volumeGraphRect)*dataPoint/(maxVolume-minVolume))];
    }
    [self.localColor setStroke];
    [path stroke];
  }
  CGContextRestoreGState(ctx);
}

/*****************************************************************************************************
 *************************************line graph******************************************************
 ****************************************************************************************************/
- (UIBezierPath *)pathFromDataInRect:(CGRect)rect {
  
  CGFloat max = [[self.data valueForKeyPath:@"@max.self"] floatValue];;
  CGFloat min = [[self.data valueForKeyPath:@"@min.self"] floatValue];
  
  UIBezierPath *path = [UIBezierPath bezierPath];
  /*
   Even though this lineWidth is odd, we don't do any offset because it will never line up with any pixels, just think geometrically.
   */
  
  CGFloat lineWidth = 3.0;
  [path setLineWidth:lineWidth];
  [path setLineJoinStyle:kCGLineJoinMiter];
  [path setLineCapStyle:kCGLineCapRound];
    [path setMiterLimit:-10];
  // Inset so the path does not ever go beyond the frame of the graph.
  rect = CGRectInset(rect, lineWidth / 2.0, lineWidth);
  CGFloat horizontalSpacing = (CGRectGetWidth(rect) / (CGFloat)[self.data count]);
  CGFloat verticalScale = CGRectGetHeight(rect) / (max - min);
  CGFloat dataPoint = [[self.data objectAtIndex:0] floatValue];
  CGPoint initialDataPoint = CGPointMake(lineWidth / 2.0, (dataPoint - min) * verticalScale);
  [path moveToPoint:initialDataPoint];
  
  for(NSUInteger i = 1; i < [self.data count] - 1; i++) {
    dataPoint = [[self.data objectAtIndex:i] doubleValue];
    [path addLineToPoint:CGPointMake((i + 1) * horizontalSpacing, CGRectGetMinY(rect) + (max - dataPoint) * verticalScale)];
  }
  
  dataPoint = [[self.data lastObject] floatValue];
  [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + (dataPoint - min) * verticalScale)];
  [self.localColor setStroke];

  [path stroke];

  return path;
}
  
  
@end
