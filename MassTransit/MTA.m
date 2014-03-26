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
    
    NSString *query = @"SELECT * FROM routes";
    
    sqlite3_stmt *stmt;
    
    if (sqlite3_prepare_v2(_databaseConnection, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSString *route_id    = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stmt, 0)];
            NSString *short_name  = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stmt, 1)];
            NSString *long_name   = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stmt, 2)];
            NSString *description = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stmt, 3)];
            NSString *type        = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stmt, 4)];
            NSString *color       = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stmt, 5)];
            NSString *text_color  = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stmt, 6)];
            NSString *url         = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stmt, 7)];
            
            Route *routeRow = [[Route alloc] initWithUniqueId:route_id shortName:short_name longName:long_name description:description type:type color:color textColor:text_color url:url];
            
            [routes addObject:routeRow];
        }
        
        sqlite3_finalize(stmt);
    } else {
        NSLog(@"Invalid query");
    }
    
    return routes;
}

@end
