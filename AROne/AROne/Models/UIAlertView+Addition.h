//
//  UIAlertView+Addition.h
//  AROne
//
//  Created by Chenchen Zheng on 10/22/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Addition)

- (void)showWithCompletion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completion;

@end
