//
//  StopDetailViewController.m
//  MassTransit
//
//  Created by Austin White on 4/7/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "StopDetailViewController.h"

@interface StopDetailViewController ()

@end

@implementation StopDetailViewController

@synthesize stop = _stop;
@synthesize stopTime = _stopTime;
@synthesize mapView = _mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.stopTime.text = [self.stop objectForKey:@"arrival_time"];
    
    self.mapView.mapType = MKMapTypeStandard;
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([[self.stop objectForKey:@"stop_lat"] doubleValue], [[self.stop objectForKey:@"stop_lon"] doubleValue]);
    
    MKCoordinateSpan span = {.latitudeDelta = 0.005, .longitudeDelta = 0.005};
    MKCoordinateRegion region = {coordinate, span};
    
    [self.mapView setRegion:region];
    
    StopPoint *stopPoint = [[StopPoint alloc] initWithCoordinate:coordinate];
    [self.mapView addAnnotation:stopPoint];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
