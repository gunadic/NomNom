//
//  XMLParser.m
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import "XMLParser.h"
#import "Restaurant.h"
#import "NomV4_0AppDelegate.h"


@implementation XMLParser
@synthesize objArray, currentRestaurant, listOfRestaurants;

//================================================================================================
//  Purpose: This class is the abstracted out XML Parser. It reads the XML returned by the server;
//           then it looks for specfic XML tags and starts to parse the information accordingly. It
//           also puts all the individual restaurants' attributes into their respective fields in the
//           restaurant object.
//===================================================================================================

NSMutableArray *xmlData;

NSMutableString *currentStringValue;
Restaurant *rez;
//========================================================================================

NSMutableString *curElem;
- (NSMutableArray *) parseDocument:(NSData *) data {
	listOfRestaurants = [[NSMutableArray alloc] initWithCapacity:500];
	
	NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:data];
	[myParser setDelegate:self];
	
	//NSLog(@"Length of Dudes = %d",[listOfRestaurants count]);

	[myParser parse];
	
	[myParser release];
	//NSLog(@"AFTER Length of Dudes = %d",[listOfRestaurants count]);

	for (Restaurant *rez2 in listOfRestaurants) {
		NSLog(@"Rez Name within ListOfRez: %@", rez2.Name);
	}
	return listOfRestaurants;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	if ( [elementName isEqualToString:@"row"]) {
		rez = [[Restaurant alloc] init];
        return;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (!currentStringValue) {
        // currentStringValue is an NSMutableString instance variable
        currentStringValue = [[NSMutableString alloc] initWithCapacity:50];
    }
    [currentStringValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	//Trims the beginning and end of Whitespace, NewLines, and Tab type characters.
	currentStringValue = [currentStringValue stringByTrimmingCharactersInSet:
	 [NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	if ([elementName isEqualToString:@"row"]) {
		[listOfRestaurants addObject:rez];
	}/*else if([elementName isEqualToString:@"RestID"]){ 
		rez.RestID = currentStringValue;
	}*/else if ([elementName isEqualToString:@"Name"]) {
		rez.Name = currentStringValue;
	} else if ([elementName isEqualToString:@"Address"]) {
		rez.Address = currentStringValue;
	} else if ([elementName isEqualToString:@"Phone"]) {
		rez.Phone = currentStringValue;
	} else if ([elementName isEqualToString:@"NumNoms"]) {
		rez.NumNoms = currentStringValue;
	} else if ([elementName isEqualToString:@"PriceID"]) {
		rez.PriceID = currentStringValue;
	} else if ([elementName isEqualToString:@"OpenTime"]) {
		rez.OpenTime = currentStringValue;
	} else if ([elementName isEqualToString:@"CloseTime"]) {
		rez.CloseTime = currentStringValue;
	} else if ([elementName isEqualToString:@"TypeID"]) {
		rez.TypeID = currentStringValue;
	} else if ([elementName isEqualToString:@"imgURL"]) {
		rez.imgURL = currentStringValue;
	} else if ([elementName isEqualToString:@"Coupons"]) {
		rez.Coupons = currentStringValue;
	} else if ([elementName isEqualToString:@"Specials"]) {
		rez.Specials = currentStringValue;
	} else if ([elementName isEqualToString:@"Flagged"]) {
		rez.Flagged = currentStringValue;
	} else if ([elementName isEqualToString:@"timesFlagged"]) {
		rez.timesFlagged = currentStringValue;
	} else if ([elementName isEqualToString:@"Delivery"]) {
		rez.Delivery = currentStringValue;
	} else if ([elementName isEqualToString:@"TigerBucks"]) {
		rez.TigerBucks = currentStringValue;
	}
	else {
		//NSLog(@"Something Went Wrong!!!");
	}
	
	//NSLog(@"Test of String without Whitespace :: %@", currentStringValue);
	currentStringValue = [[NSMutableString alloc] initWithCapacity:50];
}

@end
