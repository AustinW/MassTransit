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

@synthesize dbPath;

+ (Database *) db
{
    if (_databaseObj == nil) {
        _databaseObj = [[Database alloc] init];
    }
    return _databaseObj;
}

- (id) init
{
    self = [super init];
    
    if (self) {
        if (sqlite3_open([self.dbPath UTF8String], &_databaseConnection) != SQLITE_OK) {
            NSLog(@"Failed to open database.");
        }
    }
    
    return self;
}

- (void) dealloc
{
    sqlite3_close(_databaseConnection);
}

@end
