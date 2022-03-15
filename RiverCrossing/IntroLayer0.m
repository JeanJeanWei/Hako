//
//  IntroLayer.m
//
#import "IntroLayer0.h"
#import "VisualEffect.h"

@implementation IntroLayer0
-(void)startGamePlay {
	CCLOG(@"Intro complete, asking Game Manager to start the Real intro");
	[[GameManager instance] runSceneWithID:kIntroScene];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	CCLOG(@"Touches received, skipping intro0");
	[self startGamePlay];
}

- (void)action1
{
    double delayInSeconds = 6.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
    {
        
        CCSprite *op = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"op1_2_1.jpg"]];
 
		op.position = ccp(screenSize.width/2, screenSize.height/2);
        if (screenSize.height == 480.0f ) {
            CGPoint p = op.position;
            op.position = ccp(p.x, p.y-44);
        }
        op.opacity = 0;
        
        [VisualEffect fadeOutInEffect:op fadeDuration:1 idleDuration:30];
		[self addChild:op];
    });
}
- (void)action2
{
    double delayInSeconds = 6.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {                       
                       CCSprite *op = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"op1_txt_1.png"]];

                       op.position = ccp(screenSize.width/2, screenSize.height*0.1);
                       op.opacity = 0;
                       
                       [VisualEffect fadeOutInEffect:op fadeDuration:1 idleDuration:4];
                       [self addChild:op];
                   });
}
- (void)action3
{
    double delayInSeconds = 12.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       CCSprite *op = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"op1_txt_2.png"]];
                       
                       op.position = ccp(screenSize.width/2, screenSize.height*0.1);
                       op.opacity = 0;
                       
                       [VisualEffect fadeOutInEffect:op fadeDuration:1 idleDuration:4];
                       [self addChild:op];
                   });
}
- (void)action4
{
    double delayInSeconds = 18.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       CCSprite *op = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"op1_txt_3.png"]];
                       
                       op.position = ccp(screenSize.width/2, screenSize.height*0.1);
                       op.opacity = 0;
                       
                       [VisualEffect fadeOutInEffect:op fadeDuration:1 idleDuration:4];
                       [self addChild:op];
                   });
}
- (void)action5
{
    double delayInSeconds = 24.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       CCSprite *op = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"op1_txt_4.png"]];
                       
                       op.position = ccp(screenSize.width/2, screenSize.height*0.1);
                       op.opacity = 0;
                       
                       [VisualEffect fadeOutInEffect:op fadeDuration:1 idleDuration:4];
                       [self addChild:op];
                   });
}
- (void)action6
{
    double delayInSeconds = 30.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       CCSprite *op = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"op1_txt_5.png"]];
                       
                       op.position = ccp(screenSize.width/2, screenSize.height*0.1);
                       op.opacity = 0;
                       
                       [VisualEffect fadeOutInEffect:op fadeDuration:1 idleDuration:4];
                       [self addChild:op];
                   });
}
- (void)action7
{
    double delayInSeconds = 12.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       CCSprite *op = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"op1_2.png"]];
                       
                       op.position = ccp(screenSize.width/2, screenSize.height*0.55);
                       op.opacity = 0;
                       
                       [VisualEffect fadeOutInEffect:op fadeDuration:1 idleDuration:3];
                       [self addChild:op];
                   });
}

