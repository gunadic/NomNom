//
//  CategoriesTableViewPriceBracketController.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class CategoriesPriceDetailViewController;
@class CategoriesDetailViewController;


@interface CategoriesTableViewPriceBracketController : UITableViewController {
	
	IBOutlet UITableView *priceTableView;
	
	NSMutableArray *priceArray;
	CategoriesDetailViewController *categoriesDetailViewController;
	NSMutableString* queryPrice;
}

@property (nonatomic, retain) NSMutableArray *priceArray;
@property (nonatomic, retain) NSMutableString *queryPrice;
@property (nonatomic, retain) CategoriesDetailViewController * categoriesDetailViewController;


@end
