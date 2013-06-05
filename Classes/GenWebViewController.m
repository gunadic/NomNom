//
//  GenWebViewController.m
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//


#import "GenWebViewController.h"


@implementation GenWebViewController
@synthesize webPageURL;

//================================================================================================
//  Purpose: This class makes sure that a web view always has something to load even if it can't load
//           the proper website.
//===================================================================================================

-(void) viewDidLoad {

	if (webPageURL == nil) {
		[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.trinity.edu"]]];
	}else {
		[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webPageURL]]];

	}
	
	webView.scalesPageToFit = YES;
	
}


@end
