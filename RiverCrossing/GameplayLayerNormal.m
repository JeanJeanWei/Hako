//
//  GameplayLayerNormal.m
//  RiverCrossing
//
//  Created by JJ WEI on 12-06-29.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "GameplayLayerNormal.h"
#import "Tile2x2.h"
#import "Tile2x1.h"
#import "Tile1x1.h"
#import "Tile1x2.h"

#import "Cat.h"
#import "Horse.h"
#import "Lion.h"
#import "Bunny.h"

#import "Maid.h"
#import "Host.h"
#import "Dad.h"
#import "Uncle.h"
#import "Mom.h"

#import "Son1.h"
#import "Son2.h"
#import "Son3.h"
#import "Son4.h"
#import "Dau1.h"

#import "Avator1.h"
#import "Avator2.h"
#import "Avator3.h"

#import "Flash1x1.h"
#import "Arrow.h"

#import "LevelHelper.h"

@implementation GameplayLayerNormal


#define OFFX = boundingBox.size.width/2
#define OFFY = boundingBox.size.height/2

#pragma mark –
#pragma mark Update Method
-(void) update:(ccTime)deltaTime 
{
    CCArray *listOfGameObjects = [sceneSpriteBatchNode children]; //1
    CCArray *listOfGameObjects1 = [sceneSpriteBatchNode1 children]; //1
    for (GameCharacter *tempChar1 in listOfGameObjects1) {         // 2
        [tempChar1 updateStateWithDeltaTime:deltaTime andListOfGameObjects:listOfGameObjects1];                         // 3
    }
    for (GameCharacter *tempChar in listOfGameObjects) {         // 2
        [tempChar updateStateWithDeltaTime:deltaTime andListOfGameObjects:listOfGameObjects];                         // 3
    }
  
}


-(id) init 
{
    if((self = [super init]))
    {
        [self playBackgroundMusic];
        
        //CCDirector *director = [CCDirector sharedDirector];
        
        //CGSize screenSize = director.winSize;
       
        srandom(time(NULL)); // Seeds the random number generator
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"accessary.plist"]; // 1
        sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"accessary.png"]; // 2
        [self addChild:sceneSpriteBatchNode z:1]; // 3
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"tile.plist"]; // 1
        sceneSpriteBatchNode1 = [CCSpriteBatchNode batchNodeWithFile:@"tile.png"]; // 2
        [self addChild:sceneSpriteBatchNode1 z:0];
        
        [self createLevel];
        
        [self scheduleUpdate];
        
        // enable touches
        //  [[director touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
    }
    return self;
}

- (void)playBackgroundMusic
{
    int level = GameManager.instance.currentLevel;
    
    if (level > 17)
    {
        [SoundManager.instance playBackgroundTrack:BACKGROUND_TRACK_EXP];
    }
    else if (level > 11)
    {
        [SoundManager.instance playBackgroundTrack:BACKGROUND_TRACK_GAMEPLAY_3];
    }
    else if (level > 5)
    {
        [SoundManager.instance playBackgroundTrack:BACKGROUND_TRACK_GAMEPLAY_2];
    }
    else
    {
        [SoundManager.instance playBackgroundTrack:BACKGROUND_TRACK_GAMEPLAY_1];
    }
    
    
}

- (void)createAccessaryArray:(TileType)type
{
    if (type == k1x1) {
        a1x1 = [NSMutableArray new];
        for (int i = 0; i<5; i++) {
            [a1x1 addObject:[NSNumber numberWithInt:i]];
        }
    } else if (type == k1x2) {
        a1x2 = [NSMutableArray new];
        for (int i = 0; i<5; i++) {
            [a1x2 addObject:[NSNumber numberWithInt:i]];
        }
    } else if (type == k2x1) {
        a2x1 = [NSMutableArray new];
        for (int i = 0; i<3; i++) {
            [a2x1 addObject:[NSNumber numberWithInt:i]];
        }
    }
}
- (void)createLevel
{
    NSArray *level = [LevelHelper.instance getLevelMatrix:GameManager.instance.currentLevel];
    
    for (int i = 0; i < level.count; i++)
    {
        NSString *str = [level objectAtIndex:i];
        NSArray *element = [str componentsSeparatedByString:@","];
        int tileType = [[element objectAtIndex:0] intValue];
        int tilePos = [[element objectAtIndex:1] intValue];
        
        if (tileType == k1x1)
        {
            Tile1x1 *tile1x1 = [[Tile1x1 alloc] initWithPosition:tilePos andSprite:[self addAccessary:k1x1] andEffect:[self addEffect]];
            [sceneSpriteBatchNode1 addChild:tile1x1 z:kBodySpriteZValue tag:i];
        }
        else if (tileType == k1x2)
        {
            Tile1x2 *tile1x2 = [[Tile1x2 alloc] initWithPosition:tilePos andSprite:[self addAccessary:k1x2] andEffect:[self addEffect]];
            [sceneSpriteBatchNode1 addChild:tile1x2 z:kBodySpriteZValue tag:i];
        }
        else if (tileType == k2x1)
        {
            Tile2x1 *tile2x1 = [[Tile2x1 alloc] initWithPosition:tilePos andSprite:[self addAccessary:k2x1] andEffect:[self addEffect]];
            [sceneSpriteBatchNode1 addChild:tile2x1 z:kBodySpriteZValue tag:i];
        }
        else if (tileType == k2x2)
        {            
            Tile2x2 *tile2x2 = [[Tile2x2 alloc] initWithPosition:tilePos andSprite:[self getAvator]];
            [sceneSpriteBatchNode1 addChild:tile2x2 z:kBodySpriteZValue tag:kTile2x2Tag];
        }
    }
}

