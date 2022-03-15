//
//  LevelHelper.m
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-24.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "LevelHelper.h"

@implementation LevelHelper

+ (LevelHelper*)instance
{
    static dispatch_once_t pred = 0;
    __strong static LevelHelper *_instance = nil;
    
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
        // LevelHelper initialized
        CCLOG(@"LevelHelper Singleton, init");
        //[self loadLevelPlist];
        //[self loadLevelPlistByGroup:1];
    }
    return self;
}

- (void)loadLevelPlistByAvator:(int)avatorID
{
    levelDeployment = nil;
    NSString *fullFileName = [[NSString alloc] initWithFormat: @"Levels_%i",avatorID];
    
    // 1: Get the Path to the plist file
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fullFileName ofType:@"plist"];
    
    // 2: Read in the plist file
    levelDeployment = [NSArray arrayWithContentsOfFile:plistPath];
    
    // 3: If the plistDictionary was null, the file was not found.
    if (!levelDeployment || levelDeployment.count == 0) {
        CCLOG(@"Error reading Levels.plist");
        return; // No Plist Dictionary or file found
    }
}

- (void)loadLevelPlist
{
    NSString *fullFileName = @"Levels.plist";
    NSString *plistPath;
    
    // 1: Get the Path to the plist file
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                         NSUserDomainMask, YES)
     objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:fullFileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"Levels" ofType:@"plist"];
    }
    
    // 2: Read in the plist file
    levelDeployment = [NSArray arrayWithContentsOfFile:plistPath];
    
    // 3: If the plistDictionary was null, the file was not found.
    if (!levelDeployment || levelDeployment.count == 0) {
        CCLOG(@"Error reading Levels.plist");
        return; // No Plist Dictionary or file found
    }
}

- (NSArray*)getLevelMatrix:(int)idx
{
    return [levelDeployment objectAtIndex:idx];
}

- (void)print
{
     NSLog(@"levelDeployment= %@",levelDeployment);
     for (NSArray *level in levelDeployment) {
        NSLog(@"level= %@",level);
        for (NSString *deploy in level) {
            
                NSArray *element = [deploy componentsSeparatedByString:@","];
                for (int i = 0; i< element.count; i++) {
                    NSLog(@"i = %i, VALUE = %i",i, [[element objectAtIndex:i] intValue]);
                }
            }
        }
    
}
@end
