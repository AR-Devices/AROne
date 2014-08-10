//
//  ARRelationshipViewController.h
//  ARTwo
//
//  Created by Colororange on 8/10/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ARRelationshipType){
  Following,
  Followed,
  Friends
};


@interface ARRelationshipViewController : UITableViewController
- (id)initWithStyle:(ARRelationshipType)style;
@end
