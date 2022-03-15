//
//  VisualEffect.m
//  puzzle
//
//  Created by Jean-Jean Wei on 13-03-05.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "VisualEffect.h"

@implementation VisualEffect

+ (void)pluseEffect:(CCNode*)node
{
    CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:0.75 opacity:175];
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:0.75 opacity:255];
    CCSequence *pulseSequence = [CCSequence actionOne:fadeIn two:fadeOut];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:pulseSequence];
    [node runAction:repeat];
}

+ (void)pluseEffect:(CCNode*)node duration:(float)d
{
    CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:d opacity:127];
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:d opacity:255];
    CCSequence *pulseSequence = [CCSequence actionOne:fadeIn two:fadeOut];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:pulseSequence];
    [node runAction:repeat];
}

+ (void)fadeOutEffect:(CCNode*)node duration:(float)d
{
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:d opacity:255];
    [node runAction:fadeOut];
}
+ (void)fadeOutInEffect:(CCNode*)node fadeDuration:(float)d idleDuration:(float)d2
{
    CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:d opacity:0];
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:d opacity:255];
    CCMoveBy *idle = [CCMoveBy actionWithDuration:d2 position:ccp(0,0)];
    CCSequence *pulseSequence = [CCSequence actions:fadeOut,idle,fadeIn,nil];
    [node runAction:pulseSequence];
}
+ (void)bouncingMove:(CCNode*)node duration:(float)d posistion:(CGPoint)p
{
    id moveAction = [CCMoveTo actionWithDuration:0.9f position:ccp(p.x, p.y)];
    id moveEffect = [CCEaseBounceOut actionWithAction:moveAction];
    [node runAction:moveEffect];
}

@end
