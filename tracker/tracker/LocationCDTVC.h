//
//  TableViewController.h
//  tracker
//
//  Created by Chenchen Zheng on 12/17/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface LocationCDTVC : CoreDataTableViewController
@property (weak, nonatomic) IBOutlet UIButton *start;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *upload;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *clear;

@end
