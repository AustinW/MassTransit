//
//  StopTime.m
//  MassTransit
//
//  Created by Austin White on 4/6/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "StopTime.h"

@implementation StopTime

@synthesize trip_id = _trip_id;
@synthesize arrival_time = _arrival_time; // Time string
@synthesize departure_time = _departure_time; // Time string
@synthesize stop_id = _stop_id;
@synthesize stop_sequence = _stop_sequence;
@synthesize stop_headsign = _stop_headsign;
@synthesize pickup_type = _pickup_type;
@synthesize drop_off_type = _drop_off_type;
@synthesize shape_dist_traveled = _shape_dist_traveled;

- (id)initWithUniqueId:(NSString *)trip_id arrivalTime:(NSString *)arrival_time departureTime:(NSString *)departure_time stopId:(NSUInteger)stop_id stopSequence:(NSUInteger)stop_sequence stopHeadsign:(NSString *)stop_headsign pickupType:(NSUInteger)pickup_type dropOffType:(NSUInteger)drop_off_type
{
    self = [super init];
    
    if (self) {
        self.trip_id             = trip_id;
        self.arrival_time        = arrival_time;
        self.departure_time      = departure_time;
        self.stop_id             = stop_id;
        self.stop_sequence       = stop_sequence;
        self.pickup_type         = pickup_type;
        self.drop_off_type       = drop_off_type;
    }
    
    return self;
}

@end
