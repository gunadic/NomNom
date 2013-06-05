//
//  ReallyLongList.m
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//


#import "ReallyLongListController.h"
#import "OffCampusTableViewController.h"
#import "CategoriesDetailViewController.h"
#import "CategoriesTableViewController.h"
#import "CategoriesTableViewDeliveryController.h"
#import "RestaurantDetailViewController.h"
#import "Nomv4_0AppDelegate.h"
#import "Restaurant.h"
#import "XMLParser.h"
#import "URLCreater.h"

@implementation ReallyLongListController 
@synthesize restArray;
@synthesize searchResults;
@synthesize restaurantDetailViewController;
@synthesize savedSearchTerm, xmlLongList, offCampusArray;
@synthesize ridiculouslyLongList;
@synthesize nibLoadedCell;

//================================================================================================
//  Purpose: This class serves to be the controller for the categories view of the off campus 
//           portion. It displays the full list of restaurants available. It  
//           queries the database accordingly. It then loads another table view displaying the  
//           results of the query which then will load the restaurant detail view if chosen.
//
//===================================================================================================

NSMutableArray *dbData;
NSObject *urlCreater;
int loaded = 0;

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
	
	dbData = [[NSMutableArray alloc] init];
	
	//THIS ONE WORKS
	NSString* query = @"SELECT * FROM `RestDB`ORDER BY `Name` ASC";
	NSString* args = @"";
	
	URLCreater *urlCreater = [[URLCreater alloc] init];
	
	NSURL *url = [urlCreater buildOurURL:query :args];
	
	NSURLRequest *req = [NSURLRequest requestWithURL:url
										 cachePolicy:NSURLRequestReloadIgnoringCacheData
									 timeoutInterval:30.0];
	
	[NSURLConnection connectionWithRequest:req delegate:self];

	self.title = NSLocalizedString(@"All Restaurants", @"Restaurant Categories");
		
	if ([self savedSearchTerm])
	{
		[[[self searchDisplayController] searchBar] setText:[self savedSearchTerm]];
	}
	
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
		rows = [[self restArray] count];
	}
	
    return rows;}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55; // your dynamic height...
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSInteger row = [indexPath row];
	Restaurant  *contentForThisRow = nil;
	
	if (tableView == [[self searchDisplayController] searchResultsTableView]) {
		contentForThisRow = [[self searchResults] objectAtIndex:row];
	}
	else {
		contentForThisRow = [[self restArray] objectAtIndex:row];
	}
	
    static NSString *CellIdentifier = @"nomCustomCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
	{
		[[NSBundle mainBundle] loadNibNamed:@"customCell" owner:self options: NULL];
		cell=nibLoadedCell;
	}
    
    // Configure the cell...
	UILabel *tempRestNameLabel = (UILabel *)[cell viewWithTag:100];
	tempRestNameLabel.text = contentForThisRow.Name;
	UILabel *tempNomLabel = (UILabel *) [cell viewWithTag:101];
	NSString* tempTemp = [NSString stringWithFormat: @"%@ noms", contentForThisRow.NumNoms];

	tempNomLabel.text = tempTemp;
	UILabel *tempTypeLabel = (UILabel *) [cell viewWithTag:102];
	tempTypeLabel.text = contentForThisRow.TypeID;
	
	if([contentForThisRow.TypeID isEqualToString:@"1"]){
		tempTypeLabel.text =[NSString stringWithFormat: @"Mexican"];
	} else if ([contentForThisRow.TypeID isEqualToString:@"2"]) {
		tempTypeLabel.text =[NSString stringWithFormat: @"American"];
	} else if ([contentForThisRow.TypeID isEqualToString:@"3"]){
		tempTypeLabel.text =[NSString stringWithFormat: @"Fast Food"];
	} else if ([contentForThisRow.TypeID isEqualToString:@"4"]){
		tempTypeLabel.text =[NSString stringWithFormat: @"Italian"];
	} else if ([contentForThisRow.TypeID isEqualToString:@"5"]){
		tempTypeLabel.text =[NSString stringWithFormat: @"Coffee Shop"];
	} else if ([contentForThisRow.TypeID isEqualToString:@"6"]){
		tempTypeLabel.text =[NSString stringWithFormat: @"Bakery/Cafe"];
	} else if ([contentForThisRow.TypeID isEqualToString:@"7"]){
		tempTypeLabel.text =[NSString stringWithFormat: @"Sandwiches"];
	} else if ([contentForThisRow.TypeID isEqualToString:@"8"]){
		tempTypeLabel.text =[NSString stringWithFormat: @"Variety"];
	} else if ([contentForThisRow.TypeID isEqualToString:@"9"]){
		tempTypeLabel.text =[NSString stringWithFormat: @"Asian"];
	} else if ([contentForThisRow.TypeID isEqualToString:@"10"]){
		tempTypeLabel.text =[NSString stringWithFormat: @"Dessert"];
	} else if ([contentForThisRow.TypeID isEqualToString:@"11"]){
		tempTypeLabel.text =[NSString stringWithFormat: @"International"];
	}
	
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }

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

 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }

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

