//
//  MTA.h
//  MassTransit
//
//  Created by Austin White on 3/24/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "Route.h"

@interface MTA : Database

- (id) init;
- (NSArray *)routes;
@end
