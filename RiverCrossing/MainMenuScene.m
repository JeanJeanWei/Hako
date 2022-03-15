//  MainMenuScene.m
//  Hako
//
#import "MainMenuScene.h"


@implementation MainMenuScene
-(id)init {
    self = [super init];
    if (self != nil) {
        BackgroundLayer *backgroundLayer = [[BackgroundLayer alloc] initWithType:kMainMenuBackground]; // 1
        [self addChild:backgroundLayer z:0]; // 2
        mainMenuLayer = [MainMenuLayer node];
        [self addChild:mainMenuLayer];
    }
    return self;
}
@end



//-(id)init {
//    self = [super init];
//    if (self != nil) {
//        // Background Layer
//        BackgroundLayer *backgroundLayer = [BackgroundLayer node]; // 1
//        [self addChild:backgroundLayer z:0]; // 2
//        // Gameplay Layer
//        // GameplayLayer *gameplayLayer = [GameplayLayer node]; // 3
//        // [self addChild:gameplayLayer z:5]; // 4
//        
//        GameplayLayerNormal *gameplayLayer = [GameplayLayerNormal node]; // 3
//        [self addChild:gameplayLayer z:5]; // 4
//    }
//    return self;
//}
