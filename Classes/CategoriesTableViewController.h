//
//  CategoriesTableViewController.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoriesDetailViewController;


@interface CategoriesTableViewController : UITableViewController {
	IBOutlet UITableView *categoriesTableView;
	
	NSMutableArray *categoriesArray;
	CategoriesDetailViewController *categoriesDetailViewController;
	NSMutableString *queryType;
	
}

@property (nonatomic, retain) NSMutableArray *categoriesArray;
@property (nonatomic, retain) NSMutableString *queryType;
@property (nonatomic, retain) CategoriesDetailViewController * categoriesDetailViewController;

@end
