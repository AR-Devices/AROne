//
//  ARSummaryTableViewController.h
//  ARTwo
//
//  Created by Chenchen Zheng on 6/7/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MPGTextField.h"

@interface ARSummaryTableViewController : UITableViewController <UITextFieldDelegate, MPGTextFieldDelegate>{
  NSMutableArray *data;
}
@property (nonatomic) MPGTextField *search_name;

@end
