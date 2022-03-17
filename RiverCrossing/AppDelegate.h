//
//  AppDelegate.h
//  RiverCrossing
//
//  Created by JJ WEI on 12-06-29.
//  Copyright Ice Whale Inc. 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*__unsafe_unretained director_;			// weak ref
}

@property (nonatomic) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (unsafe_unretained, readonly) CCDirectorIOS *director;

@end

//#import <UIKit/UIKit.h>
//
//@class RootViewController;
//
//@interface AppController : NSObject <UIApplicationDelegate> {
//	UIWindow			*window;
//	RootViewController	*viewController;
//}
//
//@property (nonatomic, retain) UIWindow *window;

//@end