//
//  UserPreferenceController.m
//  math1
//
//  Created by Jean-Jean Wei on 13-01-19.
//  Copyright (c) 2013 Ice Whale. All rights reserved.
//

#import "UserPreferenceController.h"

@implementation UserPreferenceController

@synthesize userPref;

+ (UserPreferenceController*)instance
{
    static UserPreferenceController* instance = nil;
    
    if (!instance)
    {
        instance = [UserPreferenceController new];
    }
    
    return instance;
}

- (void)startNewSettings
{
    userPref = [UserPreferences new];
    [self saveDataToDisk];
}

- (void)manageSettings
{
    if ([UserPreferenceController.instance shouldStartNewSettings])
    {
        userPref = [UserPreferences new];
        [self saveDataToDisk];
    }
    else
    {
        [self loadDataFromDisk];
    }
}

- (BOOL)shouldStartNewSettings
{
    BOOL startNew = NO;
    
    NSString *hasProgress = [[NSUserDefaults standardUserDefaults] objectForKey:@"hasSettings"];
    if (!hasProgress)
    {
        startNew = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"hasSettings"];
    }
    return startNew;
}

- (NSString*)filePath:(NSString*)filename
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:filename];
    return filePath;
}

- (void)saveDataToDisk
{
    NSString * path = [self filePath:@"userPref"];
    [NSKeyedArchiver archiveRootObject:userPref toFile: path];
}

- (void)loadDataFromDisk
{
    NSString *path = [self filePath:@"userPref"];
    userPref =  [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

- (int)getLevelClearTime:(int)level
{
    int returnInt;
    
    switch (GameManager.instance.stage)
    {
        case 1:
            returnInt =  [[userPref.stage1 objectAtIndex:level] intValue];
            break;
        case 2:
            returnInt =  [[userPref.stage2 objectAtIndex:level] intValue];
            break;
        case 3:
            returnInt =  [[userPref.stage3 objectAtIndex:level] intValue];
            break;
        case 4:
            returnInt =  [[userPref.stage4 objectAtIndex:level] intValue];
            break;
        case 5:
            returnInt =  [[userPref.stage5 objectAtIndex:level] intValue];
            break;
    }
    
    return returnInt;
}

- (int)getLevelAchievementPercentage
{
    int returnInt;
    
    switch (GameManager.instance.stage)
    {
        case 1:
            returnInt =  [self getPercentage:userPref.achievementStage1];
            break;
        case 2:
            returnInt =  [self getPercentage:userPref.achievementStage2];
            break;
        case 3:
            returnInt =  [self getPercentage:userPref.achievementStage3];
            break;
        case 4:
            returnInt =  [self getPercentage:userPref.achievementStage4];
            break;
        case 5:
            returnInt =  [self getPercentage:userPref.achievementStage5];
            break;
    }
    
    return returnInt;
}

- (int)getPercentage:(NSArray*)array
{
    int returnInt = 0;
    int count = 0;
    
    for (int i = 0; i < array.count; i++)
    {
        if ([[array objectAtIndex:i] intValue] == 1)
        {
            count++;
        }
    }
    
    if (count == 20)
    {
        returnInt = 99;
    }
    else if (count == 21)
    {
        returnInt = 100;
    }
    else
    {
        returnInt = count * 5;
    }
        
    return returnInt;
}

- (int)saveLevelClearTime:(int)level time:(int)t
{
    int isNewRecord = NO;
    int record = 0;
    switch (userPref.currentStage)
    {
        case 1:
            record =  [[userPref.stage1 objectAtIndex:level] intValue];
            if (!record || t<record)
            {
                [userPref.stage1 replaceObjectAtIndex:level withObject:[NSNumber numberWithInt:t]];
                [userPref.achievementStage1 replaceObjectAtIndex:level withObject:[NSNumber numberWithInt:1]];
                [self saveDataToDisk];
                isNewRecord = t;
            }
            break;
            
        case 2:
            record =  [[userPref.stage2 objectAtIndex:level] intValue];
            if (!record || t<record) {
                [userPref.stage2 replaceObjectAtIndex:level withObject:[NSNumber numberWithInt:t]];
                [self saveDataToDisk];
                isNewRecord = t;
            }
            break;
            
        case 3:
            record =  [[userPref.stage3 objectAtIndex:level] intValue];
            if (!record || t<record) {
                [userPref.stage3 replaceObjectAtIndex:level withObject:[NSNumber numberWithInt:t]];
                [self saveDataToDisk];
                isNewRecord = t;
            }
            break;
        case 4:
            record =  [[userPref.stage4 objectAtIndex:level] intValue];
            if (!record || t<record) {
                [userPref.stage4 replaceObjectAtIndex:level withObject:[NSNumber numberWithInt:t]];
                [self saveDataToDisk];
                isNewRecord = t;
            }
            break;
            
        case 5:
            record =  [[userPref.stage5 objectAtIndex:level] intValue];
            if (!record || t<record) {
                [userPref.stage5 replaceObjectAtIndex:level withObject:[NSNumber numberWithInt:t]];
                [self saveDataToDisk];
                isNewRecord = t;
            }
            break;
            
    }
    return isNewRecord;
}
- (int)addCurrentLBScore:(int)a score:(int)s
{
    int returnValue = 0;
    switch (a) {
        case 1:
            returnValue = userPref.lbStage1+s;
            userPref.lbStage1 = returnValue;
            break;
        case 2:
            returnValue = userPref.lbStage2+s;
            userPref.lbStage2 = returnValue;
            break;
        case 3:
            returnValue = userPref.lbStage3+s;
            userPref.lbStage3 = returnValue;
            break;
        case 4:
            returnValue = userPref.lbStage4+s;
            userPref.lbStage4 = returnValue;
            break;
        case 5:
            returnValue = userPref.lbStage5+s;
            userPref.lbStage5 = returnValue;
            break;
        default:
            break;
    }
    [self saveDataToDisk];
    
    return returnValue;
}

- (int)getCurrentStage
{
    return userPref.currentStage;
}

- (BOOL)getMusic
{
    return userPref.isMusicOn;
}

- (BOOL)getSoundEffect
{
    return userPref.isSoundEffectOn;
}

//- (void)setScore1:(int)num
//{
//    userPref.name = str;
//}
//- (void)setTotal:(int)num
//{
//    userPref.total = num;
//}
//- (void)setD1:(int)num
//{
//    userPref.d1 = num;
//}
//- (void)setD2:(int)num
//{
//    userPref.d2 = num;
//}

- (void)setCurrentStage:(int)b
{
    userPref.currentStage = b;
}

- (void)setSoundEffect:(BOOL)b
{
    userPref.isSoundEffectOn = b;
    [self saveDataToDisk];
}

- (void)setMusic:(BOOL)b
{
    userPref.isMusicOn = b;
    [self saveDataToDisk];
}
@end
