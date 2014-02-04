//
//  ARTopBarView.h
//  AROne
//
//  Created by Chenchen Zheng on 9/9/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ARTopBarViewStyle)
{
//  let's try using block here, to assign three different call back function for three bottons
  ARTopBarViewStyleCalendar, //left, right, and middle click
  ARTopBarViewStyleDWM, //
  ARTopBarViewStyleSelector,
  ARTopBarViewStyleDWMSmall
};
@interface ARTopBarView : UISegmentedControl

- (id)initWithStyle:(ARTopBarViewStyle)style viewBounds:(CGRect)frame withBlock:(void (^)(ARTopBarView *segment))callbackBlock;


@end
