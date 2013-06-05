//
//  ReallyLongList.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParser.h"
@class RestaurantDetailViewController;


@interface ReallyLongListController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate>{

	IBOutlet UITableView *ridiculouslyLongList;
	IBOutlet UILabel *restNameLabel;
	IBOutlet UILabel *restNomsLabel;
	IBOutlet UILabel *restTypeLabel;
	IBOutlet UITableViewCell *nibLoadedCell;
	
	NSMutableArray *searchResults, *restArray;
	NSMutableArray *offCampusArray;
	NSString *savedSearchTerm;
	NSMutableData *wipData;
	XMLParser *xmlLongList;
	RestaurantDetailViewController *restaurantDetailViewController;

}
@property (nonatomic, retain) NSMutableArray *offCampusArray;
@property (nonatomic, retain) IBOutlet UITableView *ridiculouslyLongList;
@property (nonatomic, retain) UITableViewCell *nibLoadedCell;

@property (nonatomic, retain) NSMutableArray *searchResults;
@property (nonatomic, retain) NSMutableArray *restArray;
@property (nonatomic, retain) RestaurantDetailViewController *restaurantDetailViewController;
@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic, retain) XMLParser *xmlLongList;

- (void)handleSearchForTerm:(NSString *)searchTerm;


@end
