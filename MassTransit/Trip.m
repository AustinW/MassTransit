//
//  Trip.m
//  MassTransit
//
//  Created by Austin White on 4/6/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "Trip.h"

@implementation Trip

@synthesize tripName;
@synthesize tripStartTime;
@synthesize tripEndTime;
@synthesize attributes = _attributes;

- (id)initWithDictionary:(NSDictionary *)trip
{
    self = [super init];
    
    if (self) {
        _attributes = trip;
    }
    
    return self;
}

- (id)attribute:(NSString *)key
{
    return [self.attributes objectForKey:key];
}

- (NSString *)description {
    return self.tripName;
}
@end
