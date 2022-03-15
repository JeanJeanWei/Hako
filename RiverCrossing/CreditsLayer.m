//
//  CreditsLayer.m
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-27.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//


#import "CreditsLayer.h"
#import "VisualEffect.h"

@implementation CreditsLayer

-(void)returnToOptionMenu {
	[[GameManager instance] runSceneWithID:kOptionsScene];
}

-(void)goToWebSite:(LinkTypes)l
{
	CCLOG(@"Going to WebSite");
	[[GameManager instance] openSiteWithLinkType:l];
}


-(id)init {
	self = [super init];
	if (self != nil) {
		CGSize screenSize = [CCDirector sharedDirector].winSize; 
        ccColor3B color = ccc3(255, 255, 255);
        
        CCSprite *cocos2d = [CCSprite spriteWithFile:@"cocos2d.png"];
        cocos2d.position = ccp(screenSize.width*0.85, screenSize.height*0.2);
        [self addChild:cocos2d];

		
		CCLabelTTF *producer = [CCLabelTTF labelWithString:@"Producer: Ice Whale" fontName:@"Marker Felt" fontSize:18];
        producer.color = color;
		CCMenuItemLabel *producerLabel = [CCMenuItemLabel itemWithLabel:producer block:^(id sender) {
            [self goToWebSite:kLinkBlogSite];
        }];

		CCLabelTTF *jj= [CCLabelTTF labelWithString:@"Lead Developer: Jean-Jean Wei"  fontName:@"Marker Felt" fontSize:18];
        jj.color = color;
		CCMenuItemLabel *jjLabel = [CCMenuItemLabel itemWithLabel:jj block:^(id sender) {
            [self goToWebSite:kLinkFacebookSite];
        }];


		CCLabelTTF *sp = [CCLabelTTF labelWithString:@"Art and Game Design: Shih-Ping Wei" fontName:@"Marker Felt" fontSize:18];
        sp.color = color;
		CCMenuItemLabel *spLabel = [CCMenuItemLabel itemWithLabel:sp block:^(id sender) {
            [self goToWebSite:kLinkBlogSite];
        }];

        CCLabelTTF *cocos = [CCLabelTTF labelWithString:@"Special Thanks: COCOS2D" fontName:@"Marker Felt" fontSize:18];
        cocos.color = color;
		CCMenuItemLabel *cocosLabel = [CCMenuItemLabel itemWithLabel:cocos block:^(id sender) {
            [self goToWebSite:kLinkCocos2d];
        }];
        CCLabelTTF *packer = [CCLabelTTF labelWithString:@"Special Thanks: TexturePacker" fontName:@"Marker Felt" fontSize:18];
        packer.color = color;
		CCMenuItemLabel *packerLabel = [CCMenuItemLabel itemWithLabel:packer block:^(id sender) {
            [self goToWebSite:kLinkTexturePacker];
        }];

        CCLabelTTF *lux = [CCLabelTTF labelWithString:@"Special Thanks: Luxuria" fontName:@"Marker Felt" fontSize:18];
        lux.color = color;
		
        CCLabelTTF *ren = [CCLabelTTF labelWithString:@"Special Thanks: Bastet tail (Music)" fontName:@"Marker Felt" fontSize:18];
        ren.color = color;
		CCMenuItemLabel *renLabel = [CCMenuItemLabel itemWithLabel:ren block:^(id sender) {
            [self goToWebSite:kLinkBastet];
        }];
        NSString *str = NSLocalizedString(@"Back", nil);
        CCMenuItemSprite *backButton = [CCMenuItemSprite itemWithNormalSprite:[self creatSprite:str selected:NO]
                                                               selectedSprite:[self creatSprite:str selected:YES]
                                                                        block:^(id sender) {
                                                                             [SoundManager.instance playSoundEffect:@"btnClick1"];
                                                                             [self returnToOptionMenu];
                                                                        }];
        
		
		CCMenu *optionsMenu = [CCMenu menuWithItems:
							   producerLabel,
                               jjLabel,
							   spLabel,
                               cocosLabel,
                               packerLabel,
 //                              luxLabel,
                               renLabel,
//							   musicianLabel,
							   backButton,nil];
		
		[optionsMenu alignItemsVerticallyWithPadding:screenSize.height * 0.04f];
		[optionsMenu setPosition:ccp(screenSize.width /2, screenSize.height * 0.5f)];
        
		[self addChild:optionsMenu];
		
		
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
@end
