//
//  AvatorListScene.m
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-26.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "AvatorListScene.h"

@implementation AvatorListScene

-(id)init {
    self = [super init];
    if (self != nil) {
        BackgroundLayer *backgroundLayer = [[BackgroundLayer alloc] initWithType:kMainMenuBackground]; // 1
        [self addChild:backgroundLayer z:0]; // 2
        avatorListLayer = [AvatorListLayer node];
        [self addChild:avatorListLayer];
    }
    return self;
}

@end
