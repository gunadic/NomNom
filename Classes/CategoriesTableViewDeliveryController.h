//
//  CategoriesTableViewDeliveryController.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantDetailViewController.h"
#import "XMLParser.h"


@interface CategoriesTableViewDeliveryController : UITableViewController {

	IBOutlet UITableView *restaurantDetailView;
	
	NSMutableArray *deliveryArray;
	//NSObject *urlCreaterDev;
	NSMutableData *wipData;
	XMLParser *xmlDelivery;
	RestaurantDetailViewController *restaurantDetailViewController;
}

@property (nonatomic, retain) NSMutableArray *deliveryArray;
//@property (nonatomic, retain) NSObject *urlCreaterDev;
@property (nonatomic, retain) NSObject *xmlDelivery;
@property (nonatomic, retain) RestaurantDetailViewController *restaurantDetailViewController;

@end
