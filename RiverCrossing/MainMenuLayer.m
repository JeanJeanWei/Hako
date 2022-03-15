//  MainMenuLayer.m
//  SpaceViking
//
#import "MainMenuLayer.h"
#import "ABGameKitHelper.h"

#import "VisualEffect.h"


@interface MainMenuLayer() 
-(void)displayMainMenu;
-(void)displaySceneSelection;
@end

@implementation MainMenuLayer

-(id)init {
    self = [super init];
    if (self != nil) {


        [self displayMainMenu];
        [SoundManager.instance playBackgroundTrack:BACKGROUND_TRACK_MAIN_MENU];
        double delayInSeconds = 0.8;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [SoundManager.instance playSoundEffect:@"jump1"];
        });
        

//
//        id rotateAction = [CCEaseElasticInOut actionWithAction:
//                           [CCRotateBy actionWithDuration:5.5f
//                                                    angle:360]];
//        
//        id scaleUp = [CCScaleTo actionWithDuration:2.0f scale:1.5f];
//        id scaleDown = [CCScaleTo actionWithDuration:2.0f scale:0.5f];
//        
//        [viking runAction:[CCRepeatForever actionWithAction:
//                           [CCSequence
//                            actions:scaleUp,scaleDown,nil]]];
//        
//        [viking runAction:
//         [CCRepeatForever actionWithAction:rotateAction]];
        
        
    }
    return self;
}

-(void)showProfile
{
    [[GameManager instance] runSceneWithID:kProfileScene];
}

-(void)showOptions {
    CCLOG(@"Show the Options screen");
    [[GameManager instance] runSceneWithID:kOptionsScene];
}


//- (CCSprite*)creatSprite:(int)type selected:(BOOL)isSelected
//{
//    NSString *spriteName;
//    //CCLabelTTF *lblFont = [CCLabelTTF labelWithString:str fontName:@"Marker Felt" fontSize:24];
//    if (type) {
//        <#statements#>
//    }
//    if (isSelected) {
//        spriteName  = @"button1_selected.png";
//        lblFont.color = ccc3(0, 0, 0);
//    } else {
//        spriteName  = @"button1.png";
//    }
//    CCSprite *sp = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:spriteName]];
//    
//    
//    //lblFont.color = ccc3(0, 0, 255);
//    lblFont.position = ccp(sp.boundingBox.size.width*0.5,sp.boundingBox.size.height*0.5);
//    [sp addChild:lblFont];
//    return sp;
//}

-(void)displayMainMenu
{
    
    CGSize screenSize = [CCDirector sharedDirector].winSize; 

    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"title.plist"];
    CCSpriteBatchNode *opSprites = [CCSpriteBatchNode batchNodeWithFile:@"title.png"];
    [self addChild:opSprites];
    
    CCSprite *sp = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"title1_.png"]];
    [sp setPosition:ccp(screenSize.width * 0.5f, screenSize.height * 0.8)];
    [VisualEffect pluseEffect:sp];
    [self addChild:sp];
    
    // Main Menu
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"main_menu.plist"];
    CCSpriteBatchNode *buttonSprites = [CCSpriteBatchNode batchNodeWithFile:@"main_menu.png"];
    [self addChild:buttonSprites];


    CCMenuItemSprite *playGameButton = [CCMenuItemSprite itemWithNormalSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"start_1.png"]]
                                                               selectedSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"start_0.png"]]
                                                                        block:^(id sender) {
                                                                            [SoundManager.instance playSoundEffect:@"btnClick1"];
                                                                            [self displaySceneSelection];
                                                                        }];

    CCMenuItemSprite *profileButton = [CCMenuItemSprite itemWithNormalSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"community_1.png"]]
                                                              selectedSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"community_0.png"]]
                                                               block:^(id sender) {
                                                                   
                                                                   [SoundManager.instance playSoundEffect:@"btnClick1"];
                                                                   [self showProfile];
                                                               }];
    
    CCMenuItemSprite *optionsButton = [CCMenuItemSprite itemWithNormalSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"options_1.png"]]
                                                              selectedSprite:[[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"options_0.png"]]
                                                              block:^(id sender) {
                                                                  //
                                                                  [SoundManager.instance playSoundEffect:@"btnClick1"];
                                                                  [self showOptions];
                                                              }];


    mainMenu = [CCMenu
                menuWithItems:playGameButton,profileButton,optionsButton,nil];
    [mainMenu alignItemsVerticallyWithPadding:screenSize.height * 0.04f];
    [VisualEffect pluseEffect:mainMenu];
    mainMenu.position = ccp(screenSize.width * 2.0f,screenSize.height / 3.0f);
    id moveAction = [CCMoveTo actionWithDuration:0.9f position:ccp(screenSize.width * 0.55f, screenSize.height*0.4)];
    id moveEffect = [CCEaseBounceOut actionWithAction:moveAction];
    [mainMenu runAction:moveEffect];
    [self addChild:mainMenu z:0 tag:kMainMenuTagValue];
    

}

