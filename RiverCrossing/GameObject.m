//
//  GameObject.m
//  ro3
//
//  Created by JJ WEI on 12-06-27.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject

@synthesize reactsToScreenBoundaries;
@synthesize screenSize;
@synthesize isActive;
@synthesize gameObjectType;
@synthesize gameObjDirection;

-(id) init 
{
    self = [super init];
    if (self != nil)
    {
        CCLOG(@"GameObject init");
        screenSize = [CCDirectorIOS sharedDirector].winSize;
        
        isActive = TRUE;
        gameObjectType = kObjectTypeNone;
    }
    return self;
}

- (void)changeState:(CharacterStates)newState; 
{
    CCLOG(@"GameObject->changeState method should be overridden");
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime
           andListOfGameObjects:(CCArray*)listOfGameObjects 
{
    CCLOG(@"updateStateWithDeltaTime method should be overridden");
}

-(CGRect)adjustedBoundingBox 
{
    CCLOG(@"GameObect adjustedBoundingBox should be overridden");
    return [self boundingBox];
}

-(CCAnimation*)loadPlistForAnimationWithName:(NSString*)animationName andClassName:(NSString*)className 
{
    CCAnimation *animationToReturn = nil;
    NSString *fullFileName = [NSString stringWithFormat:@"%@.plist",className];
    NSString *plistPath;
    
    // 1: Get the Path to the plist file
    NSString *rootPath =
    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                         NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:fullFileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) 
    {
        plistPath = [[NSBundle mainBundle] pathForResource:className ofType:@"plist"];
    }
    // 2: Read in the plist file
    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    // 3: If the plistDictionary was null, the file was not found.
    if (plistDictionary == nil) 
    {
        CCLOG(@"Error reading plist: %@.plist", className);
        return nil; // No Plist Dictionary or file found
    }
    // 4: Get just the mini-dictionary for this animation
    NSDictionary *animationSettings = [plistDictionary objectForKey:animationName];
    if (animationSettings == nil) 
    {
        CCLOG(@"Could not locate AnimationWithName:%@",animationName);
        return nil;
    }
    // 5: Get the delay and restoreOriginalFrame value for the animation
    float animationDelay =[[animationSettings objectForKey:@"delay"] floatValue];
    BOOL restoreOriginalFrame = [[animationSettings objectForKey:@"restoreOriginalFrame"] boolValue];
    animationToReturn = [CCAnimation animation];
    animationToReturn.delayPerUnit = animationDelay;
    animationToReturn.restoreOriginalFrame = restoreOriginalFrame;
    
    // 6: Add the frames to the animation
    NSString *animationFramePrefix = [animationSettings objectForKey:@"filenamePrefix"];
    NSString *animationFrames = [animationSettings objectForKey:@"animationFrames"];
    NSArray *animationFrameNumbers = [animationFrames componentsSeparatedByString:@","];
          
    for (NSString *frameNumber in animationFrameNumbers) 
    {
        NSString *frameName = [NSString stringWithFormat:@"%@%@.png", animationFramePrefix,frameNumber];
        [animationToReturn addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName]];
    }
   
    return animationToReturn;
}

@end
