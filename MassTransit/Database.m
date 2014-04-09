//
//  Database.m
//  MassTransit
//
//  Created by Austin White on 3/24/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "Database.h"

@implementation Database

static Database *_databaseObj;

@synthesize dbPath, databaseConnection = _databaseConnection;

#pragma mark - Initializers

- (id)initWithPath:(NSString*)path
{
    self.dbPath = path;
    
    return [self init];
}

- (id)init
{
    self = [super init];
    
    if (self) {
        _databaseConnection = [FMDatabase databaseWithPath:self.dbPath];
        
        if ( ! [_databaseConnection open]) {
            NSLog(@"Unable to open database: %@", [_databaseConnection lastErrorMessage]);
        }
        
    }
    
    return self;
}

#pragma mark - GTFS Database methods

- (NSArray *)routes
{
    NSMutableArray *routes = [[NSMutableArray alloc] init];
    
    FMResultSet *result = [self.databaseConnection executeQuery:@"SELECT * FROM routes"];

    while ([result next]) {
        [routes addObject:[result resultDictionary]];
    }
    
    return routes;
}

- (NSMutableDictionary *)tripsForRoute:(NSString *)routeId
{
    NSMutableDictionary *tripDetails = [[NSMutableDictionary alloc] initWithDictionary:@{
                                                                                         @"sections": [[NSMutableArray alloc] init],
                                                                                         @"trips": [[NSMutableDictionary alloc] init]}];
    
    FMResultSet *tripResult = [self sqlTripsFromRouteId:routeId];
    
    while ([tripResult next]) {
        
        [self compileTrips:tripResult andTripDetails:tripDetails];
        
    }
    
    [self addStopsToTrip:tripDetails];
    
    return tripDetails;
}

# pragma mark - SQL Helpers

- (FMResultSet *)sqlTripsFromRouteId:(NSString *)routeId
{
    return [self.databaseConnection executeQueryWithFormat:@"SELECT * FROM trips WHERE route_id = %@", routeId];
}

- (FMResultSet *)sqlStopTimeBoundsFromTrip:(NSDictionary *)trip
{
    return [self.databaseConnection executeQueryWithFormat:@"\
            SELECT MIN(stop_sequence) AS start, MAX(stop_sequence) AS end\
            FROM stop_times\
            WHERE trip_id = %@", [trip objectForKey:@"trip_id"]];
}

- (FMResultSet *)sqlStopBoundsFromTrip:(NSDictionary *)trip andStart:(int)start andEnd:(int)end
{
    return [self.databaseConnection executeQueryWithFormat:@"\
            SELECT stop_times.stop_id, stops.stop_name, stop_times.arrival_time, stop_times.departure_time\
            FROM stop_times\
            JOIN stops ON stop_times.stop_id = stops.stop_id\
            WHERE trip_id = %@ AND (stop_sequence = %d OR stop_sequence = %d)\
            ORDER BY arrival_time", [trip objectForKey:@"trip_id"], start, end];
}

- (FMResultSet *)sqlStopsFromTrip:(Trip *)trip
{
    return [self.databaseConnection executeQueryWithFormat:@"\
            SELECT stops.stop_name, stops.stop_lat, stops.stop_lon, stop_times.arrival_time, stop_times.departure_time\
            FROM trips \
            JOIN stop_times ON trips.trip_id = stop_times.trip_id\
            JOIN stops ON stop_times.stop_id = stops.stop_id\
            WHERE trips.trip_id = %@", [trip attribute:@"trip_id"]];
}

#pragma mark - Object compilers

- (void)compileTrips:(FMResultSet *)tripResult andTripDetails:(NSMutableDictionary *)tripDetails
{
    Trip *tripRow = [[Trip alloc] initWithDictionary:[tripResult resultDictionary]];
    
    FMResultSet *stopTimeBoundsResult = [self sqlStopTimeBoundsFromTrip:tripRow.attributes];
    
    if ([stopTimeBoundsResult next]) {
        int start = [stopTimeBoundsResult intForColumn:@"start"];
        int end = [stopTimeBoundsResult intForColumn:@"end"];
        
        FMResultSet *stopBoundsResult = [self sqlStopBoundsFromTrip:tripRow.attributes andStart:start andEnd:end];
        
        NSUInteger resultCount = 0;
        
        while ([stopBoundsResult next] && ++resultCount <= 2) {
            
            if (resultCount == 1) {
                tripRow.tripName = [stopBoundsResult stringForColumn:@"stop_name"];
                tripRow.tripStartTime = [stopBoundsResult stringForColumn:@"departure_time"];
            } else {
                tripRow.tripName = [tripRow.tripName stringByAppendingString:@" -> "];
                tripRow.tripName = [tripRow.tripName stringByAppendingString:[stopBoundsResult stringForColumn:@"stop_name"]];
                tripRow.tripEndTime = [stopBoundsResult stringForColumn:@"arrival_time"];
            }
            
        }
        
        // Push out to separate function if time avails
        BOOL alreadyExists = NO;
        
        for (Trip *trip in [tripDetails objectForKey:@"sections"]) {
            if ([trip.tripName isEqualToString:tripRow.tripName]) {
                alreadyExists = YES;
                break;
            }
        }
        
        if ( ! alreadyExists) {
            [[tripDetails objectForKey:@"sections"] addObject:tripRow];
        }
    }
}

- (void)addStopsToTrip:(NSMutableDictionary *)tripDetails
{
    NSUInteger index = 0;
    
    for (Trip *trip in [tripDetails objectForKey:@"sections"]) {
        
        NSString *indexStr = [NSString stringWithFormat:@"%lu", (unsigned long)index];
        
        [[tripDetails objectForKey:@"trips"] setObject:[[NSMutableArray alloc] init] forKey:indexStr];
        
        FMResultSet *tripStops = [self sqlStopsFromTrip:trip];
        
        while ([tripStops next]) {
            NSDictionary *stop = [tripStops resultDictionary];

            [[[tripDetails objectForKey:@"trips"] objectForKey:indexStr] addObject:stop];
        }
        
        ++index;
    }
}

# pragma mark - Class methods (helpers)

+ (NSString *)routeNameFromDictionary:(NSDictionary *)route
{
    NSString *short_name = [route objectForKey:@"route_short_name"],
    *long_name = [route objectForKey:@"route_long_name"];
    
    if ([short_name isEqualToString:@""]) {
        return long_name;
    } else if ([long_name isEqualToString:@""]) {
        return short_name;
    } else {
        return [NSString stringWithFormat:@"%@ - %@", long_name, short_name];
    }
}

# pragma mark - Deallocator

- (void) dealloc
{
    [_databaseConnection close];
}

@end
