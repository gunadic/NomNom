//
//  OnCampusTableViewController.m
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import "OnCampusTableViewController.h"
#import "OnCampusDetailViewController.h"
#import "Nomv4_0AppDelegate.h"
#import "GenWebViewController.h"

@implementation OnCampusTableViewController
@synthesize onCampusArray;
@synthesize onCampusDetailViewController;

//===================================================================================================
//  Purpose: This class serves to be the controller for the top view of the on campus portion. It
//           controls what what is shown in the first table view. The labels are pre-populated from 
//           an array. It also controls what view is loaded next depending on the option that  
//           is selected.
//
//===================================================================================================

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

    self.title = NSLocalizedString(@"On Campus", @"Trinity's On Campus Options");
	
	NSMutableArray *array = [[NSArray alloc] initWithObjects:@"Dining Hall Hours", @"Daily Menus", @"Specials", @"Dine Money Balance", 
							 @"Average Dine Money Left", nil];
	self.onCampusArray = array;
	[array release];
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
    return [self.onCampusArray count];
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
	cell.textLabel.text = [onCampusArray objectAtIndex:row];
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
	
	NomV4_0AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	GenWebViewController *webView = nil;
	
	if([[onCampusArray objectAtIndex:row] isEqualToString:@"Dining Hall Hours"]){ 
		self.onCampusDetailViewController = [[OnCampusDetailViewController alloc] initWithNibName:@"OnCampusDetailViewHours" bundle:nil];
	}
	else if([[onCampusArray objectAtIndex:row] isEqualToString:@"Daily Menus"]){ 
		webView = [[[GenWebViewController alloc] initWithNibName:@"GenWebView" bundle:nil] autorelease];
		webView.webPageURL = @"http://www.campusdish.com/en-US/CSSW/TrinityUniv/Menus/";
		self.onCampusDetailViewController = nil;
	}
	if([[onCampusArray objectAtIndex:row] isEqualToString:@"Specials"]){
		self.onCampusDetailViewController = [[OnCampusDetailViewController alloc] initWithNibName:@"OnCampusDetailViewSpecials" bundle:nil];
	}
	
	if([[onCampusArray objectAtIndex:row] isEqualToString:@"Dine Money Balance"]){
		webView = [[[GenWebViewController alloc] initWithNibName:@"GenWebView" bundle:nil] autorelease];
		webView.webPageURL = @"https://trinity.managemyid.com/reference.dca?cdx=login";
		self.onCampusDetailViewController = nil;
		
	}
	
	if([[onCampusArray objectAtIndex:row] isEqualToString:@"Average Dine Money Left"]){ 
		self.onCampusDetailViewController = [[OnCampusDetailViewController alloc] initWithNibName:@"OnCampusDetailViewAvg" bundle:nil];
	}
	
	onCampusDetailViewController.title = [NSString stringWithFormat: @"%@", [onCampusArray objectAtIndex:row]];
	if(webView != nil && self.onCampusDetailViewController == nil) {
		[delegate.onCampusNavController pushViewController:webView animated:YES];
	} else if(self.onCampusDetailViewController != nil) {
		[delegate.onCampusNavController pushViewController:onCampusDetailViewController animated:YES];
	} else {
		NSLog(@"Something really bad happened!");
	}
	webView= nil;
	self.onCampusDetailViewController = nil;
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

}


- (void)dealloc {
	[onCampusDetailViewController release];
    [super dealloc];
}


@end

