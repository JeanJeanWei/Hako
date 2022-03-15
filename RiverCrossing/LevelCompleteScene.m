//
//  LevelCompleteScene.m
//  SpaceViking
//
//  Created by Rod on 10/7/10.
//  Copyright 2010 Prop Group LLC - www.prop-group.com. All rights reserved.
//

#import "LevelCompleteScene.h"
#import "LevelCompleteLayer.h"

@implementation LevelCompleteScene
-(id)init {
	self = [super init];
	if (self != nil) {
        BackgroundLayer *backgroundLayer = [[BackgroundLayer alloc] initWithType:kLevelCompleteBackground]; // 1
//        CGSize screenSize = [CCDirector sharedDirector].winSize;
//        float offY = (700 - screenSize.height)/2;
//        CGPoint p = backgroundLayer.position;
//        p.y -= offY;
//		backgroundLayer.position = p;
//        if (screenSize.height == 480.0f ) {
//            p = backgroundLayer.position;
//            backgroundLayer.position = ccp(p.x, p.y);
//        }
        [self addChild:backgroundLayer z:0]; // 2
		LevelCompleteLayer *myLayer = [LevelCompleteLayer node];
		[self addChild:myLayer];
	}
	return self;
}
@end