-(void)displaySceneSelection {
    [[GameManager instance] runSceneWithID:kAvatorListScene];
//    [[GameManager instance] runSceneWithID:kLevelListScene];
//    CGSize screenSize = [CCDirector sharedDirector].winSize; 
//    if (mainMenu != nil) {
//        [mainMenu removeFromParentAndCleanup:YES];
//    }
//    
//    CCLabelBMFont *playScene1Label = 
//    [CCLabelBMFont labelWithString:@"Oli Awakes!" 
//                           fntFile:@"VikingSpeechFont64.fnt"];
//    CCMenuItemLabel *playScene1 = 
//    [CCMenuItemLabel itemWithLabel:playScene1Label target:self 
//                          selector:@selector(playScene:)];
//    [playScene1 setTag:1];
//    
//    CCLabelBMFont *playScene2Label = 
//    [CCLabelBMFont labelWithString:@"Dogs of Loki!" 
//                           fntFile:@"VikingSpeechFont64.fnt"];
//    CCMenuItemLabel *playScene2 = 
//    [CCMenuItemLabel itemWithLabel:playScene2Label target:self 
//                          selector:@selector(playScene:)];
//    [playScene2 setTag:2];
//
//    CCLabelBMFont *playScene3Label = 
//    [CCLabelBMFont labelWithString:@"Mad Dreams of the Dead!" 
//                           fntFile:@"VikingSpeechFont64.fnt"];
//    CCMenuItemLabel *playScene3 = [CCMenuItemLabel itemWithLabel:playScene3Label target:self 
//                                                        selector:@selector(playScene:)];
//    [playScene3 setTag:3];
//    
//    CCLabelBMFont *playScene4Label = 
//    [CCLabelBMFont labelWithString:@"Descent Into Hades!" 
//                                     fntFile:@"VikingSpeechFont64.fnt"];
//	CCMenuItemLabel *playScene4 = [CCMenuItemLabel itemWithLabel:playScene4Label target:self 
//														selector:@selector(playScene:)];
//	[playScene4 setTag:4];
//    
//    CCLabelBMFont *playScene5Label = 
//    [CCLabelBMFont labelWithString:@"Escape!" 
//                                     fntFile:@"VikingSpeechFont64.fnt"];
//	CCMenuItemLabel *playScene5 = [CCMenuItemLabel itemWithLabel:playScene5Label target:self 
//														selector:@selector(playScene:)];
//	[playScene5 setTag:5];
    
//    CCLabelBMFont *backButtonLabel = 
//    [CCLabelBMFont labelWithString:@"Back" 
//                           fntFile:@"VikingSpeechFont64.fnt"];
//    CCMenuItemLabel *backButton = 
//    [CCMenuItemLabel itemWithLabel:backButtonLabel target:self 
//                          selector:@selector(displayMainMenu)];
//    
//    //sceneSelectMenu = [CCMenu menuWithItems:playScene1,playScene2,playScene3,playScene4,playScene5,backButton,nil];
//    sceneSelectMenu = [CCMenu menuWithItems:playScene1,playScene2,backButton,nil];
//    [sceneSelectMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
//    [sceneSelectMenu setPosition:ccp(screenSize.width * 2, 
//                                     screenSize.height / 2)];
//    
//    id moveAction = [CCMoveTo actionWithDuration:0.5f 
//                                        position:ccp(screenSize.width * 0.75f, 
//                                                     screenSize.height/2)];
//    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
//    [sceneSelectMenu runAction:moveEffect];
//    [self addChild:sceneSelectMenu z:1 tag:kSceneMenuTagValue];
}

@end
