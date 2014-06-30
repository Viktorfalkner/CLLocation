//
//  VNMLocationTableViewController.m
//  CoreLocationPractice
//
//  Created by Viktor Falkner on 6/29/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import "VNMLocationTableViewController.h"
#import "VNMMapLocationViewController.h"


@interface VNMLocationTableViewController ()

@end

@implementation VNMLocationTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.locationsArray = [NSArray new];
    
    PFQuery *query = [PFQuery queryWithClassName:@"CLLocation"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        _locationsArray = objects;
        [self.tableView reloadData];
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.locationsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationcell" forIndexPath:indexPath];
    
    PFObject *location = self.locationsArray[indexPath.row];
    
    cell.textLabel.text = location[@"meetingName"];
    
    cell.detailTextLabel.text = location.objectId;
    
    
    
    // Configure the cell...
    
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    VNMMapLocationViewController *newVC = segue.destinationViewController;
    
    NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
    
    PFObject *currentObject = self.locationsArray[ip.row];
    
    NSString *meetingName = currentObject[@"meetingName"];
    NSNumber *latitudeNumber = currentObject[@"latitudeValue"];
    NSNumber *longitudeNumber = currentObject[@"longitudeValue"];
    
    Location *locationTobeDisplayed = [[Location alloc]initWithMeetingName:meetingName withLatidue:latitudeNumber withLongitude:longitudeNumber];
    
    newVC.locationToBeParsed = locationTobeDisplayed;
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
