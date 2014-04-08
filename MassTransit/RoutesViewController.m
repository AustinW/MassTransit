//
//  RoutesViewController.m
//  MassTransit
//
//  Created by Austin White on 4/8/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "RoutesViewController.h"

@interface RoutesViewController ()

@end

@implementation RoutesViewController

@synthesize database, routes;

- (void)viewDidLoad
{
    //self.database = [[Database alloc] initWithPath:[[NSBundle mainBundle] pathForResource:@"MTA" ofType:@"sl3"]];
    self.routes = [self.database routes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.routes = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.routes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Route";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myIdentifier];
    }
    
    NSLog(@"Route index: %ld", (long)indexPath.row);
    Route *route = [self.routes objectAtIndex:indexPath.row];
    cell.textLabel.text = [route name];
    cell.detailTextLabel.text = route.description;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSLog(@"Segueing with identifier: %@...", segue.identifier);
    
    if ([segue.identifier isEqualToString:@"MTA route-to-stops"]) {
        
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            
            Route *route = [self.routes objectAtIndex:path.row];
            
            StopsTableViewController *stopsViewController = segue.destinationViewController;
            stopsViewController.database = self.database;
            stopsViewController.title = route.name;
            
            stopsViewController.routeId = route.route_id;
            
            NSLog(@"Route: %@", stopsViewController.routeId);
        }
        
        
    }
}


@end
