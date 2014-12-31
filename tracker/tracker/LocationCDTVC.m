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
#import "CHCSVParser.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface LocationCDTVC () <CLLocationManagerDelegate, MFMailComposeViewControllerDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) Location *location;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property int counter;


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
        self.counter = 0;
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
            [appDelegate saveContext];
        }];
        [self.start setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (IBAction)onUpload:(id)sender {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    [context performBlockAndWait:^{
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
        request.predicate = nil;
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"timestamp"
                                                                  ascending:NO]];
        NSError *error;
        NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
        
        //creating a csv CHCSVWriter
        NSOutputStream *output = [NSOutputStream outputStreamToMemory];
        CHCSVWriter *writer = [[CHCSVWriter alloc] initWithOutputStream:output encoding:NSUTF8StringEncoding delimiter:','];
        
        for (Location *object in fetchedObjects)
        {
            CLLocation *loc = [Location convert2CLLocation:object];
            [writer writeField:[self.dateFormatter stringFromDate:loc.timestamp]];
            [writer writeField:[NSString stringWithFormat:@"%f", loc.coordinate.latitude]];
            [writer writeField:[NSString stringWithFormat:@"%f", loc.coordinate.longitude]];
            [writer writeField:[NSString stringWithFormat:@"%f", loc.altitude]];
            [writer writeField:[NSString stringWithFormat:@"%f", loc.speed]];
            [writer writeField:[NSString stringWithFormat:@"%f", loc.course]];
            [writer finishLine];
        }
        
        [writer closeStream];
        
        
        NSData *buffer = [output propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
        
        NSString *string = [[NSString alloc] initWithData:buffer encoding:NSUTF8StringEncoding];
        
        NSLog(@"Length of Buffer:%lu Error:%@",(unsigned long)[buffer length],[error localizedDescription]);
        
        if ( [MFMailComposeViewController canSendMail] )
        {
            MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
            mailComposer.mailComposeDelegate = self;
            
            NSData *myData = [string dataUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"myData csv:%@",myData);
            NSLog(@"string csv:%@",string);
            
            // Fill out the email body text
            NSString *emailBody = @"Location Output";
            [mailComposer setMessageBody:emailBody isHTML:NO];
            
            //attaching the data and naming it Sewer_Output
            [mailComposer addAttachmentData:myData  mimeType:@"text/cvs" fileName:@"Location_Output.csv"];
            
            [self presentViewController:mailComposer animated:YES completion:^{
                //nothing
            }];
        }
    }];
}

- (IBAction)onClear:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tracker" message:@"Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"YES", nil ];
    alert.delegate = self;
}


- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissViewControllerAnimated:YES completion:^{
        //nothing
    }];
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
        if (self.counter == 10) {
            self.counter = 0;
            [context save:nil];
        } else {
            self.counter++;
        }
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
    cell.textLabel.text = loc.localizedCoordinateString;
    cell.detailTextLabel.text = [self.dateFormatter stringFromDate:loc.timestamp];
    
    return cell;
}

#pragma mark - uialertview delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonindex is %ld", (long)buttonIndex);
    //    if (buttonIndex == 0) {
//        <#statements#>
//    }
}


@end
