//
//  MTAStopsTableViewController.m
//  MassTransit
//
//  Created by Austin White on 4/6/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "MTAStopsTableViewController.h"

@interface MTAStopsTableViewController ()

@end

@implementation MTAStopsTableViewController

@synthesize routeId = _routeId;
@synthesize dbInstance = _dbInstance;
@synthesize trips = _trips;


- (Database *)dbInstance
{
    if (_dbInstance == nil) {
        _dbInstance = [[Database alloc] initWithPath:[[NSBundle mainBundle] pathForResource:@"MTA" ofType:@"sl3"]];
    }
    
    return _dbInstance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.trips = [self.dbInstance tripsForRoute:self.routeId];
    
    NSLog(@"Trip count: %lu", (unsigned long)[self.trips count]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[self.trips valueForKey:@"sections"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.trips valueForKey:@"sections"][section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *keys = [[self.trips valueForKey:@"trips"] allKeys];
    
    NSString *sectionIdentifier = keys[section];
    
    return [[[self.trips valueForKey:@"trips"] valueForKey:sectionIdentifier] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Trip";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myIdentifier];
    }
    
    NSLog(@"%@", self.trips);
    
//    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
//    NSArray *array = [dictionary objectForKey:@"data"];
//    NSString *cellValue = [array objectAtIndex:indexPath.row];
//    cell.textLabel.text = cellValue;

    
    Trip *trip = [[self.trips valueForKey:@"trips"] objectAtIndex:indexPath.row];
    NSLog(@"Trip name: %@", [trip tripName]);
    NSLog(@"Trip duration: %@ to %@", [trip tripStartTime], [trip tripEndTime]);
    cell.textLabel.text = [trip tripName];
//    cell.detailTextLabel.text = route.description;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    
//    if ([segue.identifier isEqualToString:@"route-to-stops"]) {
//        
//        if ([sender isKindOfClass:[UITableViewCell class]]) {
//            NSIndexPath *path = [self.tableView indexPathForCell:sender];
//            
//            Route *route = [self.routes objectAtIndex:path.row];
//            
//            MTAStopsTableViewController *stopsViewController = segue.destinationViewController;
//            stopsViewController.title = route.name;
//            
//            stopsViewController.routeId = route.route_id;
//            
//            NSLog(@"Route: %@", stopsViewController.routeId);
//        }
//        
//        
//    }
//}



@end
