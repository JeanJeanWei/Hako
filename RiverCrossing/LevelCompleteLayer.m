//
//  LevelCompleteLayer.m
//  SpaceViking
//
//  Created by Rod on 10/7/10.
//  Copyright 2010 Prop Group LLC - www.prop-group.com. All rights reserved.
//

#import "LevelCompleteLayer.h"
#import "ABGameKitHelper.h"
#import "UserPreferenceController.h"
#import "VisualEffect.h"

@implementation LevelCompleteLayer

//- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //CCLOG(@"ccTouchBegan");
    
    UITouch* touch = [touches anyObject];
    
    if ([self FBcontainsTouch:touch])
    {
       NSLog(@"FB Touches received");

    }
    else
    {
        CCLOG(@"Touches received, returning to the  ListMenu");
        [[GameManager instance] runSceneWithID:kLevelListScene];
    }
	
	
	
}
#pragma mark -

-(BOOL)FBcontainsTouch:(UITouch *)touch
{
    CGRect box= fbButton.boundingBox;
    CGPoint touchLocation = [self convertTouchToNodeSpaceAR:touch];
    touchLocation = [self convertToWorldSpaceAR:touchLocation];
    return CGRectContainsPoint(box, touchLocation);
}
- (void)reportToGameCenter
{
    int stage = GameManager.instance.stage;
    NSString *leaderboardID = [[NSString alloc] initWithFormat:@"bot_stage_%d",stage];
//    NSString *leaderboard2 = @"hako_lite_2";
//    NSString *leaderboard3 = @"hako_lite_3";
    int l = GameManager.instance.currentLevel;
//    [[ABGameKitHelper sharedClass] reportScore:[UserPreferenceController.instance addCurrentLBScore:a score:(l+1)*2] forLeaderboard:str];
    int stageScore = [UserPreferenceController.instance addCurrentLBScore:stage score:(l+1)*2 ];
     [[ABGameKitHelper sharedClass] reportScore:stageScore forLeaderboard:leaderboardID];
//    [[ABGameKitHelper sharedClass] reportScore:[UserPreferenceController.instance addCurrentLBScore:2 score:1] forLeaderboard:leaderboard3];
    //[[ABGameKitHelper sharedClass] retrieveLocalScoreForCategory:@"eqeq"];
    NSString *achieve = [[NSString alloc] initWithFormat:@"BOT_achievement_stage_%d",GameManager.instance.stage];
    int percentage = [UserPreferenceController.instance getLevelAchievementPercentage];
    //[[ABGameKitHelper sharedClass] reportAchievement:achieve  percentComplete:100];
    [[ABGameKitHelper sharedClass] reportAchievement:achieve  percentComplete:percentage];
    NSLog(@">>>>> percentafe = %d",percentage);
}

-(id)init
{
	self = [super init];
	if (self != nil)
    {
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [SoundManager.instance playSoundEffect:@"levelClear"];
            [self reportToGameCenter];
        });
        
        CGSize screenSize = [CCDirector sharedDirector].winSize;
		// Accept touch input
		self.isTouchEnabled = YES;
        
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"lv_clear.plist"];
        CCSpriteBatchNode *buttonSprites = [CCSpriteBatchNode batchNodeWithFile:@"lv_clear.png"];
        [self addChild:buttonSprites];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"profile.plist"];
        CCSpriteBatchNode *avatorSprites = [CCSpriteBatchNode batchNodeWithFile:@"profile.png"];
        [self addChild:avatorSprites];
        
        NSString *str = @"lvClear.png";
        CCSprite *avatorBG = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:str]];
        avatorBG.opacity = 0;
        avatorBG.position = ccp(screenSize.width*0.5f,screenSize.height*0.5f);
        [VisualEffect fadeOutEffect:avatorBG duration:1.0];
        [self addChild:avatorBG];
        
        CCSprite *lvClear = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"congras.png"]];
        lvClear.position = ccp(screenSize.width*0.5f,screenSize.height+lvClear.boundingBox.size.height/2);
        [VisualEffect pluseEffect:lvClear];
        CGPoint p;
        if (GameManager.instance.stage == 1) {
            p = ccp(screenSize.width*0.5f,screenSize.height*0.45);
        } else {
            p = ccp(screenSize.width*0.5f,screenSize.height*0.25);
        }
        [VisualEffect bouncingMove:lvClear duration:0.7 posistion:p];
        [self addChild:lvClear];
        
        
        /*
        fbButton = [CCMenuItemSprite itemWithNormalSprite:[self creatSprite:@"Share" selected:NO]
                                           selectedSprite:[self creatSprite:@"Share" selected:YES]
                                                    block:^(id sender) {
                                                        
                                                        [SoundManager.instance playSoundEffect:@"btnClick1"];
                                                        [GameManager.instance  postToFB:0 record:NO];
                                                    }];
        CCMenu *menu = [CCMenu menuWithItems:fbButton,nil];
		//[menu alignItemsVerticallyWithPadding:60.0f];
		[menu setPosition:ccp(screenSize.width * 0.1f, screenSize.height*0.9)];
		[self addChild:menu];
         */
        //        CCLabelTTF *lblFont = [CCLabelTTF labelWithString:str fontName:@"Marker Felt" fontSize:24];
        //        fbLabel.position = ccp(screenSize.width * 0.3f, screenSize.height*0.8f);
        //                CCMenuItemLabel *fbState = [CCMenuItemLabel itemWithLabel:fbLabelText block:^(id sender) {
        //
        //                }];
        //
        //
        //		// If Viking is dead, reset him and show the tombstone,
        //		// Any touch gets you back to the main menu
        //		BOOL didPlayerDie = [[GameManager instance] hasPlayerDied];
        //		CCSprite *background = nil;
        //		if (didPlayerDie) {
        //			background = [CCSprite spriteWithFile:@"LevelCompleteDead.png"];
        //		} else {
        //			background = [CCSprite spriteWithFile:@"LevelCompleteAlive.png"];
        //		}
        //
        //		[background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        //		[self addChild:background];
        //
        //
        //		// Add the text for level complete.
        //		CCLabelBMFont *levelLabelText = [CCLabelBMFont labelWithString:@"Level Complete" fntFile:@"VikingSpeechFont64.fnt"];
        //		[levelLabelText setPosition:ccp(screenSize.width/2, screenSize.height * 0.9f)];
        //		[self addChild:levelLabelText];
		
		
		
		
		
	}
	return self;
}

- (CCSprite*)creatSprite:(NSString*)str selected:(BOOL)isSelected
{
    CCSprite *sp = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"fb.png"]];
    CCLabelTTF *lblFont = [CCLabelTTF labelWithString:str fontName:@"Marker Felt" fontSize:12];
    
    if (isSelected) {
        sp.scale = 1.2;
        lblFont.scale = 1.2;
        
    } else {
//        sp.scale = 1.9;
//        lblFont.scale = 1.9;
    }
    
    
    lblFont.color = ccc3(0, 0, 0);
    lblFont.position = ccp(sp.boundingBox.size.width*0.46,sp.boundingBox.size.height*1.1);
 
    
    [sp addChild:lblFont];
    return sp;
}
@end
