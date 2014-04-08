//
//  RoutesViewController.h
//  MassTransit
//
//  Created by Austin White on 4/8/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "StopsTableViewController.h"

@interface RoutesViewController : UITableViewController

@property (nonatomic, strong) Database *database;
@property (nonatomic, strong) NSArray *routes;

@end
