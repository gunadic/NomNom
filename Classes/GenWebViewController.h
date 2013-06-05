//
//  GenWebViewController.h
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GenWebViewController : UIViewController {
	IBOutlet UIWebView *webView;
	NSString *webPageURL;
}

@property(nonatomic, copy) NSString *webPageURL;

@end
