//
//  StopDetailViewController.h
//  MassTransit
//
//  Created by Austin White on 4/7/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "StopPoint.h"

@interface StopDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *stopTime;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSDictionary *stop;
@end
