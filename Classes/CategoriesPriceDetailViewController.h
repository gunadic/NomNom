//
//  CategoriesPriceDetailViewController.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantDetailViewController.h"
#import "XMLParser.h"

//@class CategoriesPriceDetailViewController;
//@class RestaurantDetailViewController;


@interface CategoriesPriceDetailViewController : UITableViewController {

	IBOutlet UITableView *categoriesPriceDetailView;
	IBOutlet UITableView *restaurantDetailView;
	
	NSMutableArray *restArray;
	NSMutableData *wipData;
	XMLParser *xmlPrice;
	NSMutableString *queryPrice;

	RestaurantDetailViewController *restaurantDetailViewController;
}

@property (nonatomic, retain) NSMutableArray *restArray;
@property (nonatomic, retain) NSObject *xmlPrice;
@property (nonatomic, retain) NSMutableString *queryPrice;
@property (nonatomic, retain) RestaurantDetailViewController *restaurantDetailViewController;

@end
