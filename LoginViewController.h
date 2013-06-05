//
//  LoginViewController.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate> {
	IBOutlet UIView *loginView;
	IBOutlet UITextField *loginID;
	IBOutlet UITextField *loginPWD;
	IBOutlet UIButton *goButton;
	IBOutlet UIButton *cancelButton;

}

@property (nonatomic, retain) UITextField *loginID;
@property (nonatomic, retain) UITextField *loginPWD;
@property (nonatomic, retain) UIButton *goButton;
@property (nonatomic, retain) UIButton *cancelButton;

-(IBAction) login;
-(IBAction) cancel;

@end
