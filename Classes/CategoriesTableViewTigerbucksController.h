//
//  CategoriesTableViewTigerbucksController.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantDetailViewController.h"
#import "XMLParser.h"


@interface CategoriesTableViewTigerbucksController : UITableViewController {

	IBOutlet UITableView *restaurantDetailView;
	
	NSMutableArray *tigerBucksArray;
	//NSObject *urlCreaterTigerBucks;
	NSMutableData *wipData;
	XMLParser *xmlTigerBucks;
	RestaurantDetailViewController *restaurantDetailViewController;
}

@property (nonatomic, retain) NSMutableArray *tigerBucksArray;
//@property (nonatomic, retain) NSObject *urlCreaterTigerBucks;
@property (nonatomic, retain) NSObject *xmlTigerBucks;
@property (nonatomic, retain) RestaurantDetailViewController *restaurantDetailViewController;

@end
