//  GameManager.h
//  Hako
//
#import <Foundation/Foundation.h>

@interface GameManager : NSObject
{

    int stage;
    int currentLevel;
    BOOL movingInProgress;
    SceneTypes currentScene;
    
    int levelClearTime;
    int currentPage;
}

@property (assign) BOOL movingInProgress;
@property (assign) int stage;
@property (assign) int currentLevel;
@property (assign) int levelClearTime;
@property (assign) int currentPage;

+ (GameManager*)instance;                                  // 1
- (void)runSceneWithID:(SceneTypes)sceneID;                         // 2
- (void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen ;            // 3

- (void)saveLevelTime;

- (void)postToFB:(int)time record:(BOOL)isNew;

@end
