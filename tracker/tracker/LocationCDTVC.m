//
//  TableViewController.m
//  tracker
//
//  Created by Chenchen Zheng on 12/17/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "LocationCDTVC.h"
#import <CoreLocation/CoreLocation.h>
#import "Location.h"
#import "Location+CoreData.h"
#import "AppDelegate.h"
#import "CLLocation+Strings.h"
#import "DatabaseAvailability.h"


@interface LocationCDTVC () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) Location *location;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;


@end

@implementation LocationCDTVC

- (NSDateFormatter *)dateFormatter {
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [_dateFormatter setTimeStyle:NSDateFormatterLongStyle];
    }
    return _dateFormatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

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

        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        [context performBlockAndWait:^{
            int magicGap = 10;
            for (int i = 0; i < magicGap; i++) {
                self.location = [Location saveLocation:[Location convert2CLLocation:self.location] inManagedObjectContext:context];
            }
        }];
        
        
        [self.start setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
    //save object
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    [context performBlockAndWait:^{
        self.location = [Location saveLocation:[locations lastObject] inManagedObjectContext:context];
    }];
}

#pragma mark - core data

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserverForName:DatabaseAvailabilityNotification
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *note) {
                                                      self.managedObjectContext = note.userInfo[DatabaseAvailabilityContext];
                                                  }];
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
    request.predicate = nil;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"timestamp"
                                                              ascending:NO]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"LocationCell"];
    
    Location *location = [self.fetchedResultsController objectAtIndexPath:indexPath];
    CLLocation *loc = [Location convert2CLLocation:location];
    NSLog(@"loc is %@", loc.localizedCoordinateString);
    cell.textLabel.text = loc.localizedCoordinateString;
    cell.detailTextLabel.text = [self.dateFormatter stringFromDate:loc.timestamp];
    
    return cell;
}




@end
