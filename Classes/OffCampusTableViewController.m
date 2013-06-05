//
//  OffCampusTableViewController.m
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import "OffCampusTableViewController.h"
#import "CategoriesDetailViewController.h"
#import "CategoriesTableViewController.h"
#import "CategoriesTableViewDeliveryController.h"
#import "CategoriesTableViewTigerbucksController.h"
#import "CategoriesTableViewTimeController.h"
#import "CategoriesTableViewPriceBracketController.h"
#import "CategoriesTableViewPopularController.h"
#import "RestaurantDetailViewController.h"
#import "ReallyLongListController.h"
#import "Nomv4_0AppDelegate.h"


@implementation OffCampusTableViewController
@synthesize offCampusArray;
@synthesize categoriesTableViewDeliveryController;
@synthesize categoriesTableViewTigerbucksController;
@synthesize categoriesTableViewTimeController;
@synthesize categoriesTableViewPriceBracketController;
@synthesize categoriesTableViewPopularController;
@synthesize categoriesTableViewController;
@synthesize restaurantDetailViewController;
@synthesize reallyLongListController;
@synthesize searchResults;
@synthesize savedSearchTerm;

//================================================================================================
//  Purpose: This class serves to be the controller for the top view of the off campus portion. It
//           controls what what is shown in the first table view. It populates the labels based on 
//           the XML input. It also controls what view is loaded next depending on the option that  
//           is selected.
//
//===================================================================================================
NSMutableArray *dbData;

#pragma mark -
#pragma mark Initialization
/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization th
}at is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
*/

int viewNum = 0;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = NSLocalizedString(@"Off Campus", @"Trinity's Favorite Restaurants");
	
	NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"Browse All",@"Who Delivers?",@"What's Open?",@"How Expensive?",@"Who Accepts TigerBucks?", 
															 @"What Type?", @"What's Popular?", nil];
	self.offCampusArray = array;
	
	dbData = [[NSMutableArray alloc] init];
	[dbData addObject:@"Home"];
	
	[array release];
	
	// Restore search term
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

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
		rows = [[self offCampusArray] count];
	}

		
    return rows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	NSInteger row = [indexPath row];
	NSString  *contentForThisRow = nil;
	
	if (tableView == [[self searchDisplayController] searchResultsTableView]) {
		contentForThisRow = [[self searchResults] objectAtIndex:row];
	}
	else {
		contentForThisRow = [[self offCampusArray] objectAtIndex:row];
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
	if([[offCampusArray objectAtIndex:row] isEqualToString:@"Browse All"]){ 
		viewNum = 1;
		self.reallyLongListController = [[ReallyLongListController alloc] initWithNibName:@"ridiculouslyLongListView" bundle:nil];
				
	}
	else if([[offCampusArray objectAtIndex:row] isEqualToString:@"Who Delivers?"]){ 
		viewNum = 2;
		self.categoriesTableViewDeliveryController = [[CategoriesTableViewDeliveryController alloc] initWithNibName:@"CategoriesTableViewDelivery" bundle:nil];
	}
	//Feature that might want to be added later on
	/*
	if([[offCampusArray objectAtIndex:row] isEqualToString:@"Distance"]){
		//OnCampusDetailViewController 
		viewNum = 0;
		self.categoriesTableViewController = [[CategoriesTableViewController alloc] initWithNibName:@"OnCampusDetailViewSpecials" bundle:nil];
	}
	*/
	if([[offCampusArray objectAtIndex:row] isEqualToString:@"What's Open?"]){ 
		viewNum = 4;
		self.categoriesTableViewTimeController = [[CategoriesTableViewTimeController alloc] initWithNibName:@"CategoriesTableViewTimeController" bundle:nil];
	}
	
	if([[offCampusArray objectAtIndex:row] isEqualToString:@"How Expensive?"]){ 
		viewNum = 5;
		self.categoriesTableViewPriceBracketController = [[CategoriesTableViewPriceBracketController alloc] initWithNibName:@"CategoriesTableViewPriceBracketController" bundle:nil];
	}
	if([[offCampusArray objectAtIndex:row] isEqualToString:@"Who Accepts TigerBucks?"]){ 
		viewNum = 3;
		self.categoriesTableViewTigerbucksController = [[CategoriesTableViewTigerbucksController alloc] initWithNibName:@"CategoriesTableViewTigerbucksController" bundle:nil];
	}
	if([[offCampusArray objectAtIndex:row] isEqualToString:@"What Type?"]){ 
		viewNum = 0;
		self.categoriesTableViewController = [[CategoriesTableViewController alloc] initWithNibName:@"CategoriesTableView" bundle:nil];
	}
	if([[offCampusArray objectAtIndex:row] isEqualToString:@"What's Popular?"]){ 
		viewNum = 6;
		self.categoriesTableViewPopularController = [[CategoriesTableViewPopularController alloc] initWithNibName:@"CategoriesTableViewPopularController" bundle:nil];
	}
	
	categoriesTableViewController.title = [NSString stringWithFormat: @"%@", [offCampusArray objectAtIndex:row]];
	
	NomV4_0AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
	if(viewNum == 0)
		[delegate.offCampusNavController pushViewController:categoriesTableViewController animated:YES];
	if(viewNum == 2)
		[delegate.offCampusNavController pushViewController:categoriesTableViewDeliveryController animated:YES];
	if(viewNum == 3)
		[delegate.offCampusNavController pushViewController:categoriesTableViewTigerbucksController animated:YES];
	if(viewNum == 4)
		[delegate.offCampusNavController pushViewController:categoriesTableViewTimeController animated:YES];
	if(viewNum == 5)
		[delegate.offCampusNavController pushViewController:categoriesTableViewPriceBracketController animated:YES];
	if(viewNum == 6)
		[delegate.offCampusNavController pushViewController:categoriesTableViewPopularController animated:YES];


	if (viewNum == 1) 
		[delegate.offCampusNavController pushViewController:reallyLongListController animated:YES];

}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

//Makes Search all bitch and mean

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller 
shouldReloadTableForSearchString:(NSString *)searchString
{
	[self handleSearchForTerm:searchString];
	
	
	return YES;
}
/*
- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
	[self setSavedSearchTerm:nil];
	
	[[self offCampusArray] reloadData];
}
*/

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
	[searchResults release], searchResults = nil;
	[savedSearchTerm release], savedSearchTerm = nil;
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
		for (NSString *currentString in [self offCampusArray])
		{
			if([currentString rangeOfString:searchTerm options: NSCaseInsensitiveSearch].location != NSNotFound)
			{
				[[self searchResults] addObject:currentString];
			}
		}
	}
}

@end

