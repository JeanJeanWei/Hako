//
//  AppDelegate.m
//  RiverCrossing
//
//  Created by JJ WEI on 12-06-29.
//  Copyright Ice Whale Inc. 2012. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "ABGameKitHelper.h"
#import "UserPreferenceController.h"
#import "RatingManager.h"
//#import "FBUtility.h"

//#import "RootViewController.h"

@implementation AppController



@synthesize window=window_, navController=navController_, director=director_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
 [[ABGameKitHelper sharedClass] authenticatePlayer];
 [UserPreferenceController.instance manageSettings];   
#if DEBUG
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
#endif
    
    // Create the main window
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];


	// Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
//	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
//								   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
//								   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
//							preserveBackbuffer:NO
//									sharegroup:nil
//								 multiSampling:NO
//							   numberOfSamples:0];
    CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
                        								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
                        								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
                        						];

	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];

	director_.viewRespectsSystemMinimumLayoutMargins = YES;

	// Display FSP and SPF
	[director_ setDisplayStats:NO];

	// set FPS at 60
	[director_ setAnimationInterval:1.0/60];

	// attach the openglView to the director
	[director_ setView:glView];

	// for rotation and other messages
	[director_ setDelegate:self];

	// 2D projection
	[director_ setProjection:kCCDirectorProjection2D];
//	[director setProjection:kCCDirectorProjection3D];

	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director_ enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");

	// Create a Navigation Controller with the Director
	navController_ = [[UINavigationController alloc] initWithRootViewController:director_];
	navController_.navigationBarHidden = YES;

	// set the Navigation Controller as the root view controller
//	[window_ setRootViewController:rootViewController_];
//	[window_ addSubview:navController_.view];
    window_.rootViewController = navController_;
	// make main window visible
	[window_ makeKeyAndVisible];

	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
	// On iPad     : "-ipad", "-hd"
	// On iPhone HD: "-hd"
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"

	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];

	// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
	//[director_ pushScene: [GameScene node]];
    [SoundManager.instance setupAudioEngine];
    [[GameManager instance] runSceneWithID:kIntroScene];
    //[GameManager.instance runSceneWithID:kMainMenuScene];
	return YES;
}

// Supported orientations: Landscape. Customize it for your own needs
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{

	if( [navController_ visibleViewController] == director_ )
		[director_ pause];
    [UserPreferenceController.instance saveDataToDisk];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
#ifdef ENABLE_APPLICATION_RATINGS
    
    [RatingManager.instance manageRating];
    
#endif
	if( [navController_ visibleViewController] == director_ )
		[director_ resume];
    GameManager.instance.movingInProgress = NO;
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ stopAnimation];
    GameManager.instance.movingInProgress = NO;
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
   // [[ABGameKitHelper sharedClass] authenticatePlayer];
	if( [navController_ visibleViewController] == director_ )
		[director_ startAnimation];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}
void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    // Internal error reporting
}

// Pre iOS 4.2 support
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    return [FBUtility.instance handleOpenURL:url];
//}

// For iOS 4.2+ support
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return [FBUtility.instance handleOpenURL:url];
//}
@end
