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

- (id) init
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

- (void) dealloc
{
    [_databaseConnection close];
}

@end
