//
//  SoundManager.m
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-18.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "SoundManager.h"
#import "UserPreferenceController.h"

@implementation SoundManager

@synthesize isMusicON, isSoundEffectsON;

@synthesize managerSoundState;
@synthesize listOfSoundEffectFiles;
@synthesize soundEffectsState;

+ (SoundManager*)instance
{
    static dispatch_once_t pred = 0;
    __strong static SoundManager *_instance = nil;
    
    //static SoundManager *instance = nil;
    dispatch_once(&pred, ^{
        
        _instance = [[self alloc] init]; //init method
        
    });
    return _instance;

}

- (id)init
{                                                        // 8
    self = [super init];
    if (self != nil) {
        // SoundManager initialized
        CCLOG(@"SoundManager Singleton, init");
        isMusicON = YES;
        isSoundEffectsON = YES;
        
        hasAudioBeenInitialized = NO;
        soundEngine = nil;
        managerSoundState = kAudioManagerUninitialized;
        currentTrackName = nil;
    }
    return self;
}

-(void)playBackgroundTrack:(NSString*)trackFileName {
    if (!isMusicON) {
        return;
    }
    // Wait to make sure soundEngine is initialized
    if ((managerSoundState != kAudioManagerReady) &&
        (managerSoundState != kAudioManagerFailed)) {
        
        int waitCycles = 0;
        while (waitCycles < AUDIO_MAX_WAITTIME) {
            [NSThread sleepForTimeInterval:0.1f];
            if ((managerSoundState == kAudioManagerReady) ||
                (managerSoundState == kAudioManagerFailed)) {
                break;
            }
            waitCycles = waitCycles + 1;
        }
    }
    
    if (managerSoundState == kAudioManagerReady) {
        if ([soundEngine isBackgroundMusicPlaying]) {
            if (currentTrackName && [currentTrackName isEqualToString:trackFileName]) {
                return;
            } else {
                [soundEngine stopBackgroundMusic];
                currentTrackName = nil;
            }
        }
        [soundEngine preloadBackgroundMusic:trackFileName];
        [soundEngine playBackgroundMusic:trackFileName loop:YES];
        currentTrackName = trackFileName;
    }
}

- (void)stopMusic
{
     if ([soundEngine isBackgroundMusicPlaying]) {
         [soundEngine stopBackgroundMusic];
         currentTrackName = nil;
     }
}

-(void)stopSoundEffect:(ALuint)soundEffectID {
    if (managerSoundState == kAudioManagerReady) {
        [soundEngine stopEffect:soundEffectID];
    }
}

-(ALuint)playSoundEffect:(NSString*)soundEffectKey
{
    ALuint soundID = 0;
    
    if (!isSoundEffectsON) {
        return soundID;
    }
    if (managerSoundState == kAudioManagerReady) {
        NSNumber *isSFXLoaded = [soundEffectsState objectForKey:soundEffectKey];
        if ([isSFXLoaded boolValue] == SFX_LOADED) {
            soundID = [soundEngine playEffect:[listOfSoundEffectFiles objectForKey:soundEffectKey]];
        } else {
            CCLOG(@"GameMgr: SoundEffect %@ is not loaded, cannot play.",soundEffectKey);
        }
    } else {
        CCLOG(@"GameMgr: Sound Manager is not ready, cannot play %@", soundEffectKey);
    }
    return soundID;
}

