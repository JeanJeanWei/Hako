//
//  AvatorListLayer.m
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-26.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "AvatorListLayer.h"
#import "CCRadioMenu.h"
#import "UserPreferenceController.h"
#import "LevelHelper.h"

#define str_normal @"請選擇支持者"
#define str_selected @"GO!"

@implementation AvatorListLayer
-(id)init {
    self = [super init];
    if (self != nil) {
        //CGSize screenSize = [CCDirector sharedDirector].winSize;

        //                CCSprite *background =
        //                [CCSprite spriteWithFile:@"menu.png"];
        //                [background setPosition:ccp(screenSize.width/2,
        //                                            screenSize.height/2)];
        //                [self addChild:background];
        [self displayAvatorMenu];
        double delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [SoundManager.instance playSoundEffect:@"jump1"];
        });
        
        
    }
    return self;
}
- (void)switchAvator:(CCMenuItemSprite*)item
{
    [SoundManager.instance playSoundEffect:@"btnClick2"];
    GameManager.instance.stage = item.tag;
    [UserPreferenceController.instance setCurrentStage:GameManager.instance.stage];
    CCLOG(@"item.tag = %d",item.tag );
    CCLOG(@"GameManager.instance.stage = %d",GameManager.instance.stage );
    lblGo.string = str_selected;
    [self blinkEffect:item stopAction:YES];
}

- (void)goTapped
{
     [SoundManager.instance playSoundEffect:@"btnClick1"];
    if (GameManager.instance.stage) {
        [LevelHelper.instance loadLevelPlistByAvator:GameManager.instance.stage];
        [GameManager.instance runSceneWithID:kLevelListScene];
        [UserPreferenceController.instance setCurrentStage:GameManager.instance.stage];
         CCLOG(@"goTapped GameManager.instance.stage = %d",GameManager.instance.stage );
        [UserPreferenceController.instance saveDataToDisk];
    }
}

- (void)stopAvtorAction
{
    menuItem1.opacity = 255;
    menuItem2.opacity = 255;
    menuItem3.opacity = 255;
    menuItem4.opacity = 255;
    menuItem5.opacity = 255;
    menuItem6.opacity = 255;
    [menuItem1 stopAllActions];
    [menuItem2 stopAllActions];
    [menuItem3 stopAllActions];
    [menuItem4 stopAllActions];
    [menuItem5 stopAllActions];
    [menuItem6 stopAllActions];
}
- (void)blinkEffect:(CCNode*)node stopAction:(BOOL)stop
{
    if (stop) {
        [self stopAvtorAction];
    }
    
    
    CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:0.5 opacity:127];
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:0.5 opacity:255];
    CCSequence *pulseSequence = [CCSequence actionOne:fadeIn two:fadeOut];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:pulseSequence];
    [node runAction:repeat];
}
-(void)displayAvatorMenu
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //    if (sceneSelectMenu != nil) {
    //        [sceneSelectMenu removeFromParentAndCleanup:YES];
    //    }
    // Main Menu
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btn_sprite.plist"];
    CCSpriteBatchNode *buttonSprites = [CCSpriteBatchNode batchNodeWithFile:@"btn_sprite.png"];
    [self addChild:buttonSprites];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"avator.plist"];
    CCSpriteBatchNode *stageSprites = [CCSpriteBatchNode batchNodeWithFile:@"avator.png"];
    [self addChild:stageSprites];
    
    
    lblGo = [CCLabelTTF labelWithString:@" " fontName:@"Marker Felt" fontSize:22];
    CCMenuItemSprite *btnGo= [CCMenuItemSprite itemWithNormalSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"button1.png"]]
                                                     selectedSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"button1_selected.png"]]
                                                              block:^(id sender) {
                                                                  [self goTapped];
                                                              }];
    lblGo.position = ccp(btnGo.boundingBox.size.width/2,btnGo.boundingBox.size.height/2);
    
    [btnGo addChild:lblGo];
    CCMenu *mainMenu = [CCMenu menuWithItems:btnGo,nil];
    [mainMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
    [mainMenu setPosition: ccp(screenSize.width * 0.5f, screenSize.height * 0.3f)];
    [mainMenu setOpacity:1.0];
    CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:0.5 opacity:127];
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:0.5 opacity:255];
    
    CCSequence *pulseSequence = [CCSequence actionOne:fadeIn two:fadeOut];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:pulseSequence];
    [mainMenu runAction:repeat];
    
    [self addChild:mainMenu];
    
    //
    // create stage list radio buttons
    menuItem1 = [CCMenuItemSprite itemWithNormalSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"avator1_0.png"]]
                                                          selectedSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"avator1_1.png"]]
                                                                   block:^(id sender) {
                                                                       [self switchAvator:(CCMenuItemSprite*)sender];
                                                                   }];
    menuItem1.tag = 1;
    
    menuItem2 = [CCMenuItemSprite itemWithNormalSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"avator2_0.png"]]
                                                          selectedSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"avator2_1.png"]]
                                                                   block:^(id sender) {
                                                                       [self switchAvator:(CCMenuItemSprite*)sender];
                                                                   }];
    menuItem2.tag = 2;
    
    menuItem3 = [CCMenuItemSprite itemWithNormalSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"avator3_0.png"]]
                                                          selectedSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"avator3_1.png"]]
                                                                   block:^(id sender) {
                                                                       [self switchAvator:(CCMenuItemSprite*)sender];
                                                                   }];
    menuItem3.tag = 3;
    
    menuItem4 = [CCMenuItemSprite itemWithNormalSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"avator4_0.png"]]
                                        selectedSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"avator4_1.png"]]
                                                 block:^(id sender) {
                                                     [self switchAvator:(CCMenuItemSprite*)sender];
                                                 }];
    menuItem4.tag = 4;
    
    menuItem5 = [CCMenuItemSprite itemWithNormalSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"avator5_0.png"]]
                                        selectedSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"avator5_1.png"]]
                                                 block:^(id sender) {
                                                     [self switchAvator:(CCMenuItemSprite*)sender];
                                                 }];
    menuItem5.tag = 5;
    
    menuItem6 = [CCMenuItemSprite itemWithNormalSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"avator6_0.png"]]
                                        selectedSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"avator6_0.png"]]
                                                 block:^(id sender) {
                                                     //[self switchAvator:(CCMenuItemSprite*)sender];
                                                 }];
    menuItem6.tag = 6;
    
