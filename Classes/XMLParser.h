//
//  XMLParser.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class NomV4_0AppDelegate, Restaurant;

@interface XMLParser : NSObject<NSXMLParserDelegate> {

	NSMutableString *currentElementValue;
	NSMutableArray *objArray;
	NSMutableString *txt;
	
	NomV4_0AppDelegate	*appDelegate;
	
	Restaurant *currentRestaurant;	
	NSMutableArray *listOfRestaurants;
}

@property (nonatomic, retain) NSMutableArray *objArray;
@property (nonatomic, retain) Restaurant *currentRestaurant;
@property (nonatomic, retain) NSMutableArray *listOfRestaurants;

//- (XMLParser *) initXMLParser;

- (NSMutableArray *) parseDocument:(NSData *) data;

@end
