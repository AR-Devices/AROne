//
//  ARSummaryFunctionGraphTouchView.m
//  AROne
//
//  Created by Jerry Wu on 10/8/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "ARSummaryGraphTouchView.h"
#import "drawGraph.h"

@implementation ARSummaryGraphTouchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
  UIColor *purpleColor   = [UIColor colorWithRed:161/255.0f green:138/255.0f blue:193/255.0f alpha:1];
  UIColor *neonblueColor = [UIColor colorWithRed:47/255.0f green:179/255.0f blue:182/255.0f alpha:1];
  UIColor *orangeColor   = [UIColor colorWithRed:238/255.0f green:150/255.0f blue:47/255.0f alpha:1];
    if (self) {
      drawGraph *myGraph = [[drawGraph alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
      myGraph.isVolumeGraph = FALSE;
      myGraph.localColor = purpleColor;
      myGraph.backgroundColor = [UIColor whiteColor];
      myGraph.useTouch = TRUE;

      [self addSubview:myGraph];

    }
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

@end
