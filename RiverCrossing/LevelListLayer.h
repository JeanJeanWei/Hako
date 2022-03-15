//
//  GameplayLayer.h
//  ro3
//
//  Created by JJ WEI on 12-06-28.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "CCScrollLayer.h"


@interface LevelListLayer : CCLayer
{
    CGSize screenSize;
    CCSpriteBatchNode *sceneSpriteBatchNode;
    CCScrollLayer *scrollLayer;
}


@end