//    CCRadioMenu *radioMenu = [CCRadioMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
//    CCRadioMenu *radioMenu2 = [CCRadioMenu menuWithItems:menuItem4, menuItem5, menuItem6, nil];
//    CCRadioMenu *radioMenu = [CCRadioMenu menuWithItems:menuItem1, menuItem4, menuItem2, menuItem5, menuItem3, menuItem6, nil];
CCRadioMenu *radioMenu = [CCRadioMenu menuWithItems:menuItem1, menuItem2, menuItem3, menuItem4, menuItem5, menuItem6, nil];
    
    //[radioMenu alignItemsHorizontallyWithPadding:screenSize.width * 0.02f];
    NSNumber* itemsPerRow = [NSNumber numberWithInt:3];
    [radioMenu alignItemsInColumns:itemsPerRow, itemsPerRow,nil];
    
    [radioMenu setPosition:ccp(screenSize.width * 0.5f, screenSize.height*0.60)];
   
    
//    id moveAction = [CCMoveTo actionWithDuration:0.9f position:ccp(screenSize.width * 0.5f, screenSize.height*0.6)];
//    id moveEffect = [CCEaseBounceOut actionWithAction:moveAction];
//    [radioMenu runAction:moveEffect];
    
    //[radioMenu alignItemsHorizontally];
    
        //radioMenu.selectedItem = menuItem1;
     CCLOG(@"stage = %d",GameManager.instance.stage);
         switch (GameManager.instance.stage) {
             case 0:
                 lblGo.string = str_normal;
                 break;
             case 1:
                 lblGo.string = str_selected;
                 [menuItem1 selected];
                 [radioMenu setSelectedItem_:menuItem1];
                 [self blinkEffect:menuItem1 stopAction:YES];
                 break;
             case 2:
                 lblGo.string = str_selected;
                 [menuItem2 selected];
                 [radioMenu setSelectedItem_:menuItem2];
                 [self blinkEffect:menuItem2 stopAction:YES];
                 break;
             case 3:
                 lblGo.string = str_selected;
                 [menuItem3 selected];
                 [radioMenu setSelectedItem_:menuItem3];
                 [self blinkEffect:menuItem3 stopAction:YES];
                 break;
             case 4:
                 lblGo.string = str_selected;
                 [menuItem4 selected];
                 [radioMenu setSelectedItem_:menuItem4];
                 [self blinkEffect:menuItem4 stopAction:YES];
                 break;
             case 5:
                 lblGo.string = str_selected;
                 [menuItem5 selected];
                 [radioMenu setSelectedItem_:menuItem5];
                 [self blinkEffect:menuItem5 stopAction:YES];
                 break;
             case 6:
                 lblGo.string = str_selected;
                 [menuItem6 selected];
                 [radioMenu setSelectedItem_:menuItem6];
                 [self blinkEffect:menuItem6 stopAction:YES];
                 break;
             default:
                 break;
         }
        
    
    [self addChild:radioMenu];
    //[self addChild:radioMenu2];
    
     CCLabelTTF *backLabel = [CCLabelTTF labelWithString:NSLocalizedString(@"Back", nil) fontName:@"Marker Felt" fontSize:18];
    CCMenuItemSprite *menuButton = [CCMenuItemSprite itemWithNormalSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"button2.png"]]
                                                           selectedSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"button2_selected.png"]]
                                                                    block:^(id sender) {
                                                                         [SoundManager.instance playSoundEffect:@"btnClick1"];
                                                                        [[GameManager instance] runSceneWithID:kMainMenuScene];
                                                                    }];
    
    
    
    
    backLabel.position = ccp(menuButton.boundingBox.size.width/2,menuButton.boundingBox.size.height/2);
    
    [menuButton addChild:backLabel];
    
    
    CCMenu *subMenu = [CCMenu menuWithItems:menuButton,nil];
    [subMenu alignItemsVertically];
    [subMenu setPosition: ccp(screenSize.width * 0.86f, screenSize.height *0.2)];
    NSLog(@"screenSize.height == %f",screenSize.height);
    if (screenSize.height == 480.0f ) {
        [subMenu setPosition: ccp(screenSize.width * 0.85f, 50.0f+17.5f)];
    }
   
    [self blinkEffect:subMenu stopAction:NO];
    [self addChild:subMenu];
    //
    //    CCMenuItemSprite *buyBookButton = [CCMenuItemSprite itemWithNormalSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"button1.png"]]
    //                                                              selectedSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"button1_selected.png"]]
    //                                                                       block:^(id sender) {
    //                                                                           [self buyBook];
    //                                                                       }];
    //
    //    CCMenuItemSprite *optionsButton = [CCMenuItemSprite itemWithNormalSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"button1.png"]]
    //                                                              selectedSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"button1_selected.png"]]
    //                                                                       block:^(id sender) {
    //                                                                           [self showOptions];
    //                                                                       }];
    //    CCMenuItemToggle *musicToggle = [CCMenuItemToggle itemWithTarget:self
    //                                                            selector:@selector(musicTogglePressed)
    //                                                               items:musicOnLabel,musicOffLabel,nil];
    //
    //    CCMenuItemToggle *SFXToggle = [CCMenuItemToggle itemWithTarget:self
    //                                                          selector:@selector(SFXTogglePressed)
    //                                                             items:SFXOnLabel,SFXOffLabel,nil];
    //
    
    //
    //
    //    mainMenu = [CCMenu
    //                menuWithItems:playGameButton,buyBookButton,optionsButton,nil];
    //    [mainMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
    //    [mainMenu setPosition:
    //     ccp(screenSize.width * 2.0f,
    //         screenSize.height / 3.0f)];
    //    id moveAction =
    //    [CCMoveTo actionWithDuration:0.9f
    //                        position:ccp(screenSize.width * 0.5f,
    //                                     screenSize.height/3.0f)];
    //    id moveEffect = [CCEaseBounceOut actionWithAction:moveAction];
    //    [mainMenu runAction:moveEffect];
    //    [self addChild:mainMenu z:0 tag:kMainMenuTagValue];
}



@end
