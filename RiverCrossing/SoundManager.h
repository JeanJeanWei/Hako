//
//  SoundManager.h
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-18.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleAudioEngine.h"

@interface SoundManager : NSObject
{
    BOOL hasAudioBeenInitialized;
    GameManagerSoundState managerSoundState;
    SimpleAudioEngine *soundEngine;
    NSMutableDictionary *listOfSoundEffectFiles;
    NSMutableDictionary *soundEffectsState;
    
    BOOL isMusicON;
    BOOL isSoundEffectsON;
    NSString *currentTrackName;
}

@property (assign) GameManagerSoundState managerSoundState;
@property (strong) NSMutableDictionary *listOfSoundEffectFiles;
@property (strong) NSMutableDictionary *soundEffectsState;

@property (assign) BOOL isMusicON;
@property (assign) BOOL isSoundEffectsON;

+ (SoundManager*)instance;
- (void)stopMusic;

-(void)setupAudioEngine;
-(ALuint)playSoundEffect:(NSString*)soundEffectKey;
-(void)stopSoundEffect:(ALuint)soundEffectID;
-(void)playBackgroundTrack:(NSString*)trackFileName;


@end
