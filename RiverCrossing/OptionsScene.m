//
//  OptionsScene.m
//  SpaceViking
//
//  Created by Rod on 9/18/10.
//  Copyright 2010 Prop Group LLC - www.prop-group.com. All rights reserved.
//

#import "OptionsScene.h"

@implementation OptionsScene
-(id)init {
	self = [super init];
	if (self != nil) {
        BackgroundLayer *backgroundLayer = [[BackgroundLayer alloc] initWithType:kMainMenuBackground]; // 1
        [self addChild:backgroundLayer z:0]; // 2
		OptionsLayer *myLayer = [OptionsLayer node];
		[self addChild:myLayer];
		
	}
	return self;
}
@end
