//
//  Restaurant.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Restaurant : NSObject {
	

	NSMutableString *Name;	//Same name as the Entity Name.
	NSMutableString *Address;	//Same name as the Entity Name.
	NSMutableString *Phone;
	NSMutableString *NumNoms;
	NSMutableString *PriceID;
	NSMutableString *OpenTime;
	NSMutableString *CloseTime;
	NSMutableString *TypeID;
	NSMutableString *imgURL;
	NSMutableString *Coupons;
	NSMutableString *Specials;
	NSMutableString *Flagged;
	NSMutableString *timesFlagged;
	NSMutableString *Delivery;
	NSMutableString *TigerBucks;
	
		
}

//@property (nonatomic, readwrite) NSInteger		  *RestID;
@property (nonatomic, retain) NSMutableString *Name;
@property (nonatomic, retain) NSMutableString *Address;
@property (nonatomic, retain) NSMutableString *Phone;
@property (nonatomic, retain) NSMutableString *NumNoms;
@property (nonatomic, retain) NSMutableString *PriceID;
@property (nonatomic, retain) NSMutableString *OpenTime;
@property (nonatomic, retain) NSMutableString *CloseTime;
@property (nonatomic, retain) NSMutableString *TypeID;
@property (nonatomic, retain) NSMutableString *imgURL;
@property (nonatomic, retain) NSMutableString *Coupons;
@property (nonatomic, retain) NSMutableString *Specials;
@property (nonatomic, retain) NSMutableString *Flagged;
@property (nonatomic, retain) NSMutableString *timesFlagged;
@property (nonatomic, retain) NSMutableString *Delivery;
@property (nonatomic, retain) NSMutableString *TigerBucks;

@end
