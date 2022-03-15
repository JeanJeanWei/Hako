//
//  ProfileLayer.m
//  puzzle
//
//  Created by Jean-Jean Wei on 13-03-04.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "ProfileLayer.h"
//#import "FBUtility.h"
#import "ABGameKitHelper.h"

#define str_on @"Online"
#define str_off @"Offline"

#define str_login NSLocalizedString(@"Login", nil)
#define str_logout NSLocalizedString(@"Logout", nil)

@implementation ProfileLayer

-(void)returnToMainMenu
{
	[[GameManager instance] runSceneWithID:kMainMenuScene];
}

-(id)init
{
	self = [super init];
	if (self != nil)
    {
//        [[NSNotificationCenter defaultCenter]
//         addObserver:self
//         selector:@selector(checkFBLogin)
//         name:@"requestFB_success"
//         object:nil ];
//        [[NSNotificationCenter defaultCenter]
//         addObserver:self
//         selector:@selector(checkFBLogin)
//         name:@"logoutFB_success"
//         object:nil ];
		screenSize = [CCDirector sharedDirector].winSize;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btn_sprite.plist"];
        CCSpriteBatchNode *buttonSprites = [CCSpriteBatchNode batchNodeWithFile:@"btn_sprite.png"];
        [self addChild:buttonSprites];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"profile.plist"];
        CCSpriteBatchNode *avatorSprites = [CCSpriteBatchNode batchNodeWithFile:@"profile.png"];
        [self addChild:avatorSprites];
        
        
        
        //[self createFbIcon];
        [self createGamecenterIcon];
        
        
      
        CCMenuItemSprite *backButton = [CCMenuItemSprite itemWithNormalSprite:[self creatSprite:NSLocalizedString(@"Back", nil) selected:NO]
                                                               selectedSprite:[self creatSprite:NSLocalizedString(@"Back", nil) selected:YES]
                                                                        block:^(id sender) {
                                                                             [SoundManager.instance playSoundEffect:@"btnClick1"];
                                                                            [[GameManager instance] runSceneWithID:kMainMenuScene];
                                                                        }];
        
//        CCMenuItemSprite *aButton = [CCMenuItemSprite itemWithNormalSprite:[self creatSprite:@"Back" selected:NO]
//                                                               selectedSprite:[self creatSprite:@"Back" selected:YES]
//                                                                        block:^(id sender) {
//                                                                            [[ABGameKitHelper sharedClass] resetAchievements];
//                                                                        }];
        
                
        
        
        CCMenu *profileMenu = [CCMenu menuWithItems:
                               backButton,
                               //aButton,
                               nil];
        [profileMenu alignItemsVerticallyWithPadding:60.0f];
		[profileMenu setPosition:ccp(screenSize.width * 0.5f, screenSize.height*0.3)];
		[self addChild:profileMenu];
		

	}
    
	return self;
}
- (CCSprite*)creatSprite:(NSString*)str selected:(BOOL)isSelected
{
    NSString *spriteName;
    CCLabelTTF *lblFont = [CCLabelTTF labelWithString:str fontName:@"Marker Felt" fontSize:18];
    
    if (isSelected) {
        spriteName  = @"button2_selected.png";
        lblFont.color = ccc3(0, 0, 0);
    } else {
        spriteName  = @"button2.png";
    }
    CCSprite *sp = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:spriteName]];
    
    lblFont.position = ccp(sp.boundingBox.size.width*0.5,sp.boundingBox.size.height*0.5);
    [sp addChild:lblFont];
    return sp;
}
- (CCSprite*)createSp:(BOOL)isSelected
{
    NSString *spriteName;
    
    if (isSelected) {
        spriteName  = @"button2_selected.png";
    } else {
        spriteName  = @"button2.png";
    }
    CCSprite *sp = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:spriteName]];
    

    
    return sp;
}
//- (void)checkFBLogin
//{
//    if (FBUtility.instance.isLogin) {
//        fbLabel.string = str_on;
//        fbLabel.color = ccc3(50,205,50);
//
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        fbName.string = [defaults objectForKey:@"fb_name"];
//        fbLogBtn.string = str_logout;
//
//
//    } else {
//        fbLabel.string = str_off;
//        fbLabel.color = ccc3(255,0,0);
//        fbName.string = @"";
//        fbLogBtn.string = str_login;
//
//    }
//}

