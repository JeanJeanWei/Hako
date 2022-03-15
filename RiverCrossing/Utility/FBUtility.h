//
//  FBUtility.h
//  Created by JJ WEI on 11-12-06.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FBConnect.h"
#import "AppDelegate.h"


//@class FBUtility;
@class Facebook;


@interface FBUtility : NSObject <FBSessionDelegate, FBDialogDelegate, FBRequestDelegate> {
    
    NSMutableDictionary *parameters;
    
    Facebook *facebook;
    NSURL* targetURL;   
    int failCount;
}

@property (copy) NSMutableDictionary *parameters;

+ (FBUtility*)instance;
- (BOOL)isLogin;

- (id)init;
- (void)loginToFacebook;
- (void)postToWall: (NSMutableDictionary *)params;
- (void)logoutFacebook;
- (void)requestFacebookInfo;
- (void)resetFailCount;
- (BOOL)handleOpenURL:(NSURL*)url;

@end