- (NSString*)formatSceneTypeToString:(SceneTypes)sceneID {
    NSString *result = nil;
    switch(sceneID) {
        case kNoSceneUninitialized:
            result = @"kNoSceneUninitialized";
            break;
        case kMainMenuScene:
            result = @"kMainMenuScene";
            break;
        case kProfileScene:
            result = @"kProfileScene";
            break;
        case kAvatorListScene:
            result = @"kAvatorListScene";
            break;
        case kLevelListScene:
            result = @"kLevelListScene";
            break;
        
           
        case kOptionsScene:
            result = @"kOptionsScene";
            break;
        case kCreditsScene:
            result = @"kCreditsScene";
            break;
        case kIntroScene0:
            result = @"kIntroScene0";
            break;
        case kIntroScene:
            result = @"kIntroScene";
            break;
        case kLevelCompleteScene:
            result = @"kLevelCompleteScene";
            break;
            
        case kGameLevel1:
            result = @"kGameLevel1";
            break;
        case kGameLevel2:
            result = @"kGameLevel2";
            break;
        case kGameLevel3:
            result = @"kGameLevel3";
            break;
        case kGameLevel4:
            result = @"kGameLevel4";
            break;
        case kGameLevel5:
            result = @"kGameLevel5";
            break;
        case kCutSceneForLevel2:
            result = @"kCutSceneForLevel2";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected SceneType."];
    }
    return result;
}

-(NSDictionary *)getSoundEffectsListForSceneWithID:(SceneTypes)sceneID {
    NSString *fullFileName = @"SoundEffects.plist";
    NSString *plistPath;
    
    // 1: Get the Path to the plist file
    NSString *rootPath =
    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                         NSUserDomainMask, YES)
     objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:fullFileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle]
                     pathForResource:@"SoundEffects" ofType:@"plist"];
    }
    
    // 2: Read in the plist file
    NSDictionary *plistDictionary =
    [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    // 3: If the plistDictionary was null, the file was not found.
    if (plistDictionary == nil) {
        CCLOG(@"Error reading SoundEffects.plist");
        return nil; // No Plist Dictionary or file found
    }
    
    // 4. If the list of soundEffectFiles is empty, load it
    if ((listOfSoundEffectFiles == nil) ||
        ([listOfSoundEffectFiles count] < 1)) {
        NSLog(@"Before");
        [self setListOfSoundEffectFiles:
         [[NSMutableDictionary alloc] init]];
        NSLog(@"after");
        for (NSString *sceneSoundDictionary in plistDictionary) {
            [listOfSoundEffectFiles
             addEntriesFromDictionary:
             [plistDictionary objectForKey:sceneSoundDictionary]];
        }
        CCLOG(@"Number of SFX filenames:%d",
              [listOfSoundEffectFiles count]);
    }
    
    // 5. Load the list of sound effects state, mark them as unloaded
    if ((soundEffectsState == nil) ||
        ([soundEffectsState count] < 1)) {
        [self setSoundEffectsState:[[NSMutableDictionary alloc] init]];
        for (NSString *SoundEffectKey in listOfSoundEffectFiles) {
            [soundEffectsState setObject:[NSNumber numberWithBool:SFX_NOTLOADED] forKey:SoundEffectKey];
        }
    }
    
    // 6. Return just the mini SFX list for this scene
    NSString *sceneIDName = [self formatSceneTypeToString:sceneID];
    NSDictionary *soundEffectsList =
    [plistDictionary objectForKey:sceneIDName];
    
    return soundEffectsList;
}


-(void)loadAudioForSceneWithID:(NSNumber*)sceneIDNumber {
    //NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    @autoreleasepool {
        SceneTypes sceneID = (SceneTypes) [sceneIDNumber intValue];
        // 1
        if (managerSoundState == kAudioManagerInitializing) {
            int waitCycles = 0;
            while (waitCycles < AUDIO_MAX_WAITTIME) {
                [NSThread sleepForTimeInterval:0.1f];
                if ((managerSoundState == kAudioManagerReady) ||
                    (managerSoundState == kAudioManagerFailed)) {
                    break;
                }
                waitCycles = waitCycles + 1;
            }
        }
        
        if (managerSoundState == kAudioManagerFailed) {
            return; // Nothing to load, CocosDenshion not ready
        }
        
        NSDictionary *soundEffectsToLoad =
        [self getSoundEffectsListForSceneWithID:sceneID];
        if (soundEffectsToLoad == nil) { // 2
            CCLOG(@"Error reading SoundEffects.plist");
            return;
        }
        // Get all of the entries and PreLoad // 3
        for( NSString *keyString in soundEffectsToLoad )
        {
            CCLOG(@"\nLoading Audio Key:%@ File:%@",
                  keyString,[soundEffectsToLoad objectForKey:keyString]);
            [soundEngine preloadEffect:
             [soundEffectsToLoad objectForKey:keyString]]; // 3
            // 4
            [soundEffectsState setObject:[NSNumber numberWithBool:SFX_LOADED] forKey:keyString];
            
        }
    }
    //[pool release];
}

