//
//  GameObject.h
//  ro3
//
//  Created by JJ WEI on 12-06-27.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"

@interface GameObject : CCSprite
{
    BOOL isActive;
    BOOL reactsToScreenBoundaries;
    int tag;
    CGSize screenSize;
    GameObjectType gameObjectType;
    GameObjectTag gameObjectTag;
    GameObjDirection gameObjDirection;
}

@property (assign) BOOL isActive;
@property (assign) BOOL reactsToScreenBoundaries;
@property (assign) CGSize screenSize;
@property (assign) GameObjectType gameObjectType;
@property (assign) GameObjDirection gameObjDirection;

- (void)changeState:(CharacterStates)newState;
- (void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray*)listOfGameObjects;
- (CGRect)adjustedBoundingBox;
- (CCAnimation*)loadPlistForAnimationWithName:(NSString*)animationName andClassName:(NSString*)className;

@end
