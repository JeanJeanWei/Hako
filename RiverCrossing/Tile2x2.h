//
//  Tile2x2.h
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-03.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "GameCharacter.h"

@interface Tile2x2 : GameCharacter
{
    NSMutableArray *ccAnimArray;
    CharacterAnimTypes *ccAnimTypes;
    float millisecondsStayingIdle;
//    GameCharacter *accessary;
    CGPoint goalPoint;
}

- (id)initWithPosition:(int)pos andSprite:(id)obj;

@end
