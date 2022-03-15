//
//  IntroLayer.m
//  SpaceViking
//
#import "IntroLayer.h"

@implementation IntroLayer
-(void)startGamePlay {
	CCLOG(@"Intro complete, asking Game Manager to start the Game play");
	[[GameManager instance] runSceneWithID:kMainMenuScene];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	CCLOG(@"Touches received, skipping intro");
	[self startGamePlay];
}


-(id)init {
	self = [super init];
	if (self != nil) {
		// Accept touch input
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [SoundManager.instance playSoundEffect:@"chainSound"];
        });
		self.isTouchEnabled = YES;
        [SoundManager.instance playBackgroundTrack:BACKGROUND_TRACK_MAIN_MENU];
		// Create the intro image
		CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        CCSprite *introImage = [CCSprite spriteWithFile:@"op2.jpg"];
        float offY = (introImage.boundingBox.size.height - screenSize.height)/2;
        
		[introImage setPosition:ccp(screenSize.width/2, screenSize.height/2+offY)];
        if (screenSize.height == 480.0f ) {
            CGPoint p = introImage.position;
            introImage.position = ccp(p.x, p.y-88);
        }
		[self addChild:introImage];
        
        CCSprite *introImage1 = [CCSprite spriteWithFile:@"door_1.png"];
        float offX = introImage1.boundingBox.size.width/2;
		[introImage1 setPosition:ccp(screenSize.width-offX, screenSize.height/2)];
		[self addChild:introImage1];
        
        CCSprite *introImage2 = [CCSprite spriteWithFile:@"door_1.png"];
        
		[introImage2 setPosition:ccp(screenSize.width/2+offX/2-5, screenSize.height/2)];
        introImage2.flipX = YES;
		[self addChild:introImage2];
        


		// Create the actions to play the intro
        id movementAction = [CCMoveTo actionWithDuration:5 position:CGPointMake(introImage.position.x, introImage.position.y-132)];
        id movementAction1 = [CCMoveTo actionWithDuration:1.5 position:CGPointMake(introImage1.position.x+620, introImage1.position.y-164)];
        id movementAction2 = [CCMoveTo actionWithDuration:1.5 position:CGPointMake(introImage2.position.x-620, introImage2.position.y-164)];
        
        
        //            // Moving animation
        id action = [CCSequence actions: movementAction, nil];
        id action1 = [CCSequence actions: movementAction1, nil];
        id action2 = [CCSequence actions: movementAction2, nil];
        
        id introSequence = [CCSequence actions:action,nil];
		id introSequence1 = [CCSequence actions:action1,nil];
		id introSequence2 = [CCSequence actions:action2,nil];
        
        
        //id introSequence2 = [CCSequence actions:action,startGameAction,nil];
        [introImage runAction:introSequence];
		[introImage1 runAction:introSequence1];
		[introImage2 runAction:introSequence2];
        
        id delay = [CCDelayTime actionWithDuration:7];
        id startGameAction = [CCCallFunc actionWithTarget:self selector:@selector(startGamePlay)];
        id introDelay = [CCSequence actions:delay,startGameAction,nil];
        [self runAction:introDelay];
	}
	return self;
}
@end
