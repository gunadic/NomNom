//
//  CategoriesTableViewPopularController.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantDetailViewController.h"
#import "XMLParser.h"


@interface CategoriesTableViewPopularController : UITableViewController {

	IBOutlet UITableView *restaurantDetailView;
	
	NSMutableArray *popularArray;
	//NSObject *urlCreaterDev;
	NSMutableData *wipData;
	XMLParser *xmlPopular;
	RestaurantDetailViewController *restaurantDetailViewController;
	
}

@property (nonatomic, retain) NSMutableArray *popularArray;
//@property (nonatomic, retain) NSObject *urlCreaterDev;
@property (nonatomic, retain) NSObject *xmlPopular;
@property (nonatomic, retain) RestaurantDetailViewController *restaurantDetailViewController;

@end
