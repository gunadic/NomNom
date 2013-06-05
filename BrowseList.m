//
//  ReallyLongList.m
//
//  Created by Administrator on 11/17/10.
//  Copyright 2010 Trinity University. All rights reserved.
//

#import "BrowseList.h"
#import "OffCampusTableViewController.h"
#import "CategoriesDetailViewController.h"
#import "CategoriesTableViewController.h"
#import "CategoriesTableViewDeliveryController.h"
#import "RestaurantDetailViewController.h"
#import "Nomv4_0AppDelegate.h"


@implementation BrowseList 
@synthesize restArray;
@synthesize searchResults;
@synthesize restaurantDetailViewController;
@synthesize savedSearchTerm;

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 if ((self = [super initWithStyle:style])) {
 }
 return self;
 }
 */


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = NSLocalizedString(@"All Restaurants", @"Restaurant Categories");
	
	NSMutableArray *array = [[NSArray alloc] initWithObjects:@"Demo's Greek", @"Paloma Blanca", @"La Fonda on Main", @"Picante Grill", 
							 @"Central Market", @"Los Barrios Mexican Restaurant", @"Candlelight Coffee", @"Burger Boy", @"The Lion & Rose", @"Tre Trattoria"
							 , @"Taco Cabana", @"Mon Thai", @"Blanco Cafe", @"La Madeleine", @"Taco Taco", @"Twin Sisters Bakery", @"Niki's Tokyo Inn", @"Cheesy Jane's"
							 , @"Carriage House Bistro", @"Boardwalk Bistro", @"Big Kahuna", @"King's Court Frankfurter Express" , @"W D Deli", @"Panchito's", nil];
	self.restArray = array;
	[array release];
	
	if ([self savedSearchTerm])
	{
		[[[self searchDisplayController] searchBar] setText:[self savedSearchTerm]];
	}
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	NSInteger rows;
	
	if (tableView == [[self searchDisplayController] searchResultsTableView])
		rows = [[self searchResults] count];
	else {
		rows = [[self restArray] count];
	}
	
	
    return rows;}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSInteger row = [indexPath row];
	NSString  *contentForThisRow = nil;
	
	if (tableView == [[self searchDisplayController] searchResultsTableView]) {
		contentForThisRow = [[self searchResults] objectAtIndex:row];
	}
	else {
		contentForThisRow = [[self restArray] objectAtIndex:row];
	}
	
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	[[cell textLabel] setText:contentForThisRow];
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller 
shouldReloadTableForSearchString:(NSString *)searchString
{
	[self handleSearchForTerm:searchString];
	
	
	return YES;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSInteger row = [indexPath row];
	if (self.restaurantDetailViewController == nil){
		RestaurantDetailViewController *aRestaurantDetail = [[RestaurantDetailViewController alloc] initWithNibName:@"RestaurantDetailView" bundle:nil];
		self.restaurantDetailViewController = aRestaurantDetail;
		[aRestaurantDetail release];
	}
	restaurantDetailViewController.title = [NSString stringWithFormat: @"%@", [restArray objectAtIndex:row]];
	
	NomV4_0AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.offCampusNavController pushViewController:restaurantDetailViewController animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	[super viewDidUnload];
	
	//Save the state of the search UI so that it can be restored if the view is re-created.
	[self setSavedSearchTerm:[[[self searchDisplayController] searchBar] text]];
	[self setSearchResults:nil];
	
}


- (void)dealloc {
	[restaurantDetailViewController release];
    [super dealloc];
}

- (void) handleSearchForTerm:(NSString *)searchTerm
{
	[self setSavedSearchTerm:searchTerm];
	
	if ([self searchResults] == nil)
	{
		NSMutableArray *array = [[NSMutableArray alloc] init];
		[self setSearchResults:array];
		[array release], array = nil;
	}
	
	[[self searchResults] removeAllObjects];
	
	if ([[self savedSearchTerm] length] != 0)
	{
		//Could Cause Problems! WATCH IT!
		for (NSString *currentString in [self restArray])
		{
			if([currentString rangeOfString:searchTerm options: NSCaseInsensitiveSearch].location != NSNotFound)
			{
				[[self searchResults] addObject:currentString];
			}
		}
	}
}

@end
