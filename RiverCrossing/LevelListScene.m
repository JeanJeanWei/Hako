//
//  GameScene.m
//  ro3
//
//  Created by JJ WEI on 12-06-27.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "LevelListScene.h"
#import "LevelListLayer.h"
@implementation LevelListScene

-(id)init {
    self = [super init];
    if (self != nil) {
        // Background Layer
        BackgroundLayer *backgroundLayer = [[BackgroundLayer alloc] initWithType:kMainMenuBackground]; // 1
        [self addChild:backgroundLayer z:0]; // 2
        // Gameplay Layer
       // GameplayLayer *gameplayLayer = [GameplayLayer node]; // 3
       // [self addChild:gameplayLayer z:5]; // 4
        
         LevelListLayer *levelListLayer = [LevelListLayer node]; // 3
         [self addChild:levelListLayer z:5]; // 4
    }
    return self;
}

@end
