//
//  Tile2x1.h
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-03.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "GameCharacter.h"

@interface Tile2x1 : GameCharacter
{
    NSMutableArray *ccAnimArray;
    CharacterAnimTypes *ccAnimTypes;
    float millisecondsStayingIdle;
}

- (id)initWithPosition:(int)pos andSprite:(id)obj andEffect:(GameItem*)effect;
@end
