//
//  Restaurant.m
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Restaurant.h"


@implementation Restaurant

//================================================================================================
//  Purpose: This class is to create a restaurant object where we store the different attributes
//           of the restaurants. This makes it easier for accessing it when we want to load 
//           different restaurant detail views.
//===================================================================================================

@synthesize  Name, Address, Phone, NumNoms, PriceID, OpenTime, CloseTime, TypeID, imgURL, Coupons, Specials, Flagged, timesFlagged, Delivery, TigerBucks;

- (void) dealloc {
	//[RestID		release];
	[Name		release];
	[Address	release];
	[Phone		release];
	[NumNoms	release];
	[PriceID	release];
	[OpenTime	release];
	[CloseTime	release];
	[TypeID		release];
	[imgURL		release];
	[Coupons	release];
	[Specials	release];
	[Flagged	release];
	[timesFlagged release];
	[Delivery	release];
	[TigerBucks	release];
	[super dealloc];
}

@end