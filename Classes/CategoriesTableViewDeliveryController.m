//
//  CategoriesTableViewDeliveryController.m
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import "CategoriesTableViewDeliveryController.h"
#import "RestaurantDetailViewController.h"
#import "URLCreater.h"
#import "XMLParser.h"
#import "Restaurant.h"
#import "NomV4_0AppDelegate.h"


@implementation CategoriesTableViewDeliveryController
@synthesize deliveryArray;
@synthesize restaurantDetailViewController;
@synthesize xmlDelivery;

//================================================================================================
//  Purpose: This class serves to be the controller for the categories view of the off campus 
//           portion. It displays the list of restaurants in the DB that deliver to campus. It  
//           queries the database. It then loads another table view displaying the  
//           results of the query which then will load the restaurant detail view if chosen.
//
//===================================================================================================

NSMutableArray *xmlData;
NSObject *urlCreaterDev;
int xmlLoaded = 0;

#pragma mark -
#pragma mark Initialization

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
	
	xmlData = [[NSMutableArray alloc] init];
	
	//THIS ONE WORKS
	NSString* queryDelivery = @"SELECT * FROM `RestDB`WHERE `Delivery` =1 ORDER BY Name ASC";
	NSString* argsDelivery = @"";
	
	URLCreater *urlCreaterDev = [[URLCreater alloc] init];
	

	NSURL *urlDev = [urlCreaterDev buildOurURL:queryDelivery :argsDelivery];
	
	NSURLRequest *req = [NSURLRequest requestWithURL:urlDev
										 cachePolicy:NSURLRequestReloadIgnoringCacheData
									 timeoutInterval:30.0];
	[NSURLConnection connectionWithRequest:req delegate:self];
	
	
	self.deliveryArray = xmlData;
	
	
	self.title = NSLocalizedString(@"Delivery", @"Trinity's Favorite Restaurants");
	
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
    return [self.deliveryArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSInteger row = [indexPath row];
	Restaurant  *contentForThisRow = nil;		
	
	contentForThisRow = [[self deliveryArray] objectAtIndex:row];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
	{
		
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	[[cell textLabel] setText:contentForThisRow.Name];
	
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
	
	Restaurant *tmp = [[Restaurant alloc] init];
	tmp = [[self deliveryArray] objectAtIndex:row];
	restaurantDetailViewController.title = [NSString stringWithFormat: @"%@", tmp.Name];
	
	NomV4_0AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.offCampusNavController pushViewController:restaurantDetailViewController animated:YES];
	
	//Place Updates to Label after loading of the View
	NSLog(@"Phone Number wanna be: %@", tmp.Phone);
	restaurantDetailViewController.rez = tmp;
	[restaurantDetailViewController setFields];
	[tmp release];
	restaurantDetailViewController = nil;
}

//===============================================================================
//CONNECTION STUFF
//===============================================================================

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
	NSString *xml = [[NSString alloc] initWithData:wipData encoding:NSUTF8StringEncoding];
	//NSLog(@"xml = %@", xml);
	[xml release];
	
	xmlDelivery = [[XMLParser alloc] init];
	
	[deliveryArray removeAllObjects];
	deliveryArray = [xmlDelivery parseDocument:wipData];
	
	[self.tableView reloadData];
	
	xmlLoaded=1;
	//NSLog(@"Loaded set to 1");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	NSLog(@"Connection failed");
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//===============================================================================
//END OF CONNECTION STUFF
//===============================================================================

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
}


- (void)dealloc {
	[restaurantDetailViewController release];
    [super dealloc];
}


@end

