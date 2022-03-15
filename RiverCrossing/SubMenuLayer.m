//
//  SubMenuLayer.m
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-27.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "SubMenuLayer.h"

@interface SubMenuLayer()
-(void)displayMenu;
-(void)displaySelection;

@end

@implementation SubMenuLayer

@synthesize time;

-(id)init {
    self = [super init];
    if (self != nil) {
       self.color = ccBLACK;
        NSString *str = [NSString stringWithFormat:NSLocalizedString(@"Sec", nil), 0];
        time = [CCLabelTTF labelWithString:str fontName:@"Marker Felt" fontSize:12];
        [self addChild:time];
        GameManager.instance.levelClearTime = 0;
        [self schedule:@selector(timerUpdate:) interval:1];
        [self displayMenu];


    }
    return self;
}
-(void) timerUpdate:(ccTime)delta
{
    if (!isPaused) {
        GameManager.instance.levelClearTime++;
        NSString *str = [NSString stringWithFormat:NSLocalizedString(@"Time", nil),GameManager.instance.levelClearTime];
        //NSString *str = [[NSString alloc] initWithFormat:@"%@ %d %@",NSLocalizedString(@"Time", nil),GameManager.instance.levelClearTime,NSLocalizedString(@"Sec", nil)];
        time.string = str;
    }

    // update timer here, using numSeconds
}
-(void)setLowerLayer:(CCLayer*)layer
{
    lowerLayer = layer;;
}

-(void)showOptions {
    CCLOG(@"Show the Options screen");
    [[GameManager instance] runSceneWithID:kOptionsScene];
}

-(void)itemSelected:(int)idx {
    GameManager.instance.movingInProgress = NO;
    if (idx == 1) {
        CCLOG(@"Tag 1 found, Scene 1");
        
       
        [[GameManager instance] runSceneWithID:kLevelListScene];
    }
    else if (idx == 2) {
        CCLOG(@"Tag 1 found, Scene 1");
       
        
        [[GameManager instance] runSceneWithID:kGameLevel1];
    }
    
    else {
        CCLOG(@"Tag was: %d", idx);
        CCLOG(@"Placeholder for next chapters");
    }
}

-(void)displayMenu {
    if (lowerLayer) {
        lowerLayer.visible = YES;
        GameManager.instance.movingInProgress = NO;
    }
    
    isPaused = NO;
    
    self.opacity = 0;
    screenSize = [CCDirector sharedDirector].winSize;
    if (selectMenu != nil) {
        [selectMenu removeFromParentAndCleanup:YES];
    }
    // Main Menu
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btn_sprite.plist"];
    CCSpriteBatchNode *buttonSprites = [CCSpriteBatchNode batchNodeWithFile:@"btn_sprite.png"];
    [self addChild:buttonSprites];
    
    
    CCLabelTTF *lblFont = [CCLabelTTF labelWithString:NSLocalizedString(@"Menu", nil) fontName:@"Marker Felt" fontSize:18];
    
    CCMenuItemSprite *menuButton = [CCMenuItemSprite itemWithNormalSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"button2.png"]]
                                                           selectedSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"button2_selected.png"]]
                                                                    block:^(id sender) {
                                                                        GameManager.instance.movingInProgress = YES;
                                                                        [self displaySelection];
                                                                        
                                                                    }];
    
    
    
    
    lblFont.position = ccp(menuButton.boundingBox.size.width/2,menuButton.boundingBox.size.height/2);
    
    [menuButton addChild:lblFont];
    
    
    subMenu = [CCMenu menuWithItems:menuButton,nil];
    [subMenu alignItemsVertically];
    [subMenu setPosition: ccp(screenSize.width * 0.86f, screenSize.height *0.2)];
    
    // timer
    time.position = ccp(screenSize.width * 0.2f, screenSize.height *0.2);

    NSLog(@"screenSize.height == %f",screenSize.height);
    if (screenSize.height == 480.0f ) {
        subMenu.position = ccp(screenSize.width * 0.85f, 50.0f);
        time.position = ccp(screenSize.width * 0.16f, 50.0f);
    }
    CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:0.5 opacity:127];
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:0.5 opacity:255];
    CCSequence *pulseSequence = [CCSequence actionOne:fadeIn two:fadeOut];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:pulseSequence];
    [subMenu runAction:repeat];
    [self addChild:subMenu];

}

-(void)displaySelection {
    isPaused = YES;
    if (subMenu != nil) {
        [subMenu removeFromParentAndCleanup:YES];
    }
    if (lowerLayer) {
        lowerLayer.visible = NO;
    }
    
    self.opacity = 178;
    CCLabelTTF *itemLabel1 = [CCLabelTTF labelWithString:NSLocalizedString(@"GoToLevelList", nil) fontName:@"Marker Felt" fontSize:20];
    CCMenuItemLabel *item1 = [CCMenuItemLabel itemWithLabel:itemLabel1
                                                      block:^(id sender) {
                                                          [self itemSelected:1];
                                                      }];
    
    CCLabelTTF *itemLabel2 = [CCLabelTTF labelWithString:NSLocalizedString(@"Retry", nil) fontName:@"Marker Felt" fontSize:20];
    CCMenuItemLabel *item2 = [CCMenuItemLabel itemWithLabel:itemLabel2
                                                      block:^(id sender) {
                                                          [self itemSelected:2];
                                                      }];

    CCLabelTTF *backButtonLabel = [CCLabelTTF labelWithString:NSLocalizedString(@"Resume", nil) fontName:@"Marker Felt" fontSize:20];
    CCMenuItemLabel *backButton = [CCMenuItemLabel itemWithLabel:backButtonLabel
                                                      block:^(id sender) {
                                                          [self displayMenu];
                                                      }];
    //selectMenu = [CCMenu menuWithItems:playScene1,playScene2,playScene3,playScene4,playScene5,backButton,nil];
    selectMenu = [CCMenu menuWithItems:item1,item2,backButton,nil];
    
    [selectMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
    [selectMenu setPosition:ccp(screenSize.width * 2,
                                screenSize.height / 2)];
    
    id moveAction = [CCMoveTo actionWithDuration:0.5f
                                        position:ccp(screenSize.width * 0.65f,
                                                     screenSize.height/2)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
    [selectMenu runAction:moveEffect];
    [self addChild:selectMenu z:1 tag:kSceneMenuTagValue];
}
@end
