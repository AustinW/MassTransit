//
//  StopsTableViewController.h
//  MassTransit
//
//  Created by Austin White on 4/6/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "StopDetailViewController.h"

@interface StopsTableViewController : UITableViewController
@property (nonatomic, strong) Database *database;
@property (nonatomic, strong) NSString *routeId;
@property (nonatomic, strong) NSDictionary *trips;
@end
