//
//  CategoriesDetailViewController.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantDetailViewController.h"
#import "XMLParser.h"
@class CategoriesDetailViewController;
@class RestaurantDetailViewController;


@interface CategoriesDetailViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *categoriesDetailView;
	IBOutlet UITableView *restaurantDetailView;

	
	NSMutableArray *restArray;
	RestaurantDetailViewController *restaurantDetailViewController;
	NSMutableString *queryType;
	NSMutableData *wipData;
	XMLParser *xmlType;

}

@property (nonatomic, retain) NSMutableArray *restArray;
@property (nonatomic, retain) NSMutableString *queryType;
@property (nonatomic, retain) NSObject *xmlPrice;
@property (nonatomic, retain) RestaurantDetailViewController *restaurantDetailViewController;

@end
