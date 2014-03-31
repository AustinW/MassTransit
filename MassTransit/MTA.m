//
//  MTA.m
//  MassTransit
//
//  Created by Austin White on 3/24/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "MTA.h"

@implementation MTA

- (id) init
{
    self.dbPath = [[NSBundle mainBundle] pathForResource:@"MTA" ofType:@"sl3"];
    
    self = [super init];
    
    return self;
}

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

@end
