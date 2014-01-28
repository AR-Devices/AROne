//
//  drawGraph.m
//  AROne
//
//  Created by Jerry Wu on 10/2/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "drawGraph.h"
#import <QuartzCore/QuartzCore.h>

@interface drawGraph()
   @property (nonatomic) UITouch * touch;
@end

@implementation drawGraph
{
//  CGGradientRef _backgroundGradient;
  CGPoint _touchPoint;
  CGFloat _myVolume;
  NSMutableArray * speedArray;
}

- (void)drawRect:(CGRect)rect
{
//  this is fake data
  [self createSpeedArray];
  CGRect myRect = [self createRect];

  if(self.isVolumeGraph){
    [self drawVolumeDataInRect:myRect];
  }else{
    [self pathFromDataInRect:myRect];
  }
  if(self.useTouch){
  if(self.touch){
    [self drawLineOnTouch:_touchPoint];
    [self drawDot:myRect touchPoint:_touchPoint];
    [self drawBubble:myRect touchPoint:_touchPoint];
  }
  }
}


- (CGRect)createRect {
  CGFloat height = self.bounds.size.height;
  CGFloat left = 0.0;
  CGFloat right = CGRectGetWidth(self.bounds);
  return CGRectMake(left, 0, right, height);
}

#pragma mark - Background Gradient


/*****************************************************************************************************
 *************************************volume graph****************************************************
 ****************************************************************************************************/
- (void)drawVolumeDataInRect:(CGRect)volumeGraphRect {
  
  CGFloat maxVolume = 10;
  CGFloat minVolume = 1;
  CGFloat verticalScale = CGRectGetHeight(volumeGraphRect) / (maxVolume - minVolume);
  
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGContextSaveGState(ctx);
  CGFloat tradingDayLineSpacing = rint(CGRectGetWidth(volumeGraphRect) / (CGFloat)[speedArray count]);
  CGFloat counter = 0.0;
  CGFloat maxY = CGRectGetMaxY(volumeGraphRect);
  [[UIColor whiteColor] setStroke];
  

  for(NSNumber *speed in speedArray) {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path setLineWidth:10.0];
    
    CGFloat tradingVolume = [speed floatValue];
    [path moveToPoint:CGPointMake(rint(counter * tradingDayLineSpacing), maxY)];
    [path addLineToPoint:CGPointMake(rint(counter * tradingDayLineSpacing), maxY - (tradingVolume - minVolume) * verticalScale + 10)];
    [self.localColor setStroke];
    [path stroke];
    counter += 1.0;
  }
  CGContextRestoreGState(ctx);
}

/*****************************************************************************************************
 *************************************line graph******************************************************
 ****************************************************************************************************/
- (UIBezierPath *)pathFromDataInRect:(CGRect)rect {
  
  CGFloat maxClose = 10;
  CGFloat minClose = 1;
  
  UIBezierPath *path = [UIBezierPath bezierPath];
  /*
   Even though this lineWidth is odd, we don't do any offset because it will never line up with any pixels, just think geometrically.
   */
  
  CGFloat lineWidth = 3.0;
  [path setLineWidth:lineWidth];
  [path setLineJoinStyle:kCGLineJoinRound];
  [path setLineCapStyle:kCGLineCapRound];
  // Inset so the path does not ever go beyond the frame of the graph.
  rect = CGRectInset(rect, lineWidth / 2.0, lineWidth);
  CGFloat horizontalSpacing = (CGRectGetWidth(rect) / (CGFloat)[speedArray count]);
  CGFloat verticalScale = CGRectGetHeight(rect) / (maxClose - minClose);
  CGFloat closingPrice = [[speedArray objectAtIndex:0] doubleValue];
  CGPoint initialDataPoint = CGPointMake(lineWidth / 2.0, (closingPrice - minClose) * verticalScale);
  [path moveToPoint:initialDataPoint];
  
  for(NSUInteger i = 1; i < [speedArray count] - 1; i++) {
    closingPrice = [[speedArray objectAtIndex:i] doubleValue];
    [path addLineToPoint:CGPointMake((i + 1) * horizontalSpacing, CGRectGetMinY(rect) + (closingPrice - minClose) * verticalScale)];
  }
  
  closingPrice = [[speedArray lastObject] doubleValue];
  [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + (closingPrice - minClose) * verticalScale)];
  [self.localColor setStroke];

  [path stroke];

  return path;
}

/*****************************************************************************************************
 *************************************draw line mark**************************************************
 ****************************************************************************************************/
- (void)drawLineOnTouch:(CGPoint)touchPoint {
  UIBezierPath *path = [UIBezierPath bezierPath];
  CGFloat myTouchPointX = touchPoint.x;
//  if(touchPoint.x >= self.tradingDataLimit){
//    myTouchPointX = self.tradingDataLimit;
//  }
  CGPoint start = CGPointMake(myTouchPointX, 20);
  CGPoint end   = CGPointMake(myTouchPointX, 300);
  [[UIColor whiteColor] setStroke];
  [path setLineWidth:1.0];
  [path moveToPoint:start];
  [path addLineToPoint:end];
  [path stroke];
}
/*************************************************************************************************************************************if useTouch:*/
 
