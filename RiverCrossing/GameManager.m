//  GameManager.m
//  SpaceViking
//
#import "GameManager.h"
#import "GameScene.h"
#import "MainMenuScene.h"
#import "ProfileScene.h"
#import "OptionsScene.h"
#import "CreditsScene.h"
#import "IntroScene0.h"
#import "IntroScene.h"
#import "LevelCompleteScene.h"
#import "LevelListScene.h"
#import "UserPreferenceController.h"
#import "AvatorListScene.h"
//#import "FBUtility.h"

@implementation GameManager


@synthesize movingInProgress;
@synthesize stage, currentLevel;
@synthesize levelClearTime;
@synthesize currentPage;

//Singleton Setup
+ (GameManager*)instance
{
    static dispatch_once_t pred = 0;
    __strong static GameManager *_instance = nil;

    dispatch_once(&pred, ^{
        _instance = [[self alloc] init];
        //init class propertites here
//        instance = [GameManager new];
//        instance.movingInProgress = NO;
//        instance.hasAudioBeenInitialized = NO;
//        //instance.soundEngine = nil;
//        instance.managerSoundState = kAudioManagerUninitialized;
    
    });
    return _instance;

}



-(id)init {                                                        // 8
    self = [super init];
    if (self != nil) {
        // Game Manager initialized
        CCLOG(@"Game Manager Singleton, init");

        stage = [UserPreferenceController.instance getCurrentStage];
        //stage = 1;
        CCLOG(@"stage = %d",stage);
        currentScene = kNoSceneUninitialized;
        
        movingInProgress = NO;
        currentPage = 0;
        
    }
    return self;
}


