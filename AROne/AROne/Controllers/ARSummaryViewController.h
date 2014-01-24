//
//  ARSummaryViewController.h
//  AROne
//
//  Created by Chenchen Zheng on 9/4/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
//PM Calender API
#import "PMCalendar.h"

@interface ARSummaryViewController : UITableViewController <PMCalendarControllerDelegate>
@property (nonatomic, strong) PMCalendarController *pmCC;

- (void)showCalendar: (id) sender;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
- (void)calendarController:(PMCalendarController *)calendarController didChangePeriod:(PMPeriod *)newPeriod ;
@end
