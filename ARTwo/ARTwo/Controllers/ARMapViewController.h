//
//  ARMapViewController.h
//  ARTwo
//
//  Created by Colororange on 9/28/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ARMapViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic, strong) PFObject *detailItem;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@end
