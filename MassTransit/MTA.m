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
    const unsigned char *text;
    
    if (sqlite3_prepare_v2(_databaseConnection, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
        }
    }
    
    return routes;
}

@end
