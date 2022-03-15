//
//  Maid.h
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-16.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "GameItem.h"

@interface Maid : GameItem
{
//    NSMutableArray *ccAnimArray;
    CharacterAnimTypes *ccAnimTypes;
    float millisecondsStayingIdle;
}

@end
