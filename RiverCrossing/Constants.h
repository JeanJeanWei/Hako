//
//  Header.h
//  ro3
//
//  Created by JJ WEI on 12-06-27.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//
#import <Foundation/Foundation.h>

#define ENABLE_APPLICATION_RATINGS /* Enables the "Rate this App" dialog */
#define RATING_DAY_DELAY            4
#define FACEBOOK_APPID @"635074876539450"
#define ITUNES_APP_ID  @"754949884"

// Constants used to load spirite animation sequences
#define ANIM_NAMES [NSArray arrayWithObjects: @"breathingAnim", @"walkingAnim", @"crouchingAnim", @"idlingAnim", @"preIdlingAnim", nil]
#define ANIM_NAMES_FOR_AVATOR [NSArray arrayWithObjects: @"breathingAnim", @"walkingUpAnim", , @"walkingDoenAnim", @"walkingLefeRightAnim", @"crouchingAnim", @"idlingAnim", @"preIdlingAnim", nil]

#define SPEED_SLOW 192.0f
#define SPEED_FAST 320.0f
// Constants used to definde Gamp Play View Boundaries
#define LEFTBOUND 10.0f
#define RIGHTBOUND [[CCDirectorIOS sharedDirector] winSize].width - 10.0f
//#define BUTTONBOUND  173.0f
#define BUTTONBOUND [[CCDirectorIOS sharedDirector] winSize].height - 20.0f - 375.0f
#define UPBOUND [[CCDirectorIOS sharedDirector] winSize].height - 20.0f


// Constants used in Game Play

#define kBodySpriteZValue 100
#define kBodySpriteTagValue 0
#define kBodyIdleTimer 3.0f
#define kBodyFistDamage 10
#define kBodyMalletDamage 40
#define kRadarDishTagValue 10

#define kMainMenuTagValue 10
#define kSceneMenuTagValue 20

typedef enum {
    kNoSceneUninitialized=0,
    kMainMenuScene=1,
    kProfileScene,
    kOptionsScene,
    kCreditsScene,
    kIntroScene0,
    kIntroScene,
    kAvatorListScene,
    kLevelListScene,
    kLevelCompleteScene,
    kGameLevel1=101,
    kGameLevel2=102,
    kGameLevel3=103,
    kGameLevel4=104,
    kGameLevel5=105,
    kCutSceneForLevel2=201
} SceneTypes;

typedef enum {
    kDefaultBackground=0,
    kMainMenuBackground=1,
    kOptionsBackground=2,
    kCreditsBackground=3,
    kIntroBackground=4,
    kLevelCompleteBackground=5,
    kGameLevel1Background=101,
    kGameLevel2Background=102,
    kGameLevel3Background=103,
    kGameLevel4Background=104,
    kGameLevel5Background=105,
    kCutSceneForLevel2Background=201
} BackgroundTypes;

typedef enum {
    kLinkFacebookSite,
    kLinkBlogSite,
    kLinkMoreApps,
    kLinkFullVersion,
    kLinkCocos2d,
    kLinkTexturePacker,
    kLinkLuxuria,
    kLinkBastet
} LinkTypes;


// Audio Items
#define AUDIO_MAX_WAITTIME 150

typedef enum {
    kAudioManagerUninitialized=0,
    kAudioManagerFailed=1,
    kAudioManagerInitializing=2,
    kAudioManagerInitialized=100,
    kAudioManagerLoading=200,
    kAudioManagerReady=300
    
} GameManagerSoundState;

// Audio Constants
#define SFX_NOTLOADED NO
#define SFX_LOADED YES

#define PLAYSOUNDEFFECT(...) \
[[GameManager sharedGameManager] playSoundEffect:@#__VA_ARGS__]

#define STOPSOUNDEFFECT(...) \
[[GameManager sharedGameManager] stopSoundEffect:__VA_ARGS__]

// Background Music
// Menu Scenes
#define BACKGROUND_TRACK_MAIN_MENU @"hako_mainMenu.mp3"
// Intro0 Scenes
#define BACKGROUND_TRACK_INTRO0 @"hako_op_1.mp3"
// GamePlay1
#define BACKGROUND_TRACK_GAMEPLAY_1 @"hako_gameplay1.mp3"

//  GamePlay2
#define BACKGROUND_TRACK_GAMEPLAY_2 @"hako_gameplay2.mp3"

//  GamePlay3
#define BACKGROUND_TRACK_GAMEPLAY_3 @"hako_gameplay3.mp3"

//  GamePlay3
#define BACKGROUND_TRACK_EXP @"hako_expert.mp3"
