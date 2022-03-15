//
//  BackgroundLayer.m
//  ro3
//
//  Created by JJ WEI on 12-06-27.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "BackgroundLayer.h"
#import "CCSprite.h"
#import "CCDirector.h"

@implementation BackgroundLayer


-(id)initWithType:(BackgroundTypes)type {
    self = [super init]; // 1
    if (self != nil) { // 2
        // 3
        CCSprite *backgroundImage;
        switch (type)
        {
            case kMainMenuBackground:
                backgroundImage = [CCSprite spriteWithFile:@"background6.jpg"];
                break;
            case kGameLevel1:
                backgroundImage = [CCSprite spriteWithFile:@"Background23.png"];
                break;
            case kLevelCompleteBackground:
                backgroundImage = [CCSprite spriteWithFile:@"op2.jpg"];
                break;
            default:
                break;
        }
           
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize]; // 4
        [backgroundImage setPosition:
         CGPointMake(screenSize.width/2, screenSize.height/2)]; // 5
        [self addChild:backgroundImage z:0 tag:0]; // 6
    }
    return self; // 7
}
//-(id)init {
//    self = [super init]; // 1
//    if (self != nil) { // 2
//        // 3
//        CCSprite *backgroundImage;
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            // Indicates game is running on iPad
//            backgroundImage = [CCSprite
//                               spriteWithFile:@"test.png"];
//        } else {
//            backgroundImage = [CCSprite
//                               spriteWithFile:@"Default-568h@2x.png"];
//        }
//        CGSize screenSize = [[CCDirector sharedDirector] winSize]; // 4
//        [backgroundImage setPosition:
//         CGPointMake(screenSize.width/2, screenSize.height/2)]; // 5
//        [self addChild:backgroundImage z:0 tag:0]; // 6
//    }
//    return self; // 7
//}
@end
