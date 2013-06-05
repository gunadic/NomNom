//
//  CategoriesTableViewPriceBracketController.m
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//


#import "CategoriesTableViewPriceBracketController.h"
#import "CategoriesDetailViewController.h"
#import "NomV4_0AppDelegate.h"

@implementation CategoriesTableViewPriceBracketController
@synthesize priceArray;
@synthesize categoriesDetailViewController;
@synthesize queryPrice;

//================================================================================================
//  Purpose: This class serves to be the controller for the categories view of the off campus 
//           portion. It displays the list of price bracket of restaurants available. It  
//           queries the database accordingly. It then loads another table view displaying the  
//           results of the query which then will load the restaurant detail view if chosen.
//
//===================================================================================================


#pragma mark -
#pragma mark View lifecycle

int viewNumPrice = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = NSLocalizedString(@"Restaurant Prices", @"Restaurant Categories");
	
	NSMutableArray *array = [[NSArray alloc] initWithObjects:@"$1 - $10", @"$11 -$20", @"$20+", nil];
	self.priceArray = array;
	[array release];
	

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
    // Return YES for supported orientations.
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
    return [self.priceArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	NSUInteger row = [indexPath row];
	cell.textLabel.text = [priceArray objectAtIndex:row];
    
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
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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
	if (self.categoriesDetailViewController == nil){
		CategoriesDetailViewController *aCategoryDetail = [[CategoriesDetailViewController alloc] initWithNibName:@"CategoriesDetailView" bundle:nil];
		self.categoriesDetailViewController = aCategoryDetail;
		[aCategoryDetail release];
	}
	categoriesDetailViewController.title = [NSString stringWithFormat: @"%@", [priceArray objectAtIndex:row]];
	
	NomV4_0AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
		
	//MAKING DIFFERENT QUERIES FOR THE DIFFERENT PRICE BRACKETS
	
	if([[priceArray objectAtIndex:row] isEqualToString:@"$1 - $10"]){
		categoriesDetailViewController.queryType = [NSString stringWithFormat:@"SELECT * FROM `RestDB`WHERE `PriceID` =1 OR `PriceID` =0 ORDER BY Name ASC"];
	}
	else if([[priceArray objectAtIndex:row] isEqualToString:@"$11 -$20"]){
		categoriesDetailViewController.queryType = [NSString stringWithFormat:@"SELECT * FROM `RestDB`WHERE `PriceID` =2 ORDER BY Name ASC"];
	}
	else if([[priceArray objectAtIndex:row] isEqualToString:@"$20+"]){
		categoriesDetailViewController.queryType= [NSString stringWithFormat:@"SELECT * FROM `RestDB`WHERE `PriceID` =3 ORDER BY Name ASC"];
	}
	
	[delegate.offCampusNavController pushViewController:categoriesDetailViewController animated:YES];
	categoriesDetailViewController = nil;
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}


@end

