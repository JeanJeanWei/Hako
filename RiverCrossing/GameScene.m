//
//  GameScene.m
//  ro3
//
//  Created by JJ WEI on 12-06-27.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "GameScene.h"
#import "SubMenuLayer.h"

@implementation GameScene

-(id)init {
    self = [super init];
    if (self != nil) {
        // Background Layer
        BackgroundLayer *backgroundLayer = [[BackgroundLayer alloc] initWithType:kGameLevel1Background]; // 1
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        if (screenSize.height == 480.0f ) {
            CGPoint p = backgroundLayer.position;
            backgroundLayer.position = ccp(p.x, p.y-44);
        }
        [self addChild:backgroundLayer z:0]; // 2
        
        GameplayLayerNormal *gameplayLayer = [GameplayLayerNormal node]; // 3
        [self addChild:gameplayLayer z:5]; // 4
        // Gameplay Layer
        SubMenuLayer *subMenuLayer = [SubMenuLayer node]; // 3
        [subMenuLayer setLowerLayer:gameplayLayer];
        [self addChild:subMenuLayer z:6]; // 4

    }
    return self;
}

@end
