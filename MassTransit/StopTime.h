//
//  StopTime.h
//  MassTransit
//
//  Created by Austin White on 4/6/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StopTime : NSObject

@property (nonatomic, strong) NSString *trip_id;
@property (nonatomic, strong) NSString *arrival_time; // Time string
@property (nonatomic, strong) NSString *departure_time; // Time string
@property NSUInteger stop_id;
@property NSUInteger stop_sequence;
@property (nonatomic, strong) NSString *stop_headsign;
@property NSUInteger pickup_type;
@property NSUInteger drop_off_type;
@property (nonatomic, strong) NSString *shape_dist_traveled;

- (id)initWithUniqueId:(NSString *)trip_id arrivalTime:(NSString *)arrival_time departureTime:(NSString *)departure_time stopId:(NSUInteger)stop_id stopSequence:(NSUInteger)stop_sequence stopHeadsign:(NSString *)stop_headsign pickupType:(NSUInteger)pickup_type dropOffType:(NSUInteger)drop_off_type;

@end
