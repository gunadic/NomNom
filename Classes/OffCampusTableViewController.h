//
//  OffCampusTableViewController.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RestaurantDetailViewController;
@class CategoriesTableViewController;
@class CategoriesTableViewDeliveryController;
@class CategoriesTableViewTigerbucksController;
@class CategoriesTableViewTimeController;
@class CategoriesTableViewPriceBracketController;
@class CategoriesTableViewPopularController;
@class ReallyLongListController;
@class Restaurant;
@class XMLParser;

@interface OffCampusTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate, NSXMLParserDelegate>{
	IBOutlet UITableView *offCampusTableView;
	IBOutlet UITableView *categoriesTableViewDelivery;
	IBOutlet UITableView *categoriesTableViewTigerbucks;
	IBOutlet UITableView *categoriesTableViewTime; 
	IBOutlet UITableView *categoriesTableViewPriceBracket;
	IBOutlet UITableView *categoriesTableViewPopular;
	
	NSMutableArray *offCampusArray;
	NSMutableArray *searchResults;
	NSMutableData *wipData;
	NSString *savedSearchTerm;
	
	//NSMutableArray *restaurants;
	
	RestaurantDetailViewController *restaurantDetailViewController;
	CategoriesTableViewController *categoriesTableViewController;
	CategoriesTableViewDeliveryController *categoriesTableViewDeliveryController;
	CategoriesTableViewTigerbucksController *categoriesTableViewTigerbucksController;
	CategoriesTableViewTimeController *categoriesTableViewTimeController; 
	CategoriesTableViewPriceBracketController *categoriesTableViewPriceBracketController;
	CategoriesTableViewPopularController *categoriesTableViewPopularController;
	ReallyLongListController *reallyLongListController;
}

@property (nonatomic, retain) NSMutableArray *offCampusArray;
@property (nonatomic, retain) RestaurantDetailViewController *restaurantDetailViewController;
@property (nonatomic, retain) CategoriesTableViewController *categoriesTableViewController;
@property (nonatomic, retain) CategoriesTableViewDeliveryController *categoriesTableViewDeliveryController;
@property (nonatomic, retain) CategoriesTableViewTigerbucksController *categoriesTableViewTigerbucksController;
@property (nonatomic, retain) CategoriesTableViewTimeController *categoriesTableViewTimeController;
@property (nonatomic, retain) CategoriesTableViewPriceBracketController *categoriesTableViewPriceBracketController;
@property (nonatomic, retain) CategoriesTableViewPopularController *categoriesTableViewPopularController;
@property (nonatomic, retain) ReallyLongListController *reallyLongListController;
@property (nonatomic, retain) NSMutableArray *searchResults;
@property (nonatomic, copy) NSString *savedSearchTerm;

- (void)handleSearchForTerm:(NSString *)searchTerm;
- (void)parseDocument:(NSData *)data;
- (void)updateTable:(NSArray *)data;

@end