-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
	[self setSavedSearchTerm:nil];
	
	[[self ridiculouslyLongList] reloadData];
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
	Restaurant *contentForThisRow = nil;
	
	if(tableView == [[self searchDisplayController] searchResultsTableView])
		contentForThisRow = [[self searchResults] objectAtIndex:row];
	else
		contentForThisRow = [[self restArray] objectAtIndex:row];
	
	if (self.restaurantDetailViewController == nil){
		RestaurantDetailViewController *aRestaurantDetail = [[RestaurantDetailViewController alloc] initWithNibName:@"RestaurantDetailView" bundle:nil];
		self.restaurantDetailViewController = aRestaurantDetail;
		[aRestaurantDetail release];
	}
	
	restaurantDetailViewController.title = [NSString stringWithFormat: @"%@", contentForThisRow.Name];
	
	NomV4_0AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.offCampusNavController pushViewController:restaurantDetailViewController animated:YES];
	
	//Place Updates to Label after loading of the View
	//NSLog(@"Phone Number wanna be: %@", contentForThisRow.Phone);
	restaurantDetailViewController.rez = contentForThisRow;
	[restaurantDetailViewController setFields];
	[contentForThisRow release];
	restaurantDetailViewController = nil;
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
	[ridiculouslyLongList release];
	ridiculouslyLongList = nil;
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
		for (Restaurant *data in [self restArray])
		{
			if([data.Name rangeOfString:searchTerm options: NSCaseInsensitiveSearch].location != NSNotFound)
			{
				[[self searchResults] addObject:data];
			}
		}
	}
}

//Status of connection status stuff
//TODO - move this stuff to a seperate file?
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	
	NSLog(@"Received Response");
	
	if([response isKindOfClass:[NSHTTPURLResponse class]]){
		NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
		int status = [httpResponse statusCode];
		
		if (!((status >= 200) && (status<300))) {
			NSLog(@"Connection failed with status %@", status);
			[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		}
		else {
			//make the working space for the REST data buffer. This could also be a file if youwant to redue the RAM footprint
			[wipData release];
			wipData = [[NSMutableData alloc] initWithCapacity:1024];
		}
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	[wipData appendData:data];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)conn {
	NSLog(@"Connection Finish Loading");
	
	NSString *xml = [[NSString alloc] initWithData:wipData encoding:NSUTF8StringEncoding];
	//NSLog(@"xml = %@", xml);
	[xml release];
	
	xmlLongList = [[XMLParser alloc] init];
	
	NSMutableArray *offCampusArrayHolder = [[[NSMutableArray alloc] init] retain];
	//NSLog(@"Before %@", [offCampusArray count]);
	
	[restArray removeAllObjects];
	restArray = [xmlLongList parseDocument:wipData];
	
	[self.tableView reloadData];
	
	loaded=1;
	//NSLog(@"Loaded set to 1");
	 
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	NSLog(@"Connection failed");
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//End of extra connection status stuff

@end
