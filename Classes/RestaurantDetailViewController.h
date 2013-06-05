//
//  RestaurantDetailViewController.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"

@interface RestaurantDetailViewController : UIViewController {
	
	//CLLocationManager *locationManager;
	
	IBOutlet UIButton *directions;
	IBOutlet UIButton *offers;
	IBOutlet UIButton *callPhone;
	IBOutlet UIButton *nomButton;
	IBOutlet UIButton *flagButton;
	
	Restaurant *rez;
	IBOutlet UILabel *phoneNumber;
	IBOutlet UILabel *rating;
	IBOutlet UILabel *open;
	IBOutlet UILabel *type;
	IBOutlet UILabel *hours;
	IBOutlet UILabel *price;
	IBOutlet UILabel *tigerBucks;
	IBOutlet UILabel *discounts;
	IBOutlet UILabel *address;
}

//@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) UIButton *nomButton;
@property (nonatomic, retain) UIButton *directions;
@property (nonatomic, retain) UIButton *offers;
@property (nonatomic, retain) UIButton *callPhone;
@property (nonatomic, retain) UIButton *flagButton;

@property (nonatomic, retain) Restaurant *rez;

@property (nonatomic, retain) IBOutlet UILabel *phoneNumber;
@property (nonatomic, retain) IBOutlet UILabel *rating;
@property (nonatomic, retain) IBOutlet UILabel *open;
@property (nonatomic, retain) IBOutlet UILabel *type;
@property (nonatomic, retain) IBOutlet UILabel *hours;
@property (nonatomic, retain) IBOutlet UILabel *price;
@property (nonatomic, retain) IBOutlet UILabel *tigerBucks;
@property (nonatomic, retain) IBOutlet UILabel *discounts;
@property (nonatomic, retain) IBOutlet UILabel *address;

-(IBAction) nomIt: (id) sender;
-(IBAction) getDirections: (id) sender;
-(IBAction) getOffers: (id) sender;
-(IBAction) callNumber: (id) sender;
-(IBAction) flagButton: (id) sender;

-(void) setFields;

@end
