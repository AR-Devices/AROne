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
@property (strong, nonatomic) UIButton *start;


@end

@implementation ARFMFController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    self.title = @"FMF";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ARFriendTableViewCell" bundle:nil] forCellReuseIdentifier:@"AppCell"];
    
    
    self.start = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
    [self.start setTitle:@"Start" forState:UIControlStateNormal];
    [self.start addTarget:self action:@selector(onStart:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.start];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadFriends)
                  forControlEvents:UIControlEventValueChanged];
    
}

- (void)reloadFriends {
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
    if (self.refreshControl) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
    
}
- (IBAction)onStart:(id)sender {
    NSLog(@"onStart");
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.start.titleLabel.text isEqualToString:@"Start"]) {
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        [self.locationManager startUpdatingLocation];
        [self.start setTitle:@"Stop" forState:UIControlStateNormal];
    } else {
        [self.locationManager stopUpdatingLocation];
        [self.start setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self reloadFriends];
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSString *trailName = nil;
    PFGeoPoint *point = nil;
    float altitude = 0;
    if (user[@"name"]) {
        cell.userName.text = user[@"name"];
    } else if (user[@"displayname"]) {
        cell.userName.text = user[@"displayname"];
    }
    @try {
        point = user[@"geolocation"];
        altitude = [[user objectForKey:@"altitude"] floatValue];
        NSArray *data =  [ARTrailSummaryMapViewController calculate_trail:altitude and:point.latitude and:point.longitude];
        NSLog(@"data is %@",data);
        trailName =[NSString stringWithFormat:@"%@ %0.2f%%",[data objectAtIndex:0], [[data objectAtIndex:1] doubleValue]];
    }
    @catch (NSException *exception) {
        NSLog(@"exception is %@", exception);
    }
    @finally {
        if (trailName) {
            cell.trailName.text = trailName;
        } else {
            cell.trailName.text = @"TrailName";
        }
    }
    
    if (point != nil && altitude != 0) {
        cell.coordinates.text = [NSString stringWithFormat:@"%f %f %f", point.latitude, point.longitude, altitude];
    } else {
        cell.coordinates.text = @"Coordinates";
    }
    cell.lastSeen.text = [NSString stringWithFormat:@"Last Seen %@", [[user updatedAt] timeAgo]];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 92;
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
                NSLog(@"geolocation uploaded correctly to %@", [user username]);
            }
        }];
        //stop upload
//        [self.locationManager stopUpdatingLocation];
        //continue update data
    }
    
    [locations lastObject];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
