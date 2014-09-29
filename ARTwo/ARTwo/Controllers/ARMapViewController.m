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

@end

@implementation ARMapViewController


#pragma mark - UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if (self.detailItem) {
    // obtain the geopoint
    PFGeoPoint *geoPoint = self.detailItem[@"location"];
    
    // center our map view around this geopoint
    self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude), MKCoordinateSpanMake(0.01f, 0.01f));
    
    // add the annotation
    GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:self.detailItem];
    [self.mapView addAnnotation:annotation];
  }
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
    annotationView.pinColor = 0;
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
