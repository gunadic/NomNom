//
//  OnCampusTableViewController.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OnCampusDetailViewController;


@interface OnCampusTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>{
	IBOutlet UITableView *onCampusTableView;
	
	NSMutableArray *onCampusArray;
	OnCampusDetailViewController *onCampusDetailViewController;
}

@property (nonatomic, retain) NSMutableArray *onCampusArray;
@property (nonatomic, retain) OnCampusDetailViewController *onCampusDetailViewController;

@end