/*****************************************************************************************************
 *************************************touch Events****************************************************
 ****************************************************************************************************/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  self.touch = [touches anyObject];
  CGPoint touchPoint = [[touches anyObject] locationInView:self];
  _touchPoint = touchPoint;
  
  [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
  self.touch = [touches anyObject];
  CGPoint touchPoint = [[touches anyObject] locationInView:self];
  _touchPoint = touchPoint;
  
  [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
  self.touch =nil;
  [self setNeedsDisplay];
  [UIView transitionWithView:self duration:0.5
                     options:UIViewAnimationOptionTransitionCrossDissolve
                  animations:^{
                    [self.layer displayIfNeeded];
                  } completion:nil];
}

/*****************************************************************************************************
 *************************************draw a dot ****************************************************
 ****************************************************************************************************/
- (void)drawDot:(CGRect)dataRect touchPoint:(CGPoint)touchPoint{
  CGFloat myTouchPointX = touchPoint.x;
  //  if(touchPoint.x >= self.tradingDataLimit){
  //    myTouchPointX = self.tradingDataLimit;
  //  }
  CGFloat pointY = [self findY:touchPoint rect:dataRect];
  CGPoint myPoint = CGPointMake(myTouchPointX, pointY);
  
  
  
  UIBezierPath *aPath = [UIBezierPath bezierPathWithArcCenter:myPoint
                                                       radius:10
                                                   startAngle:0
                                                     endAngle:360
                                                    clockwise:YES];
  UIBezierPath *bPath = [UIBezierPath bezierPathWithArcCenter:myPoint
                                                       radius:5
                                                   startAngle:0
                                                     endAngle:360
                                                    clockwise:YES];
  [[UIColor redColor] setFill];
  [aPath fill];
  [[UIColor whiteColor] setFill];
  [bPath fill];
}
/*****************************************************************************************************
 *************************************find Y**********************************************************
 ****************************************************************************************************/
- (void)drawBubble:(CGRect)dataRect touchPoint:(CGPoint)touchPoint {
  
  [[UIColor whiteColor] setFill];
  UIFont *font = [UIFont systemFontOfSize:12.0];
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGContextSaveGState(ctx);
  CGFloat myTouchPointX = touchPoint.x;
  //  if(touchPoint.x >= self.tradingDataLimit){
  //    myTouchPointX = self.tradingDataLimit;
  //  }
  CGContextTranslateCTM(ctx, CGRectGetMinX(dataRect), 30.0);
  NSString *bubblelabel = [NSString stringWithFormat: @"$%.2f", _myVolume];
  
  
  CGSize bubblesize = [bubblelabel sizeWithFont:font];
  CGFloat mybubbleWitdth = bubblesize.width +50;
  CGFloat mybubbleHeight = bubblesize.height;
  CGFloat bubbleRectOrigX = 0;
  if((myTouchPointX+0.5*mybubbleWitdth)>= CGRectGetMaxX(dataRect)){
    bubbleRectOrigX = CGRectGetMaxX(dataRect)-mybubbleWitdth;//0.0-(myTouchPointX+0.5*mybubbleWitdth-CGRectGetMaxX(dataRect));
  }else if ((myTouchPointX-0.5*mybubbleWitdth) <= CGRectGetMinX(dataRect)){
    bubbleRectOrigX = CGRectGetMinX(dataRect);
  }else{
    bubbleRectOrigX = myTouchPointX - 0.5*mybubbleWitdth;
  }
  CGRect monthRect = CGRectMake(bubbleRectOrigX, 0.0-mybubbleHeight, mybubbleWitdth, mybubbleHeight);
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:monthRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5.0, 5.0)];
  [path addClip];
  UIRectFill(monthRect);
  [[UIColor blackColor] setFill];
  
//  NSDictionary *dictionary = @{ NSFontAttributeName: font,
//                                NSParagraphStyleAttributeName: paragraphStyle,
//                                NSForegroundColorAttributeName: self.textColor};

  [bubblelabel drawInRect:monthRect withFont:font lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
//  bubblelabel drawInRect:monthRect withAttributes:<#(NSDictionary *)#>
  CGContextRestoreGState(ctx);
  
  
}
/*****************************************************************************************************
 *************************************find Y**********************************************************
 ****************************************************************************************************/
- (CGFloat) findY :(CGPoint)touch rect:(CGRect)rect
{
  CGFloat maxVolume = 10;
  CGFloat minVolume = 1;
  CGFloat verticalScale = CGRectGetHeight(rect) / (maxVolume - minVolume);
  CGFloat tradingDayLineSpacing = rint(CGRectGetWidth(rect) / (CGFloat)[speedArray count]);
//  NSUInteger X = rint(touch.x / tradingDayLineSpacing);
  //  NSLog(@"X is %lu", (unsigned long)X);
  //  CGFloat myTouchPointX = touch.x;
  //  if(touch.x >= self.tradingDataLimit){
  //    myTouchPointX = self.tradingDataLimit;
  //  }
  NSUInteger tradingDays = [speedArray count];
  
  NSUInteger daily = touch.x / tradingDayLineSpacing;
  if(daily >= tradingDays){
    daily = tradingDays-1;
  }
  _myVolume = [[speedArray objectAtIndex: daily] doubleValue];
  CGFloat myPoint = CGRectGetMaxY(rect) - ( CGRectGetMinY(rect) + (_myVolume - minVolume) * verticalScale ) + 10;
  return myPoint;
}
/******************************************************************************************************************************DATA BASE:*/
/*****************************************************************************************************
 *************************************fake data array*************************************************
 ****************************************************************************************************/
- (void) createSpeedArray{
  speedArray = [[NSMutableArray alloc] init];
  [speedArray insertObject:@"1" atIndex:0];
  [speedArray insertObject:@"3" atIndex:1];
  [speedArray insertObject:@"5" atIndex:2];
  [speedArray insertObject:@"6" atIndex:3];
  [speedArray insertObject:@"9" atIndex:4];
  [speedArray insertObject:@"2" atIndex:5];
  [speedArray insertObject:@"4" atIndex:6];
  [speedArray insertObject:@"6" atIndex:7];
  [speedArray insertObject:@"8" atIndex:8];
  [speedArray insertObject:@"10" atIndex:9];
}


  
  
  
@end
