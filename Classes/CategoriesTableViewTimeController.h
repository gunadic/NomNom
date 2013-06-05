//
//  CategoriesTableViewTimeController.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantDetailViewController.h"
#import "XMLParser.h"


@interface CategoriesTableViewTimeController : UITableViewController {
	
	IBOutlet UITableView *restaurantDetailView;
	
	NSMutableArray *timesArray;
	//NSObject *urlCreaterTigerBucks;
	NSMutableData *wipData;
	XMLParser *xmlTimes;
	RestaurantDetailViewController *restaurantDetailViewController;
}
@property (nonatomic, retain) NSMutableArray *timesArray;
//@property (nonatomic, retain) NSObject *urlCreaterTigerBucks;
@property (nonatomic, retain) NSObject *xmlTimes;
@property (nonatomic, retain) RestaurantDetailViewController *restaurantDetailViewController;


@end
