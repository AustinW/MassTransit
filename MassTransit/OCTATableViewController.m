//
//  OCTATableViewController.m
//  MassTransit
//
//  Created by Austin White on 3/24/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "OCTATableViewController.h"

@implementation OCTATableViewController

- (void)viewDidLoad
{
    self.database = [[Database alloc] initWithPath:[[NSBundle mainBundle] pathForResource:@"OCTA" ofType:@"sl3"]];
    
    [super viewDidLoad];
}

@end
