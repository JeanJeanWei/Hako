//
//  FBUtility.m
//  Created by JJ WEI on 11-12-06.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FBUtility.h"
#import "Constants.h"
#import "URLParser.h"

@implementation FBUtility

@synthesize parameters;

+ (FBUtility*)instance
{
    static dispatch_once_t pred = 0;
    __strong static FBUtility *_instance = nil;
    
    dispatch_once(&pred, ^{
        
        _instance = [[self alloc] init]; //init method
        
    });
    return _instance;
    
}
//static FBUtility* gInstance = nil;
//
//+ (FBUtility*)instance
//{
//    if (!gInstance)
//    {
//        gInstance = [FBUtility new];
//    }
//    
//    return gInstance;
//}

- (id)init
{
   
    self = [super init];
    if (self) 
    {
        facebook = [[Facebook alloc] initWithAppId:FACEBOOK_APPID andDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) 
        {
            facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
            facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
        }
    }
    return  self;
}

- (BOOL)isLogin
{
    return facebook.isSessionValid;
}

- (void) logoutFacebook 
{
    [facebook logout:self];
}

- (void)loginToFacebook 
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
     
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
   
    if (![facebook isSessionValid]) {
        NSArray* permissions = [NSArray arrayWithObjects:
                                @"offline_access",
                                //@"email",
                                nil];
      
        facebook.sessionDelegate=self;
        [facebook authorize:permissions];
    }  
    
}

- (void)postToWall: (NSMutableDictionary *)params 
{
    
    parameters = nil;
    
    if (![facebook isSessionValid]) 
    {
        parameters = [params mutableCopy];
        [self loginToFacebook];
    }
    else 
    {
        
        [facebook dialog:@"feed"
               andParams:params
             andDelegate:self];
    }
}

- (void)requestFacebookInfo 
{
    [facebook requestWithGraphPath: @"me" andDelegate:self];
}

- (void) resetFailCount 
{
    failCount = 0;
}

- (BOOL)handleOpenURL:(NSURL*)url
{
    NSString* facebookScheme = [NSString stringWithFormat:@"fb%@", FACEBOOK_APPID];
    
    targetURL = nil;
    
    if ([url.scheme isEqualToString:facebookScheme])
    {
        NSString* parameter = [URLParser extractURLParameter:@"target_url" fromURL:url];
        
        if (parameter)
        {
            targetURL = [NSURL URLWithString:parameter];
        }
    }
    
    BOOL handle = [facebook handleOpenURL:url];
    
    return handle;
}
#pragma mark FBSessionDelegate

- (void)fbDidLogin {
     
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"facebook_did_login"
     object:nil ]; 

     
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    if (parameters!=nil) {
        //   [appDelegate.facebook dialog:@"feed"
        [facebook dialog:@"feed"
               andParams:parameters
             andDelegate:self];
    }
           
    [self requestFacebookInfo];
   
}
/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)fbDidNotLogin:(BOOL)cancelled {
    NSLog(@"Cancel login");
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"facebook_didnot_login"
     object:nil ];
        

}
- (void)fbDidLogout {
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
    parameters = nil;
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"logoutFB_success"
     object:nil ];

}
/*** Called when the dialog succeeds with a returning url.*/
- (void)dialogCompleteWithUrl:(NSURL *)url {
    NSLog(@"Post Complete w/ URL");     
    
    NSLog(@"%@",[url absoluteString]);
    NSString *theURLString = [url absoluteString];
    
    NSString *successString = @"fbconnect://success?post_id=";
    NSString *skipString = @"fbconnect://success#_=_";
    
    NSString *subStringURL = nil;
    if ([theURLString length] > [successString length]) {
        subStringURL = [[url absoluteString] substringToIndex:28];
        NSLog(@"%@",subStringURL);        
    }
    
    if ([subStringURL isEqualToString:successString] ) 
    {
     /*   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Wall Post Successful" message:@"Successfully posted to Facebook wall." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
       */
         NSLog(@"Wall Post Successful");
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"facebook_share_success"
         object:nil ];
        
    } 
    
    if ([theURLString isEqualToString:skipString]) {
        //   NSLog(@"Post Skipped");        
    }
   
}

/*** Called when the dialog succeeds and is about to be dismissed.*/
- (void)dialogDidComplete:(FBDialog *)dialog {
    NSLog(@"Post Complete");
   
}

/*** Called when the dialog is cancelled and is about to be dismissed. */
- (void)dialogDidNotComplete:(FBDialog *)dialog {    
    NSLog(@"Post Cancelled");
     
}
- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError *)error {
    NSLog(@"Post Failed Error =%i", error.code);
    
    BOOL didRetry = NO;
    
    if (error.code == -999 && failCount < 1) {
        
        if (parameters!=nil) {
            
            [facebook dialog:@"feed"
                   andParams:parameters
                 andDelegate:self];
            
            didRetry = YES;
        }
        failCount++;
        
    }
    
    if (!didRetry) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Facebook Error" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
        [alertView show];
    }
    
    
}
/**
 * Called after the access token was extended. If your application has any
 * references to the previous access token (for example, if your application
 * stores the previous access token in persistent storage), your application
 * should overwrite the old access token with the new one in this method.
 * See extendAccessToken for more details.
 */
- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt {
    
}
/**
 * Called when the current session has expired. This might happen when:
 *  - the access token expired
 *  - the app has been disabled
 *  - the user revoked the app's permissions
 *  - the user changed his or her password
 */
- (void)fbSessionInvalidated {
    
}

/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array, a string, or a number,
 * depending on thee format of the API response.
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
    if ([result isKindOfClass:[NSDictionary class]]) {
     //   NSLog(@"User Facebook Email account = %@", [result objectForKey:@"email"]);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[result objectForKey:@"name"] forKey:@"fb_name"];
        [defaults synchronize];
        //NSLog(@"Name: %@", [result objectForKey:@"name"]);
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"requestFB_success"
         object:nil ];
        
        //use facebook email to update kiip  User's information
    //    NSDictionary* info = [[NSDictionary alloc] initWithObjectsAndKeys:
    //                          [result objectForKey:@"email"], @"email",
                              
     //                         nil];
   //     [[KPManager sharedManager] updateUserInfo:info];
        
                
    }
}

@end
