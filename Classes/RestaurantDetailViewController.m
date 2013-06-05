//
//  RestaurantDetailViewController.m
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "GenWebViewController.h"
#import "URLCreater.h"
#import "Restaurant.h"
#import "URLCreater.h"
#import <UIKit/UIKit.h>

@implementation RestaurantDetailViewController
@synthesize directions;
@synthesize nomButton;
@synthesize offers;
@synthesize callPhone;
@synthesize flagButton;
@synthesize rez;

//================================================================================================
//  Purpose: This class serves to be the controller for the restaurant detail view. It controls
//           what what is shown in the labels. It populates the labels based on the XML input.
//           It also controls the buttons on the view and brings up the corresponding web views 
//           or alert views.
//
//===================================================================================================

NSObject *urlCreator;

-(void) setFields {
	[phoneNumber setText:[NSString stringWithFormat: @"Phone: %@", rez.Phone]];
	[rating setText:[NSString stringWithFormat: @"Noms: %@", rez.NumNoms]];
	[type setText:[NSString stringWithFormat: @"Type: %@", rez.TypeID]];
	[hours setText:[NSString stringWithFormat: @"Hours: %@ to %@", rez.OpenTime, rez.CloseTime]];
	
	if([rez.PriceID isEqualToString:@"0"]){
		[price setText:[NSString stringWithFormat: @"Price: $ ($10 and under)"]];
	} else if ([rez.PriceID isEqualToString:@"1"]) {
		[price setText:[NSString stringWithFormat: @"Price: $$ ($10 to $20)"]];
	} else if ([rez.PriceID isEqualToString:@"2"]){
		[price setText:[NSString stringWithFormat: @"Price: $$$ ($20 and up)"]];
	}
	
	if([rez.TypeID isEqualToString:@"1"]){
		[type setText:[NSString stringWithFormat: @"Type: Mexican"]];
	} else if ([rez.TypeID isEqualToString:@"2"]) {
		[type setText:[NSString stringWithFormat: @"Type: American"]];
	} else if ([rez.TypeID isEqualToString:@"3"]){
		[type setText:[NSString stringWithFormat: @"Type: Fast Food"]];
	} else if ([rez.TypeID isEqualToString:@"4"]){
		[type setText:[NSString stringWithFormat: @"Type: Italian"]];
	} else if ([rez.TypeID isEqualToString:@"5"]){
		[type setText:[NSString stringWithFormat: @"Type: Coffee Shop"]];
	} else if ([rez.TypeID isEqualToString:@"6"]){
		[type setText:[NSString stringWithFormat: @"Type: Bakery/Cafe"]];
	} else if ([rez.TypeID isEqualToString:@"7"]){
		[type setText:[NSString stringWithFormat: @"Type: Sandwiches"]];
	} else if ([rez.TypeID isEqualToString:@"8"]){
		[type setText:[NSString stringWithFormat: @"Type: Variety"]];
	} else if ([rez.TypeID isEqualToString:@"9"]){
		[type setText:[NSString stringWithFormat: @"Type: Asian"]];
	} else if ([rez.TypeID isEqualToString:@"10"]){
		[type setText:[NSString stringWithFormat: @"Type: Dessert"]];
	} else if ([rez.TypeID isEqualToString:@"11"]){
		[type setText:[NSString stringWithFormat: @"Type: International"]];
	}
	
	if([rez.TigerBucks isEqualToString:@"1"]){
		[tigerBucks setText:[NSString stringWithFormat: @"Accepts Tigerbucks"]];
	} else {
		[tigerBucks setText:[NSString stringWithFormat: @" "]];
	}
	
	if([rez.Coupons isEqualToString:@"0"]){
		//NSLog(@"No noms for j00!");
		[discounts setText:[NSString stringWithFormat: @"Student Discounts: No"]];
	} else {
		[discounts setText:[NSString stringWithFormat: @"Student Discounts: Yes"]];

	}
	address.numberOfLines = 2;
	[address setText:[NSString stringWithFormat: @"%@", rez.Address]];
		
	NSDate *currentDate = [NSDate date];
		
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"HH:mm:ss"];
	NSDate *date = [dateFormat dateFromString:rez.OpenTime]; 
		
	BOOL openNow = [currentDate compare:date];
		
	if(openNow){
		[open setText:[NSString stringWithFormat: @"Open"]];
		[open setTextColor: [UIColor greenColor]];
	} else {
		[open setText:[NSString stringWithFormat: @"Closed"]];
		[open setTextColor: [UIColor redColor]];
	}
}

