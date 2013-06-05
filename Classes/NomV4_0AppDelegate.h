//
//  NomV4_0AppDelegate.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OffCampusNavController;
//@class OnCampusTableViewController;
@class OnCampusNavController;
@class CategoriesNavController;

@interface NomV4_0AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	IBOutlet UIViewController *loginController;
	IBOutlet UITabBarController *rootController;
	IBOutlet OffCampusNavController *offCampusNavController;
	IBOutlet OnCampusNavController *onCampusNavController;
	IBOutlet CategoriesNavController *categoriesNavController;
	//IBOutlet OnCampusTableViewController *onCampusTableViewController; 
	IBOutlet UIView *splashPage;
	
	NSMutableArray *restaurants;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;
@property (nonatomic, retain) IBOutlet OffCampusNavController *offCampusNavController;
@property (nonatomic, retain) IBOutlet OnCampusNavController *onCampusNavController;
@property (nonatomic, retain) IBOutlet CategoriesNavController *categoriesNavController;
@property (nonatomic, retain) IBOutlet UIView *splashPage;

@property (nonatomic, retain) NSMutableArray *restaurants;

@end

