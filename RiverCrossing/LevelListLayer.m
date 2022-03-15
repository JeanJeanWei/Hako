//
//  GameplayLayer.m
//  ro3
//
//  Created by JJ WEI on 12-06-28.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "LevelListLayer.h"

#import "UserPreferenceController.h"
#import "VisualEffect.h"

@implementation LevelListLayer


#pragma mark –
#pragma mark Update Method



- (id)init
{
    self = [super init];
    if (self != nil)
    {
        [SoundManager.instance playBackgroundTrack:BACKGROUND_TRACK_MAIN_MENU];
        screenSize = [CCDirector sharedDirector].winSize;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btn_sprite.plist"];
        CCSpriteBatchNode *buttonSprites = [CCSpriteBatchNode batchNodeWithFile:@"btn_sprite.png"];
        [self addChild:buttonSprites];
        
        NSString *plistName = [[NSString alloc] initWithFormat:@"stageList_%d.plist",GameManager.instance.stage];
        
        NSString *pngName = [[NSString alloc] initWithFormat:@"stageList_%d.png",GameManager.instance.stage];
        
      
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:plistName];
        CCSpriteBatchNode *levelSprites = [CCSpriteBatchNode batchNodeWithFile:pngName];
        [self addChild:levelSprites];
        
 
//        NSString *str = [[NSString alloc] initWithFormat:@"lv_sel_%i.png",GameManager.instance.avator];
//        CCSprite *avatorBG = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:str]];
//        avatorBG.position = ccp(screenSize.width/2,screenSize.height*0.55);
//        [self addChild:avatorBG];
        
        scrollLayer = [[CCScrollLayer alloc] initWithLayers:[self createPages] widthOffset:10];

        
        [scrollLayer setMinimumTouchLengthToChangePage:10.0f];
        [scrollLayer selectPage:GameManager.instance.currentPage];
        [self addChild:scrollLayer];
        
        
        CCLabelTTF *backLabel = [CCLabelTTF labelWithString:NSLocalizedString(@"Back", nil) fontName:@"Marker Felt" fontSize:18];
        
        CCMenuItemSprite *menuButton = [CCMenuItemSprite itemWithNormalSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"button2.png"]]
                                                               selectedSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"button2_selected.png"]]
                                                                        block:^(id sender) {
                                                                            [SoundManager.instance playSoundEffect:@"btnClick1"];
                                                                             GameManager.instance.currentPage = scrollLayer.currentScreen;
                                                                            //[[GameManager instance] runSceneWithID:kAvatorListScene];
                                                                            [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
                                                                            [[GameManager instance] runSceneWithID:kAvatorListScene];
                                                                        }];
        
        
        
        
        backLabel.position = ccp(menuButton.boundingBox.size.width/2,menuButton.boundingBox.size.height/2);
        
        [menuButton addChild:backLabel];
        
        
        CCMenu *subMenu = [CCMenu menuWithItems:menuButton,nil];
        [subMenu alignItemsVertically];
        [subMenu setPosition: ccp(screenSize.width * 0.86f, screenSize.height *0.15)];
        NSLog(@"screenSize.height == %f",screenSize.height);
        if (screenSize.height == 480.0f ) {
            [subMenu setPosition: ccp(screenSize.width * 0.85f, 50.0f+17.5f)];
        }
        CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:0.5 opacity:127];
        CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:0.5 opacity:255];
        CCSequence *pulseSequence = [CCSequence actionOne:fadeIn two:fadeOut];
        CCRepeatForever *repeat = [CCRepeatForever actionWithAction:pulseSequence];
        [subMenu runAction:repeat];
        [self addChild:subMenu];
        
       
    }
    return self;
}
- (CCSprite*)creatSprite:(int)level selected:(BOOL)isSelected
{
    NSString *spriteName;
    int time = [UserPreferenceController.instance getLevelClearTime:level];
    
    if (time) {
        spriteName  = [[NSString alloc] initWithFormat:@"lv_%d_1.png",level];
    } else {
        spriteName  = [[NSString alloc] initWithFormat:@"lv_%d_0.png",level];
    }
    
    CCSprite *sp = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:spriteName]];
    if (isSelected) {
        [sp setColor:ccc3(150, 150, 0)];
    }
    NSString *str;
    if (time>9999) {
        str = [NSString stringWithFormat:NSLocalizedString(@"Over", nil), time];
    } else if (time == 0){
        //str = [[NSString alloc] initWithFormat:@"尚未過關"];
        str = NSLocalizedString(@"NA", nil);
         
    } else {
        str = [NSString stringWithFormat:NSLocalizedString(@"Sec", nil), time];
    }
    CCLabelTTF *lblFont = [CCLabelTTF labelWithString:str fontName:@"Marker Felt" fontSize:11];
    lblFont.color = ccc3(0, 0, 255);
    lblFont.position = ccp(sp.boundingBox.size.width*0.52,sp.boundingBox.size.height*0.14);
    [sp addChild:lblFont];
    return sp;
}

- (NSArray *)createPages
{
    int rowPerPage = 2;
    int itemPerRow = 3;
    int normalPage = 3;
    
    int level = 0;
    NSMutableArray *returnArray = [NSMutableArray new];
    
    for (int j = 0; j<normalPage; j++) {
        
        
        CCLayer *page = [[CCLayer alloc] init];
       
        for (int k = 0; k<rowPerPage; k++)
        {
            NSMutableArray *itemArray = [NSMutableArray new];
            for (int i=0; i<itemPerRow; i++) {
                
                                NSLog(@"%d",level);
                CCMenuItemSprite *itemButton = [CCMenuItemSprite itemWithNormalSprite:[self creatSprite:level selected:NO]
                                                                       selectedSprite:[self creatSprite:level selected:YES]
                                                                                block:^(id sender) {
                                                                                    GameManager.instance.currentLevel = level;
                                                                                    [self playLevel];
                                                                                }];
                [itemArray addObject:itemButton];
                level++;
            }
            CCMenu *menu = [CCMenu menuWithArray:itemArray];
            [menu alignItemsHorizontally];
            menu.position = ccp(screenSize.width * 0.5f, screenSize.height *0.70f - k*150);
            [page addChild:menu];
        }
        
        
        [returnArray addObject:page];
    }
    
    for (int j = 0; j<1; j++) {
        
        
        CCLayer *page = [[CCLayer alloc] init];
        NSMutableArray *itemArray = [NSMutableArray new];
        for (int i = 0; i<3; i++)
        {
            
            NSLog(@"locked level %d",level);
            CCMenuItemSprite *itemButton = [CCMenuItemSprite itemWithNormalSprite:[self creatSprite:level selected:NO]
                                                                   selectedSprite:[self creatSprite:level selected:YES]
                                                                            block:^(id sender) {
                                                                                GameManager.instance.currentLevel = level;
                                                                                [self playLevel];
                                                                            }];
            [itemArray addObject:itemButton];
            level++;
        }
        
        
        CCMenu *mainMenu = [CCMenu menuWithArray:itemArray];
        
        //NSNumber* itemsPerRow = [NSNumber numberWithInt:3];
        [mainMenu alignItemsHorizontally];
        mainMenu.position = ccp(screenSize.width * 0.5f, screenSize.height *0.55f);
        
        [page addChild:mainMenu];
        [returnArray addObject:page];
    }
    
    return returnArray;
    
}
- (void)playLevel {
    GameManager.instance.currentPage = scrollLayer.currentScreen;
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [GameManager.instance runSceneWithID:kGameLevel1];
}

@end
