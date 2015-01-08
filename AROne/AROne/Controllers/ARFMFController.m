//
//  ARFMFController.m
//  AROne
//
//  Created by Chenchen Zheng on 1/1/15.
//  Copyright (c) 2015 Chenchen Zheng. All rights reserved.
//

#import "ARFMFController.h"
#import "ARFriendTableViewCell.h"
#import <NSDate+TimeAgo.h>
#import "ARTrailSummaryMapViewController.h"

@interface ARFMFController () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, strong) NSArray *friendList;

@end

@implementation ARFMFController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    self.title = @"FMF";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ARFriendTableViewCell" bundle:nil] forCellReuseIdentifier:@"AppCell"];
    
    PFQuery *activityQuery = [PFQuery queryWithClassName:@"Activity"];
    [activityQuery whereKey:@"fromUser" equalTo: [PFUser currentUser]];
    [activityQuery includeKey:@"toUser"];
    [activityQuery findObjectsInBackgroundWithBlock:^(NSArray *activities, NSError *error) {
        [SVProgressHUD dismiss];
        NSMutableArray *toUser = [NSMutableArray new];
        for (id activity in activities) {
            NSString *username = [[activity objectForKey:@"toUser"] objectForKey:@"username"];
            [toUser addObject:username];
        }
        //        [toUser addObject:[[PFUser currentUser] objectForKey:@"username"]];
        PFQuery *friendQuery = [PFUser query];
        //        [friendQuery whereKey:@"username" containedIn:toUser];
        [friendQuery findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
            NSLog(@"users are %@", users);
            self.friendList = users;
            [self.tableView reloadData];
        }];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.friendList count]) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friendList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ARFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppCell" forIndexPath:indexPath];
    PFUser *user = [self.friendList objectAtIndex:indexPath.row];
    if (user[@"name"]) {
        cell.userName.text = user[@"name"];
    } else if (user[@"displayname"]) {
        cell.userName.text = user[@"displayname"];
    }
    @try {
        PFGeoPoint *point = user[@"geolocation"];
        cell.trailName.text = [ARTrailSummaryMapViewController trailPathViewData: [[user objectForKey:@"altitude"] doubleValue] and:point.latitude and:point.longitude];
    }
    @catch (NSException *exception) {
        NSLog(@"exception is %@", exception);
    }
    cell.lastSeen.text = [NSString stringWithFormat:@"Last Seen %@", [[user updatedAt] timeAgo]];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 63;
}


// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
    
    if ([locations lastObject]) {
        //save object to server
        // Configure the new event with information from the location.
        CLLocationCoordinate2D coordinate = [[locations lastObject] coordinate];
        PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        //  PFObject *object = [PFObject objectWithClassName:@"User"];
        PFUser * user = [PFUser currentUser];
        [user setObject:geoPoint forKey:@"geolocation"];
        double altitude = [[locations lastObject] altitude];
        [user setObject:[NSNumber numberWithDouble:altitude] forKey:@"altitude"];
        [user saveEventually:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"geolocation uploaded correctly");
            }
        }];
        //stop upload
        [self.locationManager stopUpdatingLocation];
    }
    
    [locations lastObject];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
