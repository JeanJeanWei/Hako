//
//  ProfileScene.m
//  puzzle
//
//  Created by Jean-Jean Wei on 13-03-04.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "ProfileScene.h"

@implementation ProfileScene

-(id)init
{
	self = [super init];
	if (self != nil) {
		// Background Layer
        BackgroundLayer *backgroundLayer = [[BackgroundLayer alloc] initWithType:kMainMenuBackground]; // 1
        [self addChild:backgroundLayer z:0]; // 2
		profileLayer = [ProfileLayer node];
		[self addChild:profileLayer];
	}
	return self;
}
@end
