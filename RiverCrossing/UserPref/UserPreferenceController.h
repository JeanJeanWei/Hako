//
//  UserPreferenceController.h
//  math1
//
//  Created by Jean-Jean Wei on 13-01-19.
//  Copyright (c) 2013 Ice Whale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserPreferences.h"

@interface UserPreferenceController : NSObject
{
    UserPreferences *userPref;
}

@property (strong) UserPreferences *userPref;

+ (UserPreferenceController*)instance;
- (void)startNewSettings;
- (void)manageSettings;
- (void)saveDataToDisk;

- (int)getCurrentStage;
- (BOOL)getMusic;
- (BOOL)getSoundEffect;
- (int)getLevelClearTime:(int)level;
- (int)getLevelAchievementPercentage;
- (int)saveLevelClearTime:(int)level time:(int)t;

- (void)setCurrentStage:(int)b;
- (void)setSoundEffect:(BOOL)b;
- (void)setMusic:(BOOL)b;

- (int)addCurrentLBScore:(int)a score:(int)s;
@end
