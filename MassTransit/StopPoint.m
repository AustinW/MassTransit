//
//  StopPoint.m
//  MassTransit
//
//  Created by Austin White on 4/7/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "StopPoint.h"

@implementation StopPoint

@synthesize coordinate = _coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    
    if (self) {
        _coordinate = coordinate;
    }
    
    return self;
}


@end
