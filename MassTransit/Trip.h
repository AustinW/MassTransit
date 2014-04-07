//
//  Trip.h
//  MassTransit
//
//  Created by Austin White on 4/6/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Trip : NSObject

enum DirectionType : NSUInteger { DirectionTypeOutbound, DirectionTypeInbound };

@property (nonatomic, strong) NSString *trip_id;
@property (nonatomic, strong) NSString *route_id;
@property (nonatomic, strong) NSString *service_id;
@property (nonatomic, strong) NSString *trip_headsign;
@property enum DirectionType direction_id;
@property NSUInteger block_id;
@property (nonatomic, strong) NSString *shape_id;

@property (nonatomic, strong) NSString *tripName;
@property (nonatomic, strong) NSString *tripStartTime;
@property (nonatomic, strong) NSString *tripEndTime;

- (id) initWithUniqueId:(NSString *)trip_id routeId:(NSString *)route_id serviceId:(NSString *)service_id tripHeadsign:(NSString *)trip_headsign directionId:(NSUInteger)direction_id blockId:(NSUInteger)block_id shapeId:(NSString *)shape_id;

@end
