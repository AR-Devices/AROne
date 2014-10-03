//
//  ARMapViewController.m
//  ARTwo
//
//  Created by Colororange on 9/28/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARMapViewController.h"
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface ARMapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>
@property (nonatomic, strong) PFObject * user_detail;
@property (nonatomic, strong) PFGeoPoint *geoPoint;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation ARMapViewController


#pragma mark - UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
  self.mapView.delegate = self;
  self.mapView.showsUserLocation = true;
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
  [self.view addSubview:self.mapView];
    
    //location:
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //ios 8
    if(IS_OS_8_OR_LATER) {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    [_locationManager startUpdatingLocation];
  
    
    
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
        [friendQuery whereKey:@"username" containedIn:toUser];
        [friendQuery findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
            NSLog(@"users are %@", users);
            for (PFUser *user in users) {
                PFGeoPoint *geoPoint = [user objectForKey:@"geolocation"];
                if (geoPoint != nil) {
                    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
                    point.coordinate = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
                    point.title = [user objectForKey:@"name"];
                    //          point.subtitle = @"I'm here!!!";
                    [self.mapView addAnnotation: point];
                }
            }
        }];
    }];
    
    
//  PFUser* user = [PFUser currentUser];
//  PFQuery * locationQuery =[PFUser query];
////  locationQuery.limit = 1;
////  [locationQuery whereKey:@"objectId" equalTo:user.objectId];
//  [locationQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//    NSLog(@"COLORORANGE: %@", objects);
//    if (!error) {
//      if (objects.count > 0) {
//        self.user_detail = [objects objectAtIndex:0];
//        self.geoPoint = [self.user_detail objectForKey:@"geolocation"];
//        NSLog(@"COLORORANGE: user is %@ \n lat: %f; long: %f", self.user_detail, self.geoPoint.latitude, self.geoPoint.longitude);
//        // center our map view around this geopoint
//        self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(self.geoPoint.latitude, self.geoPoint.longitude), MKCoordinateSpanMake(0.01f, 0.01f));
//        // add the annotation
//        //FIXME: COLORORANGE: not sure how to use this part
//          MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//          point.coordinate = CLLocationCoordinate2DMake(self.geoPoint.latitude, self.geoPoint.longitude);
//          point.title = @"Jerry";
////          point.subtitle = @"I'm here!!!";
//          [self.mapView addAnnotation: point];
////        GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:self.geoPoint];
////        [self.mapView addAnnotation:annotation];
//      }
//    }
//  }];
  
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone; //Whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    NSLog(@"%@", [self deviceLocation]);
    
    //View Area
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.locationManager.location.coordinate.latitude;
    region.center.longitude = self.locationManager.location.coordinate.longitude;
    region.span.longitudeDelta = 0.005f;
    region.span.longitudeDelta = 0.005f;
    [self.mapView setRegion:region animated:YES];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationMaskPortrait);
}


#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  static NSString *GeoPointAnnotationIdentifier = @"RedPin";
  
  MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:GeoPointAnnotationIdentifier];
  
  if (!annotationView) {
    annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:GeoPointAnnotationIdentifier];
    annotationView.pinColor = MKPinAnnotationColorRed;
    annotationView.canShowCallout = YES;
    annotationView.draggable = YES;
    annotationView.animatesDrop = YES;
  }
  
  return annotationView;
}

//-----------------------------------GEO Location

/**
 Conditionally enable the Search/Add buttons:
 If the location manager is generating updates, then enable the buttons;
 If the location manager is failing, then disable the buttons.
 */
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    NSLog(@"JERRY: didUPdateTOLocation");
    [self insertCurrentLocation];
    //display myself
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = newLocation.coordinate;
    point.title = [[PFUser currentUser] objectForKey:@"username"];
    //    point.subtitle = @"I'm here!!!";
    
    [self.mapView addAnnotation:point];
    
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.title = [[PFUser currentUser] objectForKey:@"username"];
//    point.subtitle = @"I'm here!!!";
    
    [self.mapView addAnnotation:point];
    
    [self insertCurrentLocation];

}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
}

/**
 Return a location manager -- create one if necessary.
 */
- (CLLocationManager *)locationManager {
    
    if (_locationManager != nil) {
        return _locationManager;
    }
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locationManager.delegate = self;
    //  _locationManager.purpose = @"Your current location is used to demonstrate PFGeoPoint and Geo Queries.";
    
    return _locationManager;
}

- (void)insertCurrentLocation{
    // If it's not possible to get a location, then return.
    CLLocation *location = self.locationManager.location;
    if (!location) {
        return;
    }
    
    // Configure the new event with information from the location.
    CLLocationCoordinate2D coordinate = [location coordinate];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    //  PFObject *object = [PFObject objectWithClassName:@"User"];
    PFUser * object = [PFUser currentUser];
    [object setObject:geoPoint forKey:@"geolocation"];
    
    [object saveEventually:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"geolocation uploaded correctly");
            [self.locationManager stopUpdatingLocation];
        }
    }];
}


- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceLat {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
}
- (NSString *)deviceLon {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceAlt {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.altitude];
}



@end
