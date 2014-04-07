//
//  Trip.m
//  MassTransit
//
//  Created by Austin White on 4/6/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "Trip.h"

@implementation Trip

@synthesize trip_id = _trip_id;
@synthesize route_id = _route_id;
@synthesize service_id = _service_id;
@synthesize trip_headsign = _trip_headsign;
@synthesize direction_id = _direction_id;
@synthesize block_id = _block_id;
@synthesize shape_id = _shape_id;

@synthesize tripName = _tripName;

- (id)initWithUniqueId:(NSString *)trip_id routeId:(NSString *)route_id serviceId:(NSString *)service_id tripHeadsign:(NSString *)trip_headsign directionId:(NSUInteger)direction_id blockId:(NSUInteger)block_id shapeId:(NSString *)shape_id
{
    self = [super init];
    
    if (self) {
        self.trip_id       = trip_id;
        self.route_id      = route_id;
        self.service_id    = service_id;
        self.trip_headsign = trip_headsign;
        self.direction_id  = direction_id;
        self.block_id      = block_id;
        self.shape_id      = shape_id;
    }
    
    return self;
}
@end
