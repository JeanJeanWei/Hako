//
//  SubMenuLayer.h
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-27.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "CCLayer.h"
#import "CCMenu.h"
#import "CCLabelTTF.h"

@interface SubMenuLayer : CCLayerColor 
{
    CGSize screenSize;
    CCMenu *subMenu;
    CCMenu *selectMenu;
    CCLayer *lowerLayer;
    CCLabelTTF *time;
    BOOL isPaused;
}
@property (strong) CCLabelTTF *time;

- (void)setLowerLayer:(CCLayer*)layer;

@end
