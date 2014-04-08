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
        Route *routeRow = [[Route alloc] initWithUniqueId:[result stringForColumn:@"route_id"]
                                                shortName:[result stringForColumn:@"route_short_name"]
                                                 longName:[result stringForColumn:@"route_long_name"]
                                              description:[result stringForColumn:@"route_desc"]
                                                     type:[result stringForColumn:@"route_type"]
                                                    color:[result stringForColumn:@"route_color"]
                                                textColor:[result stringForColumn:@"route_text_color"]
                                                      url:[result stringForColumn:@"route_url"]];
        
        [routes addObject:routeRow];
    }
    
    return routes;
}

- (NSMutableDictionary *)tripsForRoute:(NSString *)routeId
{
    NSMutableDictionary *tripDetails = [[NSMutableDictionary alloc] initWithDictionary:@{
                                                                                         @"sections": [[NSMutableArray alloc] init],
                                                                                         @"trips": [[NSMutableDictionary alloc] init]}];
    
    FMResultSet *tripResult = [self.databaseConnection executeQueryWithFormat:@"SELECT * FROM trips WHERE route_id = %@", routeId];
    
    while ([tripResult next]) {
        Trip *tripRow = [[Trip alloc] initWithUniqueId:[tripResult stringForColumn:@"trip_id"]
                                               routeId:[tripResult stringForColumn:@"route_id"]
                                             serviceId:[tripResult stringForColumn:@"service_id"]
                                          tripHeadsign:[tripResult stringForColumn:@"trip_headsign"]
                                           directionId:[tripResult intForColumn:@"direction_id"]
                                               blockId:[tripResult intForColumn:@"block_id"]
                                               shapeId:[tripResult stringForColumn:@"shape_id"]];
        
        FMResultSet *stopTimeBoundsResult = [self.databaseConnection executeQueryWithFormat:@"SELECT MIN(stop_sequence) AS start, MAX(stop_sequence) AS end FROM stop_times WHERE trip_id = %@", tripRow.trip_id];
        
        if ([stopTimeBoundsResult next]) {
            int start = [stopTimeBoundsResult intForColumn:@"start"];
            int end = [stopTimeBoundsResult intForColumn:@"end"];
            
            FMResultSet *stopBoundsResult = [self.databaseConnection executeQueryWithFormat:@"SELECT stop_times.stop_id, stops.stop_name, stop_times.arrival_time, stop_times.departure_time FROM stop_times JOIN stops ON stop_times.stop_id = stops.stop_id WHERE trip_id = %@ AND (stop_sequence = %d OR stop_sequence = %d) ORDER BY arrival_time", tripRow.trip_id, start, end];
            
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
    
    NSUInteger index = 0;
    
    for (Trip *trip in [tripDetails objectForKey:@"sections"]) {
        
        NSString *indexStr = [NSString stringWithFormat:@"%lu", (unsigned long)index];
        
        [[tripDetails objectForKey:@"trips"] setObject:[[NSMutableArray alloc] init] forKey:indexStr];
        
        FMResultSet *tripStops = [self.databaseConnection executeQueryWithFormat:@"\
                                  SELECT stops.stop_name, stops.stop_lat, stops.stop_lon, stop_times.arrival_time, stop_times.departure_time\
                                  FROM trips \
                                  JOIN stop_times ON trips.trip_id = stop_times.trip_id\
                                  JOIN stops ON stop_times.stop_id = stops.stop_id\
                                  WHERE trips.trip_id = %@", trip.trip_id];
        
        while ([tripStops next]) {
            NSDictionary *stop = @{
                                   @"stop_name": [tripStops stringForColumn:@"stop_name"],
                                   @"stop_lat": [tripStops stringForColumn:@"stop_lat"],
                                   @"stop_lon": [tripStops stringForColumn:@"stop_lon"],
                                   @"arrival_time": [tripStops stringForColumn:@"arrival_time"],
                                   @"departure_time": [tripStops stringForColumn:@"departure_time"]};
            
            
            NSLog(@"Index: %ld", (unsigned long)index);
            
            [[[tripDetails objectForKey:@"trips"] objectForKey:indexStr] addObject:stop];
        }
        
        ++index;
    }
    
    NSLog(@"Trip Details: %@", tripDetails);
    
    return tripDetails;
}

- (void) dealloc
{
    [_databaseConnection close];
}

@end
