//
//  Tile1x2.h
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-03.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "GameCharacter.h"

@interface Tile1x2 : GameCharacter
{
    NSMutableArray *ccAnimArray;
    CharacterAnimTypes *ccAnimTypes;
    float millisecondsStayingIdle;
//    GameCharacter *accessary;
}

- (id)initWithPosition:(int)pos andSprite:(id)obj andEffect:(GameItem*)effect;

@end