//- (void)createFbIcon
//{
//    fbLabel = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:16];
//    fbName = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:16];
//    fbLogBtn = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:18];
//    [self checkFBLogin];
//
//
//    CCSprite *sp = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"fb.png"]];
//    sp.position = ccp(100, screenSize.height-150);
//    [self blinkEffect:sp];
//    [self addChild:sp];
//
//
//
//    //lblFont.color = ccc3(0, 0, 255);
//    //CGPoint p = fbLabelText.anchorPoint;
//    fbLabel.anchorPoint = ccp(0,0);
//    fbLabel.position = ccp(80,screenSize.height-120);
//    [self addChild:fbLabel];
//    fbName.anchorPoint = ccp(0,0);
//    fbName.position = ccp(180,screenSize.height-120);
//    [self addChild:fbName];
//
//
//    CCMenuItemSprite *btnFB= [CCMenuItemSprite itemWithNormalSprite:[self createSp:NO]
//                                                     selectedSprite:[self createSp:YES]
//                                                              block:^(id sender) {
//                                                                  [SoundManager.instance playSoundEffect:@"btnClick1"];
//                                                                  if (FBUtility.instance.isLogin) {
//
//                                                                      [FBUtility.instance logoutFacebook];
//
//                                                                  } else {
//
//                                                                      [FBUtility.instance loginToFacebook];
//
//                                                                  }
//                                                              }];
//    fbLogBtn.position = ccp(btnFB.boundingBox.size.width*0.5,btnFB.boundingBox.size.height*0.5);
//    [btnFB addChild:fbLogBtn];
//    CCMenu *fbMenu = [CCMenu menuWithItems:
//                      btnFB, nil];
//
//    fbMenu.position = ccp(210,screenSize.height-150);
//    [self blinkEffect:fbMenu];
//    [self addChild:fbMenu];
//}

- (void)checkGameCenterLogin 
{
    if ([ABGameKitHelper.sharedClass isAuth]) {
        gameCenterLabel.string = str_on;
        gameCenterLabel.color = ccc3(50,205,50);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        gameCenterName.string = [defaults objectForKey:@"gameCenter_name"];
    } else {
        gameCenterLabel.string = str_off;
        gameCenterLabel.color = ccc3(255,0,0);
        gameCenterName.string = @"";

    }
}
- (void)createGamecenterIcon
{
    
    gameCenterLabel = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:16];
    gameCenterName = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:16];
    [self checkGameCenterLogin];
    
    
    CCSprite *sp = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"gameCenter.png"]];
    sp.position = ccp(100, screenSize.height-250);
    [self blinkEffect:sp];
    [self addChild:sp];
    
    
    
    //lblFont.color = ccc3(0, 0, 255);
    //CGPoint p = fbLabelText.anchorPoint;
    gameCenterLabel.anchorPoint = ccp(0,0);
    gameCenterLabel.position = ccp(80,screenSize.height-220);
    [self addChild:gameCenterLabel];
    gameCenterName.anchorPoint = ccp(0,0);
    gameCenterName.position = ccp(180,screenSize.height-220);
    [self addChild:gameCenterName];
    
    NSString *str = NSLocalizedString(@"Leaderboard", nil);
    
    CCMenuItemSprite *btn1= [CCMenuItemSprite itemWithNormalSprite:[self creatSprite:str selected:NO]
                                                     selectedSprite:[self creatSprite:str selected:YES]
                                                              block:^(id sender) {
                                                                  [SoundManager.instance playSoundEffect:@"btnClick1"];
                                                                  [self showLeaderBoards];
                                                              }];
    CCMenu *menu = [CCMenu menuWithItems:
                      btn1, nil];
    [menu alignItemsHorizontally];
    menu.position = ccp(210,screenSize.height-250);
    [self blinkEffect:menu];
    [self addChild:menu];
    
}
- (void)blinkEffect:(CCNode*)node
{
    CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:0.5 opacity:127];
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:0.5 opacity:255];
    CCSequence *pulseSequence = [CCSequence actionOne:fadeIn two:fadeOut];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:pulseSequence];
    [node runAction:repeat];
}
-(void)showLeaderBoards {

    int a = GameManager.instance.stage;
    a = 2;
    NSString *str = [[NSString alloc] initWithFormat:@"hako_lite_%d",a];

    [[ABGameKitHelper sharedClass] showLeaderboard:str];
}
-(void)showAchievements {

    [[ABGameKitHelper sharedClass] showAchievements];
}
- (void) dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
