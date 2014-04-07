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

+ (Database *) db
{
    if (_databaseObj == nil) {
        _databaseObj = [[Database alloc] init];
    }
    return _databaseObj;
}

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

//- (NSArray *)stopsForRouteId:(NSString *)routeId
//{
//    NSLog(@"route id: %@", routeId);
//    FMResultSet *routeResult = [self.databaseConnection executeQueryWithFormat:@"SELECT * FROM routes WHERE route_id = %@", routeId];
//    
//    while ([routeResult next]) {
//        Route *routeRow = [[Route alloc] initWithUniqueId:[routeResult stringForColumn:@"route_id"]
//                                                shortName:[routeResult stringForColumn:@"route_short_name"]
//                                                 longName:[routeResult stringForColumn:@"route_long_name"]
//                                              description:[routeResult stringForColumn:@"route_desc"]
//                                                     type:[routeResult stringForColumn:@"route_type"]
//                                                    color:[routeResult stringForColumn:@"route_color"]
//                                                textColor:[routeResult stringForColumn:@"route_text_color"]
//                                                      url:[routeResult stringForColumn:@"route_url"]];
//        
//        return [self stopsForRoute:routeRow];
//    }
//    
//    return nil;
//}

- (NSArray *)tripsForRoute:(NSString *)routeId
{
    NSMutableArray *trips = [[NSMutableArray alloc] init];
    
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
            
            FMResultSet *stopBoundsResult = [self.databaseConnection executeQueryWithFormat:@"SELECT stop_times.stop_id, stops.stop_name FROM stop_times JOIN stops ON stop_times.stop_id = stops.stop_id WHERE trip_id = %@ AND (stop_sequence = %d OR stop_sequence = %d)", tripRow.trip_id, start, end];
            
            NSUInteger resultCount = 0;
            
            while ([stopBoundsResult next] && ++resultCount <= 2) {
                
                if (resultCount == 1) {
                    tripRow.tripName = [stopBoundsResult stringForColumn:@"stop_name"];
                } else {
                    tripRow.tripName = [tripRow.tripName stringByAppendingString:@" ➡️ "];
                    tripRow.tripName = [tripRow.tripName stringByAppendingString:[stopBoundsResult stringForColumn:@"stop_name"]];
                }
                
            }
            
            BOOL alreadyExists = NO;
            
            for (Trip *tripTemp in trips) {
                if ([tripTemp.tripName isEqualToString:tripRow.tripName]) {
                    alreadyExists = YES;
                    break;
                }
            }
            
            if ( ! alreadyExists) {
                [trips addObject:tripRow];
            }
        }
    }
    
    return trips;
}

- (void) dealloc
{
    [_databaseConnection close];
}

@end
