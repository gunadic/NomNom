//
//  BrowseList.h
//
//  Created by Administrator on 2/13/11.
//  Copyright 2011 Trinity University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class RestaurantDetailViewController;

@interface BrowseListController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate>{
	
	IBOutlet UITableView *browseList;
	
	NSMutableArray *searchResults, *restArray;
	NSString *savedSearchTerm;
	RestaurantDetailViewController *restaurantDetailViewController;
	
}

@end
