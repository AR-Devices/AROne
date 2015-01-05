//
//  GoggleMapViewController.m
//  tracker
//
//  Created by Chenchen Zheng on 1/4/15.
//  Copyright (c) 2015 Chenchen Zheng. All rights reserved.
//

#import "GoggleMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Location+CoreData.h"
#import "Location.h"
#import "DatabaseAvailability.h"
#import "AppDelegate.h"


@interface GoggleMapViewController () <GMSMapViewDelegate>
@property (nonatomic, strong) NSArray *locations;


@end

@implementation GoggleMapViewController {
    GMSMapView *mapView_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mapView_.myLocation.coordinate.latitude
                                                            longitude:mapView_.myLocation.coordinate.longitude
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.mapType = kGMSTypeTerrain;

    mapView_.myLocationEnabled = YES;
    mapView_.accessibilityElementsHidden = NO;
    mapView_.indoorEnabled = NO;
    mapView_.settings.compassButton = YES;
    mapView_.delegate = self;

    self.view = mapView_;
    
    // Creates a marker in the center of the map.
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
//    marker.title = @"Sydney";
//    marker.snippet = @"Australia";
//    marker.map = mapView_;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    [context performBlockAndWait:^{
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
        request.predicate = nil;
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"timestamp"
                                                                  ascending:NO]];
        NSError *error;
        NSArray *matchs = [context executeFetchRequest:request error:&error];
        //        NSMutableArray *locs = [NSMutableArray new];
        if (!error) {
            //            self.locations = nil;
            //            for (Location *location in matchs) {
            //                [locs addObject:[Location convert2CLLocation:location]];
            //            }
            self.locations = matchs;
        }
    }];
    [self loadMap];
}

- (void)loadMap
{
    if (self.locations.count > 0) {
        [mapView_ setHidden:NO];
        [self addPolyLine];
    } else {
        [mapView_ setHidden:YES];
        // no locations were found!
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"Sorry, this run has no locations saved."
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}


- (void)addPolyLine {

    
    GMSStrokeStyle *solidRed = [GMSStrokeStyle solidColor:[UIColor redColor]];
    GMSStrokeStyle *redYellow =
    [GMSStrokeStyle gradientFromColor:[UIColor redColor] toColor:[UIColor yellowColor]];
    NSMutableArray *spans = [NSMutableArray new];

    

    
    GMSMutablePath *path = [GMSMutablePath path];
    for (int i = 0; i < self.locations.count; i++) {
        Location *location = [self.locations objectAtIndex:i];
        [path addLatitude:(CLLocationDegrees)[location.latitude doubleValue]  longitude:(CLLocationDegrees)[location.longitude doubleValue]];
        if ([location.altitude doubleValue] > 2600) {
            [spans addObject:[GMSStyleSpan spanWithStyle:solidRed segments:i]];
        } else {
            [spans addObject:[GMSStyleSpan spanWithStyle:redYellow segments:i]];
        }
    }
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.spans = spans;
    polyline.strokeWidth = 3.f;
    polyline.geodesic = YES;
    polyline.map = mapView_;
    GMSCoordinateBounds* bounds = [[GMSCoordinateBounds alloc] initWithPath:path];
    [mapView_ animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds]];
    
}

@end
