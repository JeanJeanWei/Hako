//
//  GameCharactor.h
//  ro3
//
//  Created by JJ WEI on 12-06-27.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "GameObject.h"
#import "GameItem.h"
#import "TileHelper.h"

@interface GameCharacter : GameObject <CCTargetedTouchDelegate>
{
    GameItem *accessary;
    GameItem *accessaryEffect;
    
    CGPoint startPoint;
    CGPoint endPoint;
    CGPoint oldPosition;
    
     CGPoint originPos;
    UITouch *lastTouch;
    
    BOOL characterIsPicked;
    CGPoint velocity;
    float degrees;
    float dSqrt;
    
    CharacterStates characterState;
    
    ccTime delta;
    BOOL is2x2;
}


@property (assign) CharacterStates characterState;

-(void)checkAndClampSpritePosition;
- (CGPoint)getEffectPos:(CGPoint)pos;
@end
