//
//  MTATableViewController.m
//  MassTransit
//
//  Created by Austin White on 3/24/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "MTATableViewController.h"

@implementation MTATableViewController

- (void)viewDidLoad
{
    self.database = [[Database alloc] initWithPath:[[NSBundle mainBundle] pathForResource:@"MTA" ofType:@"sl3"]];
    
    [super viewDidLoad];
}


@end
