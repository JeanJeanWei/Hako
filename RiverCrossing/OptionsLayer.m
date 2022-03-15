//
//  OptionsLayer.m
//  SpaceViking
//

#import "OptionsLayer.h"
#import "UserPreferenceController.h"

@implementation OptionsLayer

-(void)returnToMainMenu
{
	[[GameManager instance] runSceneWithID:kMainMenuScene];
    [UserPreferenceController.instance saveDataToDisk];
}
     
-(void)showCredits {
	[[GameManager instance] runSceneWithID:kCreditsScene];
}

-(void)musicTogglePressed {
	if (SoundManager.instance.isMusicON) {
		CCLOG(@"OptionsLayer-> Turning Game Music OFF");
		SoundManager.instance.isMusicON = NO;
        [SoundManager.instance stopMusic];
	} else {
		CCLOG(@"OptionsLayer-> Turning Game Music ON");
		SoundManager.instance.isMusicON = YES;
        [SoundManager.instance playBackgroundTrack:BACKGROUND_TRACK_MAIN_MENU];
	}
    [UserPreferenceController.instance setMusic:SoundManager.instance.isMusicON];
}

-(void)SFXTogglePressed {
	if (SoundManager.instance.isSoundEffectsON) {
		CCLOG(@"OptionsLayer-> Turning Sound Effects OFF");
		SoundManager.instance.isSoundEffectsON = NO;
	} else {
		CCLOG(@"OptionsLayer-> Turning Sound Effects ON");
		SoundManager.instance.isSoundEffectsON = YES;
        [SoundManager.instance playSoundEffect:@"btnClick1"];
        
	}
     [UserPreferenceController.instance setSoundEffect:SoundManager.instance.isSoundEffectsON];
}

-(id)init {
	self = [super init];
	if (self != nil)
    {
		CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btn_sprite.plist"];
        CCSpriteBatchNode *buttonSprites = [CCSpriteBatchNode batchNodeWithFile:@"btn_sprite.png"];
        [self addChild:buttonSprites];
         NSString *musicOn = [[NSString alloc] initWithFormat:@"%@ ON",NSLocalizedString(@"Music", nil) ];
         NSString *musicOff = [[NSString alloc] initWithFormat:@"%@ OFF",NSLocalizedString(@"Music", nil) ];
        CCLabelTTF *musicOnLabelText = [CCLabelTTF labelWithString:musicOn fontName:@"Marker Felt" fontSize:28];
        CCLabelTTF *musicOffLabelText = [CCLabelTTF labelWithString:musicOff fontName:@"Marker Felt" fontSize:28];
        
        NSString *seOn = [[NSString alloc] initWithFormat:@"%@ ON",NSLocalizedString(@"SoundEffect", nil) ];
        NSString *seOff = [[NSString alloc] initWithFormat:@"%@ OFF",NSLocalizedString(@"SoundEffect", nil) ];
        CCLabelTTF *SFXOnLabelText = [CCLabelTTF labelWithString:seOn fontName:@"Marker Felt" fontSize:28];
        CCLabelTTF *SFXOffLabelText = [CCLabelTTF labelWithString:seOff fontName:@"Marker Felt" fontSize:28];
		
		CCMenuItemLabel *musicOnLabel = [CCMenuItemLabel itemWithLabel:musicOnLabelText target:self selector:nil];
		CCMenuItemLabel *musicOffLabel = [CCMenuItemLabel itemWithLabel:musicOffLabelText target:self selector:nil];
		CCMenuItemLabel *SFXOnLabel = [CCMenuItemLabel itemWithLabel:SFXOnLabelText target:self selector:nil];
		CCMenuItemLabel *SFXOffLabel = [CCMenuItemLabel itemWithLabel:SFXOffLabelText target:self selector:nil];

										 
		CCMenuItemToggle *musicToggle = [CCMenuItemToggle itemWithTarget:self 
																selector:@selector(musicTogglePressed) 
																   items:musicOnLabel,musicOffLabel,nil];
		
		CCMenuItemToggle *SFXToggle = [CCMenuItemToggle itemWithTarget:self 
																selector:@selector(SFXTogglePressed) 
																   items:SFXOnLabel,SFXOffLabel,nil];
				
		CCLabelTTF *creditsButtonLabel = [CCLabelTTF labelWithString:NSLocalizedString(@"Credits", nil) fontName:@"Marker Felt" fontSize:28];
		CCMenuItemLabel	*creditsButton = [CCMenuItemLabel itemWithLabel:creditsButtonLabel target:self selector:@selector(showCredits)];
		
        CCLabelTTF *moreApps = [CCLabelTTF labelWithString:NSLocalizedString(@"MoreApps", nil) fontName:@"Marker Felt" fontSize:28];
		CCMenuItemLabel *moreAppsLabel = [CCMenuItemLabel itemWithLabel:moreApps block:^(id sender) {
            [self goToWebSite:kLinkMoreApps];
        }];
        
        
        CCMenuItemSprite *backButton = [CCMenuItemSprite itemWithNormalSprite:[self creatSprite:NSLocalizedString(@"Back", nil) selected:NO]
                                                               selectedSprite:[self creatSprite:NSLocalizedString(@"Back", nil) selected:YES]
                                                                        block:^(id sender) {
                                                                             [SoundManager.instance playSoundEffect:@"btnClick1"];
                                                                            [self returnToMainMenu];
                                                                        }];
        

			
		CCMenu *optionsMenu = [CCMenu menuWithItems:musicToggle,SFXToggle,
                               moreAppsLabel,
							   creditsButton,
							   backButton,nil];
		[optionsMenu alignItemsVerticallyWithPadding:30.0f];
		[optionsMenu setPosition:ccp(screenSize.width * 0.5f, screenSize.height/2)];
		[self addChild:optionsMenu];
        
        if (!SoundManager.instance.isMusicON) {
            [musicToggle setSelectedIndex:1]; // Music is OFF
        }
        
        if (!SoundManager.instance.isSoundEffectsON) {
            [SFXToggle setSelectedIndex:1]; // SFX are OFF
        }
	}
	return self;
}

-(void)goToWebSite:(LinkTypes)l
{
	CCLOG(@"Going to WebSite");
	[[GameManager instance] openSiteWithLinkType:l];
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
    
    lblFont.position = ccp(sp.boundingBox.size.width*0.5,sp.boundingBox.size.height*0.55);
    [sp addChild:lblFont];
    return sp;
}

@end
