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
#import "NSDate+TimeAgo.h"

@interface ARMapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>
@property (nonatomic, strong) PFObject * user_detail;
@property (nonatomic, strong) PFGeoPoint *geoPoint;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation ARMapViewController
- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"BuddyTracker";
    }
    return self;
}

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
//        [friendQuery whereKey:@"username" containedIn:toUser];
        [friendQuery findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
            NSLog(@"users are %@", users);
            for (PFUser *user in users) {
                PFGeoPoint *geoPoint = [user objectForKey:@"geolocation"];
                if (geoPoint != nil) {
                    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
                    point.coordinate = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
                    point.title = [user objectForKey:@"name"];
                    point.subtitle = [NSString stringWithFormat:@"Last Seen %@", [[user updatedAt] timeAgo]];
                    [self.mapView addAnnotation: point];
                }
            }
        }];
    }];
  
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone; //Whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    NSLog(@"%@", [self deviceLocation]);
    
    //View Area
//    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
//    region.center.latitude = self.locationManager.location.coordinate.latitude;
//    region.center.longitude = self.locationManager.location.coordinate.longitude;
//    region.span.longitudeDelta = 0.005f;
//    region.span.longitudeDelta = 0.005f;
//    [self.mapView setRegion:region animated:YES];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationMaskPortrait);
}


#pragma mark - MKMapViewDelegate

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//  static NSString *GeoPointAnnotationIdentifier = @"RedPin";
//  
//  MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:GeoPointAnnotationIdentifier];
//  
//  if (!annotationView) {
//    annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:GeoPointAnnotationIdentifier];
//    annotationView.pinColor = MKPinAnnotationColorRed;
//    annotationView.canShowCallout = YES;
//    annotationView.draggable = YES;
//    annotationView.animatesDrop = YES;
//  }
//  
//  return annotationView;
//}


//how to customize location icon
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
//    
//    static NSString* AnnotationIdentifier = @"Annotation";
//    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
//    
//    if (!pinView) {
//        
//        MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
////        if (annotation == mapView.userLocation) customPinView.image = [UIImage imageNamed:@"myCarImage.png"];
////        else customPinView.image = [UIImage imageNamed:@"mySomeOtherImage.png"];
//        customPinView.animatesDrop = NO;
//        customPinView.canShowCallout = YES;
//        return customPinView;
//        
//    } else {
//        
//        pinView.annotation = annotation;
//    }
//    
//    return pinView;
//}

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
    [self zoomToFitMapAnnotations:self.mapView];

    
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation");
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
//    [self zoomToFitMapAnnotations:self.mapView];
    // Add an annotation
//    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//    point.coordinate = userLocation.coordinate;
//    point.title = [[PFUser currentUser] objectForKey:@"name"];
//    point.subtitle = @"I'm here!!!";
    
//    [self.mapView addAnnotation:point];
    
//    [self insertCurrentLocation];

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
    PFUser * user = [PFUser currentUser];
    [user setObject:geoPoint forKey:@"geolocation"];

    [user saveEventually:^(BOOL succeeded, NSError *error) {
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


- (void)zoomToFitMapAnnotations:(MKMapView *)mapView {
    if ([mapView.annotations count] == 0) return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(id<MKAnnotation> annotation in mapView.annotations) {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    
    // Add a little extra space on the sides
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1;
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1;
    
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
}


@end
