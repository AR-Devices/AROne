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

#import "GeoPointAnnotation.h"
@interface ARMapViewController ()
@property (nonatomic, strong) PFObject * user_detail;
@property (nonatomic, strong) PFGeoPoint *geoPoint;
@end

@implementation ARMapViewController


#pragma mark - UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
  self.mapView.delegate = self;
  self.mapView.showsUserLocation = true;
  [self.view addSubview:self.mapView];
  
  PFUser* user = [PFUser currentUser];
  PFQuery * locationQuery =[PFUser query];
  locationQuery.limit = 1;
  [locationQuery whereKey:@"objectId" equalTo:user.objectId];
  [locationQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    NSLog(@"COLORORANGE: %@", objects);
    if (!error) {
      if (objects.count > 0) {
        self.user_detail = [objects objectAtIndex:0];
        self.geoPoint = [self.user_detail objectForKey:@"geolocation"];
        NSLog(@"COLORORANGE: user is %@ \n lat: %f; long: %f", self.user_detail, self.geoPoint.latitude, self.geoPoint.longitude);
        // center our map view around this geopoint
        self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(self.geoPoint.latitude, self.geoPoint.longitude), MKCoordinateSpanMake(0.01f, 0.01f));
        // add the annotation
        //FIXME: COLORORANGE: not sure how to use this part
        GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:self.geoPoint];
        [self.mapView addAnnotation:annotation];
      }
    }
  }];
  
  
  

  
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