-(void)runSceneWithID:(SceneTypes)sceneID {
    SceneTypes oldScene = currentScene;
    currentScene = sceneID;
    [SoundManager.instance performSelectorInBackground:@selector(unloadAudioForSceneWithID:) withObject:[NSNumber numberWithInt:oldScene]];
    id sceneToRun = nil;
    switch (sceneID) {
        case kMainMenuScene: 
            sceneToRun = [MainMenuScene node];
            break;
        case kProfileScene:
            sceneToRun = [ProfileScene node];
            break;
        case kOptionsScene:
            sceneToRun = [OptionsScene node];
            break;
        case kCreditsScene:
            sceneToRun = [CreditsScene node];
            break;
        case kIntroScene0:
            sceneToRun = [IntroScene0 node];
            break;
        case kIntroScene:
            sceneToRun = [IntroScene node];
            break;
            
        case kLevelListScene:
            sceneToRun = [LevelListScene node];
            break;
        case kAvatorListScene:
            sceneToRun = [AvatorListScene node];
            break;
 
        case kLevelCompleteScene:
            sceneToRun = [LevelCompleteScene node];
                    [self saveLevelTime];
            break;
            
            
        case kGameLevel1: 
            sceneToRun = [GameScene node];
            break;
            
        case kGameLevel2:
            // Placeholder for Level 2
            break;
        case kGameLevel3:
            // Placeholder for Level 3
            break;
        case kGameLevel4:
            // Placeholder for Level 4
            break;
        case kGameLevel5:
            // Placeholder for Level 5
            break;
        case kCutSceneForLevel2:
            // Placeholder for Platform Level
            break;
            
        default:
            CCLOG(@"Unknown ID, cannot switch scenes");
            return;
            break;
    }
    if (sceneToRun == nil) {
        // Revert back, since no new scene was found
        currentScene = oldScene;
        return;
    }
    
    // Menu Scenes have a value of < 100
    if (sceneID < 100) {
//        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) { 
//            CGSize screenSize = [CCDirector sharedDirector].winSizeInPixels; 
//            if (screenSize.width == 960.0f || screenSize.height == 1136) {
//                // iPhone 4 Retina
//                [sceneToRun setScaleX:0.9375f];
//                [sceneToRun setScaleY:0.8333f];
//                CCLOG(@"GameMgr:Scaling for iPhone 4 (retina)");
//                
//            } else {
//                [sceneToRun setScaleX:0.4688f];
//                [sceneToRun setScaleY:0.4166f];
//                CCLOG(@"GameMgr:Scaling for iPhone 3GS or older (non-retina)");
//                
//            }
//        }
    }

    if ([[CCDirector sharedDirector] runningScene] == nil) {
        [[CCDirector sharedDirector] runWithScene:sceneToRun];
        
    } else {
        
        [[CCDirector sharedDirector] replaceScene:sceneToRun];
    }
     [SoundManager.instance performSelectorInBackground:@selector(loadAudioForSceneWithID:) withObject:[NSNumber numberWithInt:currentScene]];
    //currentScene = sceneID;
}
-(void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen {
    NSURL *urlToOpen = nil;
    if (linkTypeToOpen == kLinkFacebookSite) {
        CCLOG(@"Opening FacebookSite");
        urlToOpen = [NSURL URLWithString:@"http://www.facebook.com/pages/Ice-Whale/100524630054674"];
    } else if (linkTypeToOpen == kLinkBlogSite) {
        CCLOG(@"Opening Blog Site");
        urlToOpen = [NSURL URLWithString:@"http://icewhale.com"];
    } else if (linkTypeToOpen == kLinkFullVersion) {
        CCLOG(@"Opening app full version");
        urlToOpen = [NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/dong-suan-zhi-lu/id603709812?ls=1&mt=8"];
    } else if (linkTypeToOpen == kLinkMoreApps) {
        CCLOG(@"Opening Icewhale apps");
        urlToOpen = [NSURL URLWithString:@"itms-apps://itunes.com/icewhale"];
    } else if (linkTypeToOpen == kLinkCocos2d) {
        CCLOG(@"Opening Cocos2ds");
        urlToOpen = [NSURL URLWithString:@"http://www.cocos2d-iphone.org/"];
    } else if (linkTypeToOpen == kLinkTexturePacker) {
        CCLOG(@"Opening TexturePacker");
        urlToOpen = [NSURL URLWithString:@"http://www.codeandweb.com/texturepacker"];
    } else if (linkTypeToOpen == kLinkLuxuria) {
        CCLOG(@"Opening TexturePacker");
        urlToOpen = [NSURL URLWithString:@"http://www.pixiv.net/member.php?id=5337501"];
    } else if (linkTypeToOpen == kLinkBastet) {
        CCLOG(@"Opening TexturePacker");
        urlToOpen = [NSURL URLWithString:@"http://bastettail.com/"];
    } else {
        CCLOG(@"Defaulting to icewhale.com Blog Site");
        urlToOpen = [NSURL URLWithString:@"http://icewhale.com"];
    }
    
    if (![[UIApplication sharedApplication] openURL:urlToOpen]) {
        CCLOG(@"%@%@",@"Failed to open url:",[urlToOpen description]);
        [self runSceneWithID:kMainMenuScene];
    }    
}

- (void)postToFB:(int)time record:(BOOL)isNew
{
    NSMutableDictionary *params;
    NSString *cap = [NSString stringWithFormat:NSLocalizedString(@"FB_title", nil)];
    NSString *url = @"http://3.bp.blogspot.com/-emrsbZMj5oA/UqkVCs0TpRI/AAAAAAAAAPU/QmbUhjMiwE4/s1600/Icon_512.png";
    NSString *description;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *fbName = [defaults objectForKey:@"fb_name"];
    
//    switch (stage) {
//        case 1:
//            //url = @"http://2.bp.blogspot.com/-P5DzP8zQ9GE/UTYrJI8YedI/AAAAAAAAANQ/j3egadWpibM/s1600/1.PNG";
//            url = @"http://3.bp.blogspot.com/-GbPoSaHppXY/UTvKScha2-I/AAAAAAAAAOE/Z9pRwUl0wDY/s1600/Icon1.jpg";
//            break;
//        case 2:
//            url = @"http://2.bp.blogspot.com/-RVnfN-dccCs/UTYrHXuVSlI/AAAAAAAAANM/XASLF0d73K8/s1600/2.PNG";
//            break;
//        case 3:
//            url = @"http://4.bp.blogspot.com/-li3XfbX9IOc/UTYrDMAUfHI/AAAAAAAAANE/WPzzK6mfZfE/s1600/3.PNG";
//            break;
//        default:
//            break;
//    }
    if (isNew) {
        if (fbName.length>0) {
             
            description = [NSString stringWithFormat:NSLocalizedString(@"FB_newRecord_1", nil),fbName,stage, currentLevel+1,time];
        } else {
            description = [NSString stringWithFormat:NSLocalizedString(@"FB_newRecord_2", nil),stage, currentLevel+1,time];
        }
    } else {
        if (fbName.length>0) {
            description = [NSString stringWithFormat:NSLocalizedString(@"FB_normal_1", nil),fbName,stage, currentLevel+1,levelClearTime];

        } else {
             description = [NSString stringWithFormat:NSLocalizedString(@"FB_normal_2", nil),stage, currentLevel+1,levelClearTime];
            //description = [[NSString alloc] initWithFormat:@"凍蒜%d號在%d秒內過第%d關!!",stage,levelClearTime,currentLevel+1];
        }
    }
    params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
              
              @"Break Out Turbo", @"name",
              cap, @"caption",
              @"https://itunes.apple.com/us/app/break-out-turbo/id754949884?ls=1&mt=8", @"link",
              description, @"description",
              url, @"picture",
              nil];
    
    
    //[FBUtility.instance postToWall:params];
}

- (void)saveLevelTime
{
    [UserPreferenceController.instance saveLevelClearTime:currentLevel time:levelClearTime];
//    int time = [UserPreferenceController.instance saveLevelClearTime:currentLevel time:levelClearTime];
//    if (time)
//    {
//        [self postToFB:time record:YES];
//    };
}
@end
