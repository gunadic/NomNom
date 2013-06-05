//
//  URLCreater.m
//  NomNom
//
//  Created by: Patricia Perez and Christopher Gunadi
//  Created on 5/14/11.
//  Copyright 2011 __Trinity University__. All rights reserved.
//

#import "URLCreater.h"
#import "NomV4_0AppDelegate.h"
#import <CommonCrypto/CommonDigest.h> //Adding this for md% hash stuff


@implementation URLCreater

@synthesize queryState;
@synthesize teamNumber;
@synthesize progress;
@synthesize queryType;
@synthesize parseState;
@synthesize debugMode;

//================================================================================================
//  Purpose: This class is the abstracted out URL Creater. It creates the URL in order to talk to
//           the server. This uses an MD5 hash to encrypt the information being sent to the server.
//           It also includes authentication stuff so the server knows who it is talking to, or else
//           it will not respond (the salt). We can do 4 different types of SQL commands with it.
//===================================================================================================

NSString * md5(NSString *str) {
	const char *cStr = [str UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(cStr, strlen(cStr), result);
	
	return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1],
			result[2], result[3],
			result[4], result[5],
			result[6], result[7],
			result[8], result[9],
			result[10], result[11],
			result[12], result[13],
			result[14], result[15] ];
}

- (id) initVars {
	debugMode = 0; //0 = no debug, 1 = force timeout in finish, 2 = force auth error
	showLoadingView = FALSE;
	teamNumber = 0;
	selectFieldCount = 0;
	selectRowCount = 0;
	selectRowsFetched = 0;
	parseState = 0;
	responseMaxLength = 0;
	hasRunBefore = FALSE;	
	queryText = nil;
	argText = nil;
	progress = 0;
	return self;
}

- (void) initViewInfo: (id)callbackObj progressMeterSelector:(SEL)pmc retryButtonSelector:(SEL)rc {
	showLoadingView = TRUE;
	NSMethodSignature *sig = [[callbackObj class] instanceMethodSignatureForSelector:pmc];
	progressMeterCallback = [NSInvocation invocationWithMethodSignature:sig];
	[progressMeterCallback setTarget:callbackObj];
	[progressMeterCallback setSelector:pmc];
	[progressMeterCallback retain];
	
	sig = [[callbackObj class] instanceMethodSignatureForSelector:rc];
	showTimeoutCallback = [NSInvocation invocationWithMethodSignature:sig];
	[showTimeoutCallback setTarget:callbackObj];
	[showTimeoutCallback setSelector:rc];
	[showTimeoutCallback retain];
}

- (void) setCallback:(id)callbackObj selector:(SEL)selector {
	NSMethodSignature *sig = [[callbackObj class] instanceMethodSignatureForSelector:selector];
	callback = [NSInvocation invocationWithMethodSignature:sig];
	[callback setTarget:callbackObj];
	[callback setSelector:selector];
	[callback retain];
}

- (void) setQueryText: (NSString *) queryVal withArgs: (NSString *) argVal {
	if(queryVal != nil) {
		queryText = [[NSString alloc] initWithString: queryVal];
		//try to automatically determine if it is insert,select,update,or delete
		//and set queryType
		//query.queryType = 1; //1=insert,2=select,3=update,4=delete
		NSArray *_splitItems = [queryVal componentsSeparatedByString:@" "];
		NSMutableArray *_mutableSplitItems = [NSMutableArray arrayWithCapacity:[_splitItems count]]; 
		[_mutableSplitItems addObjectsFromArray:_splitItems];
		NSString *phrase1 = [(NSString *) [_mutableSplitItems objectAtIndex:0] uppercaseString];
		if([phrase1 isEqualToString:@"INSERT"])
			queryType = 1;
		else if([phrase1 isEqualToString:@"SELECT"])
			queryType = 2;
		else if([phrase1 isEqualToString:@"UPDATE"])
			queryType = 3;
		else if([phrase1 isEqualToString:@"DELETE"])
			queryType = 4;
	}
	if(argVal != nil)
		argText = [[NSString alloc] initWithString: argVal];
	else 
		argText = [NSString stringWithFormat:@""];
}

