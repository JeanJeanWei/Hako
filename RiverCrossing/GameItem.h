//
//  GameItem.h
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-12.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "GameObject.h"

@interface GameItem : GameObject
{
    NSMutableArray *ccAnimArray;
    CharacterStates characterState;
    ccTime delta;
}

@property (assign) CharacterStates characterState;

@end