-(void)unloadAudioForSceneWithID:(NSNumber*)sceneIDNumber {
    //NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    @autoreleasepool {
        SceneTypes sceneID = (SceneTypes)[sceneIDNumber intValue];
        if (sceneID == kNoSceneUninitialized) {
            return; // Nothing to unload
        }
        
        
        NSDictionary *soundEffectsToUnload =
        [self getSoundEffectsListForSceneWithID:sceneID];
        if (soundEffectsToUnload == nil) {
            CCLOG(@"Error reading SoundEffects.plist");
            return;
        }
        if (managerSoundState == kAudioManagerReady) {
            // Get all of the entries and unload
            for( NSString *keyString in soundEffectsToUnload )
            {
                [soundEffectsState setObject:[NSNumber numberWithBool:SFX_NOTLOADED] forKey:keyString];
                [soundEngine unloadEffect:keyString];
                CCLOG(@"\nUnloading Audio Key:%@ File:%@",
                      keyString,[soundEffectsToUnload objectForKey:keyString]);
                
            }
        }
    }
    // [pool release];
}




-(void)initAudioAsync {
    // Initializes the audio engine asynchronously
    managerSoundState = kAudioManagerInitializing;
    // Indicate that we are trying to start up the Audio Manager
    [CDSoundEngine setMixerSampleRate:CD_SAMPLE_RATE_MID];
    
    //Init audio manager asynchronously as it can take a few seconds
    //The FXPlusMusicIfNoOtherAudio mode will check if the user is
    // playing music and disable background music playback if
    // that is the case.
    [CDAudioManager initAsynchronously:kAMM_FxPlusMusicIfNoOtherAudio];
    
    //Wait for the audio manager to initialise
    while ([CDAudioManager sharedManagerState] != kAMStateInitialised)
    {
        [NSThread sleepForTimeInterval:0.1];
    }
    
    //At this point the CocosDenshion should be initialized
    // Grab the CDAudioManager and check the state
    CDAudioManager *audioManager = [CDAudioManager sharedManager];
    if (audioManager.soundEngine == nil ||
        audioManager.soundEngine.functioning == NO) {
        CCLOG(@"CocosDenshion failed to init, no audio will play.");
        managerSoundState = kAudioManagerFailed;
    } else {
        [audioManager setResignBehavior:kAMRBStopPlay autoHandle:YES];
        soundEngine = [SimpleAudioEngine sharedEngine];
        managerSoundState = kAudioManagerReady;
        CCLOG(@"CocosDenshion is Ready");
    }
}


-(void)setupAudioEngine {
    isMusicON = [UserPreferenceController.instance getMusic];
    isSoundEffectsON = [UserPreferenceController.instance getSoundEffect];
    
    if (hasAudioBeenInitialized == YES) {
        return;
    } else {
        hasAudioBeenInitialized = YES;
        //NSOperationQueue *queue = [[NSOperationQueue new] autorelease];
        NSOperationQueue *queue = [NSOperationQueue new];
        NSInvocationOperation *asyncSetupOperation =
        [[NSInvocationOperation alloc] initWithTarget:self
                                             selector:@selector(initAudioAsync)
                                               object:nil];
        [queue addOperation:asyncSetupOperation];
     //   [asyncSetupOperation autorelease];
    }
}

@end