-(NSURL *)buildOurURL:(NSString *)query: (NSString *)args{
	NSLog(@"Executing buildURL");
	
	NSMutableString *argsCleaned = [[NSMutableString alloc] initWithString: @""];
	for (int i=0; i<[argText length]; i++) {
		//        if (isdigit([args characterAtIndex:i])) {
		if([argText characterAtIndex:i] != '|') {
			[argsCleaned appendFormat:@"%c",[argText characterAtIndex:i]];
		}
	}
	//NSString *payload = [NSString stringWithFormat:@"%d%@%@", teamNumber, queryText, argsCleaned];

	
	NSString* payload = [NSString stringWithFormat:@"4%@%@", query, args];
	NSString* salt = @"i,JhN73EA7S1$-AEI55$XKYXn$8U)AHT-Q$DNuIOsaGZPGeYBZFYkewDLuY6vfPlv6o-rwEPDKpTRArSZxr-HT3S4SPqxfHZcwP9ZTPcd)vu)S3K5lAC)4V#MkW05ePXGfXfyn+IYj&J$wTxOUz9OBzblCRhgh)n2J8rw*zAViJDLd#ZxgY2hET9Glhn8SG1cFjE1OENxOQ,r7OVdnN0rh-y8XR7pX,8dXCVmHiQWzE3wSOG)c7d-+H,KZ)#xuy"; 
	//NSString* tempTxt;
	//NSString* tempPayload;
	//NSString* finalPayload;
	//NSMutableString* payloadForHash;
	//NSString* digest;
	
	int lenPW = [payload length];
	if(lenPW > 200){
		payload = [payload substringToIndex:200];
		lenPW = 200;
		
		/*NSLog(@">200");
		tempPayload = [payload substringToIndex:200];
		tempTxt = [salt substringToIndex:55];
		finalPayload = [NSString stringWithFormat:@"%@%@", tempPayload, tempTxt];*/
	}
	
	int lenSalt = 255 - lenPW;
	payload = [NSString stringWithFormat:@"%@%@", payload, [salt substringToIndex:lenSalt]];
	NSString *digest = md5(payload);
	for(int i=0; i<8101; i++){
		digest = md5(digest);
	}
	//NSString* escapedUrlString = [[NSString stringWithFormat:@"%@%d%@%@%@%@%@%@", @"http://devsoap.fulgentcorp.com/trinityrestserver.php?teamnumber=", 4, @"&querypart=", query, @"&argpart=", args @"&hash=", digest] stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
	/*
	else{
		NSLog(@"<200");
		//need to make variable with salt-payload length
		tempPayload = payload;
		tempTxt = [salt substringToIndex:255-payload.length];
		NSLog(@"tempTxt = %@", tempTxt);
		finalPayload = [NSString stringWithFormat:@"%@%@", tempPayload, tempTxt];
	}
	
	payloadForHash = [[NSMutableString alloc] initWithString:finalPayload];
	[payloadForHash replaceOccurrencesOfString:@"|" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, finalPayload.length)];
	
	NSLog(@"Payload :: %@ %d", finalPayload, [finalPayload length]);
	digest = md5(payloadForHash);
	
	for(int i = 0; i < 8101; i++){
		digest = md5(digest);
	}
	*/
	NSString* escapedUrlString = [[NSString stringWithFormat:@"%@%d%@%@%@%@%@%@", @"https://devsoap.fulgentcorp.com/trinityrestserver.php?teamnumber=", 4, @"&querypart=", query, @"&argpart=", args, @"&hash=", digest] stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
	NSLog(@"URL TEST %@", escapedUrlString);
	escapedUrlString = [escapedUrlString stringByReplacingOccurrencesOfString:@"+" withString: @"%2B"];
	//escapedUrlString = [escapedUrlString stringByReplacingOccurrencesOfString:@"'" withString: @"%27"];

	NSLog(@"URL TEST With Encoded + %@", escapedUrlString);
	NSURL *url = [NSURL URLWithString:escapedUrlString];
	return url;
}

- (NSMutableArray *) getResultArray {
	return resultArray;
}

- (int) getNumSelectRows {
	return selectRowCount;
}

- (int) getNumSelectFields {
	return selectFieldCount;
}

- (int) getNumSelectRowsFetched {
	return selectRowsFetched;
}

- (void) cancelConnection {
	[connection cancel];
}

- (int) getResponseMaxLength {
	return responseMaxLength;
}

- (int) getResponseCurrentLength {
	return [responseData length];
}




@end