//NOM BUTTON FUNCTIONALITY
-(IBAction) nomIt : (id) sender{
	//NSLog(@"Nom Button event Fired.");
	
	NSString* query = [NSString stringWithFormat: @"UPDATE RestDB SET NumNoms = NumNoms + 1 WHERE Name = ?"];
	//NSLog(@"SQL query: %@", query);
	NSString* args = rez.Name;
	
	URLCreater *urlCreater = [[URLCreater alloc] init];
	
	NSURL *url = [urlCreater buildOurURL:query :args];
		
	NSURLRequest *req = [NSURLRequest requestWithURL:url
										 cachePolicy:NSURLRequestReloadIgnoringCacheData
									 timeoutInterval:30.0];
	
	[NSURLConnection connectionWithRequest:req delegate:self];
	//NSLog(@" int value of numNoms: %d", [rez.NumNoms intValue]);
	int funzies = [rez.NumNoms intValue];
	funzies+=1;
	//NSLog(@"Incremented Funzies:%d", funzies);
	[rating setText:[NSString stringWithFormat: @"Noms: %d", funzies]];
	rez.NumNoms = [NSString stringWithFormat:@"%d", funzies];
	[nomButton setEnabled: NO];
	nomButton.hidden = YES;
	
	//Get field of particular restaurant details, execute a query that updates nom field

}

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

		}
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	NSLog(@"Connection failed");
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//DIRECTION BUTTON FUNCTIONALITY
-(IBAction) getDirections: (id) sender{
	//NSLog(@"Button getDirections event Fired.");
	//CLLocationCoordinate2D currentLocation = [self getCurrentLocation];
	NSString* mapsAddress = rez.Address;
	NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=Current+Location&daddr=%@",
					 [mapsAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
}
//OFFERS BUTTON FUNCTIONALITY
-(IBAction) getOffers: (id) sender{
	//NSLog(@"Button getOffers event Fired.");
	GenWebViewController *webView = [[[GenWebViewController alloc] initWithNibName:@"GenWebView" bundle:nil] autorelease];
	webView.webPageURL = @"http://iraa.trinity.edu/iraa/x512.xml";
	webView.title = NSLocalizedString(@"Offers", @"Restaurant Stuff");
	[self.navigationController pushViewController:webView animated:YES];

}
//PHONE BUTTON FUNCTIONALITY
-(IBAction) callNumber: (id) sender{
	//NSLog(@"Button callNumber event Fired.");
    NSString *phoneLinkString = [NSString stringWithFormat:@"tel:%@", rez.Phone];
    NSURL *phoneLinkURL = [NSURL URLWithString:phoneLinkString];
    [[UIApplication sharedApplication] openURL:phoneLinkURL];
		
}
//FLAG BUTTON FUNCTIONALITY
-(IBAction) flagButton: (id) sender{
	//NSLog(@"Flag Button event Fired.");
	NSString* query = [NSString stringWithFormat: @"UPDATE RestDB SET Flagged=1, timesFlagged = timesFlagged + 1 WHERE Name = ?"];
	//NSLog(@"SQL query: %@", query);
	NSString* args = rez.Name;
	
	URLCreater *urlCreater = [[URLCreater alloc] init];
	
	NSURL *url = [urlCreater buildOurURL:query :args];
	
	NSURLRequest *req = [NSURLRequest requestWithURL:url
										 cachePolicy:NSURLRequestReloadIgnoringCacheData
									 timeoutInterval:30.0];
	
	[NSURLConnection connectionWithRequest:req delegate:self];
	
	UIAlertView *temp = [[UIAlertView alloc] initWithTitle:@"Entry Flagged!" message:@"This entry has been flagged for review. A moderator will check to make sure that all of the information is correct."
												  delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[temp show];
	[temp release];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[nomButton setEnabled:YES];
	nomButton.hidden = NO;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {	
	[rez release];
    [super dealloc];
}


@end
