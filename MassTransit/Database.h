//
//  Database.h
//  MassTransit
//
//  Created by Austin White on 3/24/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Database : NSObject
{
    sqlite3 *_databaseConnection;
}

@property (nonatomic, strong) NSString *dbPath;

+ (Database *) db;
- (id) init;

@end