- (GameItem*)getAvator
{
    GameItem *arrow = [[Arrow alloc] init];
    arrow.position =  CGPointMake(160, 100);
    [sceneSpriteBatchNode addChild:arrow z:kBodySpriteZValue tag:kAccessaryTag];
     CGSize screenSize = [CCDirector sharedDirector].winSize;
    if (screenSize.height == 480.0f ) {
        arrow.position =  CGPointMake(160, 30);
    }
    
    
    //int type = GameManager.instance.avator;
    int type = 1;
    GameItem *returnItem;
    
    if (type == 1) {
        Avator1 *avator = [[Avator1 alloc] init];
        returnItem = avator;
    } else if (type == 2) {
        Avator2 *avator = [[Avator2 alloc] init];
        returnItem = avator;
    } else {
        Avator3 *avator = [[Avator3 alloc] init];
        returnItem = avator;
    }
    [sceneSpriteBatchNode addChild:returnItem z:kBodySpriteZValue tag:kAccessaryTag];
    
    return returnItem;
}

- (GameItem*)creat1x1accessary
{
    if (a1x1.count == 0) {
        [self createAccessaryArray:k1x1];
    }
    
    int pos = arc4random() % a1x1.count;
    int type = [[a1x1 objectAtIndex:pos] intValue];
    
    GameItem *returnItem;
    
    if (type == 0)
    {
        Son1 *item = [[Son1 alloc] init];
        returnItem = item;
    }
    else if (type == 1)
    {
        Son2 *item = [[Son2 alloc] init];
        returnItem = item;
    }
    else if (type == 2)
    {
        Son3 *item = [[Son3 alloc] init];
        returnItem = item;
    }
    else if (type == 3)
    {
        Son4*item = [[Son4 alloc] init];
        returnItem = item;
    }
    else
    {
        Dau1 *item= [[Dau1 alloc] init];
        returnItem = item;
    }
    [sceneSpriteBatchNode addChild:returnItem z:kBodySpriteZValue tag:kAccessaryTag];
    [a1x1 removeObjectAtIndex:pos];
    return returnItem;
}
- (GameItem*)creat1x2accessary
{
    if (a1x2.count == 0) {
        [self createAccessaryArray:k1x2];
    }
    
    int pos = arc4random() % a1x2.count;
    int type = [[a1x2 objectAtIndex:pos] intValue];
    
    
    GameItem *returnItem;
    
    if (type == 0)
    {
        Dad *item= [[Dad alloc] init];
        returnItem = item;

    }
    else if (type == 1)
    {
        Uncle *item = [[Uncle alloc] init];
        returnItem = item;
    }
    else if (type == 2)
    {
        Maid *item = [[Maid alloc] init];
        returnItem = item;
    }
    else if (type == 3)
    {
        Mom *item = [[Mom alloc] init];
        returnItem = item;
    }
    else
    {
        Host *item = [[Host alloc] init];
        returnItem = item;
    }
    [sceneSpriteBatchNode addChild:returnItem z:kBodySpriteZValue tag:kAccessaryTag];
    [a1x2 removeObjectAtIndex:pos];
    return returnItem;
}
- (GameItem*)creat2x1accessary
{
    if (a2x1.count == 0) {
        [self createAccessaryArray:k2x1];
    }
    
    int pos = arc4random() % a2x1.count;
    int type = [[a2x1 objectAtIndex:pos] intValue];
    
    GameItem *returnItem;
    
    if (type == 0)
    {
        Cat *item = [[Cat alloc] init];
        returnItem = item;
    }
    else if (type == 1)
    {
        Horse *item = [[Horse alloc] init];
        returnItem = item;

    }
//    else if (type == 2)
//    {
//        Bunny *item = [[Bunny alloc] init];
//        returnItem = item;
//    }
    else
    {
        Lion *item= [[Lion alloc] init];
        returnItem = item;
    }
    [sceneSpriteBatchNode addChild:returnItem z:kBodySpriteZValue tag:kAccessaryTag];
    [a2x1 removeObjectAtIndex:pos];
    return returnItem;
}
- (GameItem*)addAccessary:(TileType)type
{
    if (type == k1x1)
    {
        return [self creat1x1accessary];
    }
    else if (type == k1x2)
    {
        return [self creat1x2accessary];
    }
    else
    {
        return [self creat2x1accessary];
    }
    return nil;
}

- (GameItem*)addEffect
{
    GameItem *returnItem;
    
    Flash1x1 *item = [[Flash1x1 alloc] init];
    returnItem = item;
    
    [sceneSpriteBatchNode addChild:returnItem z:kBodySpriteZValue tag:kAccessaryTag];
    return returnItem;
}
@end
