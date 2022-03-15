//
//  GameItem.m
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-12.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "GameItem.h"

@implementation GameItem

@synthesize characterState;

-(void)checkAndClampSpritePosition
{
    
}

-(void)changeState:(CharacterStates)newState
{
    [self stopAllActions];
    id action = nil;
    //  self.characterState = newState;
    
    switch (newState)
    {
        case kStateIdle:
            ;
            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kBreathingAnim]];
            break;
            
        case kStateWalking:
            
            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kWalkingAnim]];
            
            break;
            
        case kStateCrouching:
            
            
            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kCrouchingAnim]];
            break;
            
            
        case kStateBreathing:
            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kBreathingAnim]];
            break;
        case kStatePreIdle:
            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kPreIdlingAnim]];
            self.characterState = kStateIdle;
            break;
            
        default:
            break;
    }
    if (action != nil)
    {
        [self runAction:action];
    }
}

#pragma mark -
-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray*)listOfGameObjects
{
    
    [self checkAndClampSpritePosition];
    
    
    if ([self numberOfRunningActions] == 0)
    {
        if (self.characterState == kStatePreIdle)
        {
            [self changeState:kStateIdle];
        }
        else
        {
            [self changeState:self.characterState];
        }
        
        
    }
    
}




@end
