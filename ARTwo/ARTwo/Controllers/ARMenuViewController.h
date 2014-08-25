//
//  ARMenuViewController.h
//  ARTwo
//
//  Created by Colororange on 8/24/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MSDynamicsDrawerViewController.h>

typedef NS_ENUM(NSUInteger, MSPaneViewControllerType) {
  MSPaneViewControllerTypeSummary,
  MSPaneViewControllerTypeFriendAddAccept,
  MSPaneViewControllerTypeSuggestFriends,
  MSPaneViewControllerTypeProfile,
  MSPaneViewControllerTypeSetting,
  MSPaneViewControllerTypeCount
};

@interface ARMenuViewController : UITableViewController
@property (nonatomic, assign) MSPaneViewControllerType paneViewControllerType;
@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;

- (void)transitionToViewController:(MSPaneViewControllerType)paneViewControllerType;
@end