- (void)action8
{
    double delayInSeconds = 16.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       CCSprite *op = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"op1_3.png"]];
                       
                       op.position = ccp(screenSize.width/2, screenSize.height*0.5);
                       op.opacity = 0;
                       
                       [VisualEffect fadeOutInEffect:op fadeDuration:1 idleDuration:3];
                       [self addChild:op];
                   });
}
- (void)action9
{
    double delayInSeconds = 24.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       CCSprite *op = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"op1_2_1.png"]];
                       
                       op.position = ccp(screenSize.width/2, screenSize.height*0.5);
                       op.opacity = 0;
                       
                       [VisualEffect fadeOutInEffect:op fadeDuration:1 idleDuration:2];
                       [self addChild:op];
                   });
}
- (void)action10
{
    double delayInSeconds = 28.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       CCSprite *op = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"op1_2_2.png"]];
                       
                       op.position = ccp(screenSize.width/2, screenSize.height*0.5);
                       op.opacity = 0;
                       
                       [VisualEffect fadeOutInEffect:op fadeDuration:1 idleDuration:2];
                       [self addChild:op];
                   });
}
- (void)action11
{
    double delayInSeconds = 32.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       CCSprite *op = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"op1_2_3.png"]];
                       
                       op.position = ccp(screenSize.width/2, screenSize.height*0.5);
                       op.opacity = 0;
                       
                       [VisualEffect fadeOutInEffect:op fadeDuration:1 idleDuration:2];
                       [self addChild:op];
                   });
}
- (void)playBackgroundMusic
{
    [SoundManager.instance playBackgroundTrack:BACKGROUND_TRACK_INTRO0];
}
- (void)prepareMusic
{
    id playMusic = [CCCallFunc actionWithTarget:self selector:@selector(playBackgroundMusic)];
    id delay = [CCDelayTime actionWithDuration:6];
    id introSequence = [CCSequence actions:delay,playMusic,nil];
    [self runAction:introSequence];
}
-(id)init
{
	self = [super init];
	if (self != nil) {
		// Accept touch input
		self.isTouchEnabled = YES;
        
		// Create the intro image
		screenSize = [CCDirector sharedDirector].winSize;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"op1.plist"];
        CCSpriteBatchNode *opSprites = [CCSpriteBatchNode batchNodeWithFile:@"op1.png"];
        [self addChild:opSprites];
        
        CCSprite *op1_1 = [[CCSprite alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"op1_1.png"]];
        //float offY = (introImage.boundingBox.size.height - screenSize.height)/2;
        
		op1_1.position = ccp(screenSize.width/2, screenSize.height/2);
        op1_1.opacity = 0;

        [VisualEffect fadeOutInEffect:op1_1 fadeDuration:1 idleDuration:4];
		[self addChild:op1_1];
        [self prepareMusic];
        [self action1];
        [self action2];
        [self action3];
        [self action4];
        [self action5];
        [self action6];
        [self action7];
        [self action8];
        [self action9];
        [self action10];
        [self action11];
        
         id startGameAction = [CCCallFunc actionWithTarget:self selector:@selector(startGamePlay)];
        id delay = [CCDelayTime actionWithDuration:37];
        id introSequence2 = [CCSequence actions:delay,startGameAction,nil];
        [self runAction:introSequence2];
        //        if (screenSize.height == 480.0f ) {
        //            CGPoint p = introImage.position;
        //            introImage.position = ccp(p.x, p.y-88);
        //        }
//        CCSprite *introImage1 = [CCSprite spriteWithFile:@"door_1.png"];
//        float offX = introImage1.boundingBox.size.width/2;
//		[introImage1 setPosition:ccp(screenSize.width-offX, screenSize.height/2)];
//		[self addChild:introImage1];
//        
//        CCSprite *introImage2 = [CCSprite spriteWithFile:@"door_1.png"];
//        
//		[introImage2 setPosition:ccp(screenSize.width/2+offX/2-5, screenSize.height/2)];
//        introImage2.flipX = YES;
//		[self addChild:introImage2];
//        
//
//
//		// Create the actions to play the intro
//        id movementAction = [CCMoveTo actionWithDuration:5 position:CGPointMake(introImage.position.x, introImage.position.y-132)];
//        id movementAction1 = [CCMoveTo actionWithDuration:1.5 position:CGPointMake(introImage1.position.x+620, introImage1.position.y-164)];
//        id movementAction2 = [CCMoveTo actionWithDuration:1.5 position:CGPointMake(introImage2.position.x-620, introImage2.position.y-164)];
//        
//        
//        //            // Moving animation
//        id action = [CCSequence actions: movementAction, nil];
//        id action1 = [CCSequence actions: movementAction1, nil];
//        id action2 = [CCSequence actions: movementAction2, nil];
//        
//        id introSequence = [CCSequence actions:action,nil];
//		id introSequence1 = [CCSequence actions:action1,nil];
//		id introSequence2 = [CCSequence actions:action2,nil];
//        
//        
//        //id introSequence2 = [CCSequence actions:action,startGameAction,nil];
//        [introImage runAction:introSequence];
//		[introImage1 runAction:introSequence1];
//		[introImage2 runAction:introSequence2];
//        
//        
//        id startGameAction = [CCCallFunc actionWithTarget:self selector:@selector(startGamePlay)];
	}
	return self;
}
@end
