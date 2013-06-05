//
//  LoginViewController.m
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//


#import "LoginViewController.h"

@implementation LoginViewController

//================================================================================================
//  Purpose: This class is the dummy login controller. This is just a placeholder for now until the
//           real login stuff is put in for the suite.
//===================================================================================================

-(IBAction) login {
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction) cancel {
	[self dismissModalViewControllerAnimated:YES];
	
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}
@end
