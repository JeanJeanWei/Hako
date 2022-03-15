//
//  CreditsScene.m
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-27.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//


#import "CreditsScene.h"


@implementation CreditsScene
-(id)init {
	self = [super init];
	if (self != nil) {
		// Background Layer
        BackgroundLayer *backgroundLayer = [[BackgroundLayer alloc] initWithType:kMainMenuBackground]; // 1
        
        [self addChild:backgroundLayer z:0]; // 2
		myCreditsLayer = [CreditsLayer node];
		[self addChild:myCreditsLayer];
	}
	return self;
}

@end
