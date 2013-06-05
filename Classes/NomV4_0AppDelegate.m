//
//  NomV4_0AppDelegate.m
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//


#import "NomV4_0AppDelegate.h"
#import "OffCampusNavController.h"
#import "OnCampusNavController.h"
#import "CategoriesNavController.h"
#import "LoginViewController.h"

@implementation NomV4_0AppDelegate

@synthesize window;
@synthesize rootController;
@synthesize offCampusNavController;
@synthesize onCampusNavController;
@synthesize categoriesNavController;
@synthesize splashPage;
@synthesize restaurants;

//================================================================================================
//  Purpose: This class serves to be the root controller for the whole application. It controls
//           in what order the controllers are in and controls what happens in what order while
//           the application is running. It also controls the memory management for the high 
//           level controllers.
//
//===================================================================================================
#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	// Override point for customization after application launch.
    [window addSubview:rootController.view];
    [window makeKeyAndVisible];
	
	LoginViewController *ourLogin;
	ourLogin = [[LoginViewController alloc] initWithNibName:@"loginView" bundle:nil];
	
	[self.rootController presentModalViewController:ourLogin animated:YES]; 
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[splashPage release];
	[rootController release];
	[offCampusNavController release];
	[onCampusNavController release];
	[categoriesNavController release];
    [window release];
    [super dealloc];
}


@end
