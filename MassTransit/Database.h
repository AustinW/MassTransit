//
//  Database.h
//  MassTransit
//
//  Created by Austin White on 3/24/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>

#import "Route.h"
#import "Trip.h"
#import "StopTime.h"

@interface Database : NSObject

@property (nonatomic, strong) NSString *dbPath;
@property (nonatomic, strong) FMDatabase *databaseConnection;

- (id)initWithPath:(NSString*)path;

- (NSArray *)routes;
- (NSDictionary *)tripsForRoute:(NSString *)routeId;

@end
