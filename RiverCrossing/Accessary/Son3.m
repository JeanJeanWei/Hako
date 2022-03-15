//
//  Son2.m
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-16.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "Son3.h"

@implementation Son3

-(void)checkAndClampSpritePosition
{
  //  [super checkAndClampSpritePosition];
}

//-(void)changeState:(CharacterStates)newState
//{
//    [self stopAllActions];
//    id action = nil;
//    //  self.characterState = newState;
//    
//    switch (newState)
//    {
//        case kStateIdle:
//            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kBreathingAnim]];
//            break;
//            
//        case kStateWalking:            
//            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kWalkingAnim]];
//            break;
//            
//        case kStateCrouching:                        
//            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kCrouchingAnim]];
//            break;
//                        
//        case kStateBreathing:
//            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kBreathingAnim]];
//            break;
//        case kStatePreIdle:
//            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kPreIdlingAnim]];
//            self.characterState = kStateIdle;
//            break;
//            
//        default:
//            break;
//    }
//    if (action != nil)
//    {
//        [self runAction:action];
//    }
//}
//
//#pragma mark -
//-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray*)listOfGameObjects
//{
//
//    [self checkAndClampSpritePosition];
//    
//    
//    if ([self numberOfRunningActions] == 0)
//    {
//        if (self.characterState == kStatePreIdle)
//        {
//            [self changeState:kStateIdle];
//        }
//        else
//        {
//            [self changeState:self.characterState];
//        }
//
//        
//    }
//    
//}

#pragma mark -
-(CGRect)adjustedBoundingBox {
    // Adjust the bouding box to the size of the sprite
    // without the transparent space
    CGRect bodyBoundingBox = [self boundingBox];
    float xOffset;
    float xCropAmount = bodyBoundingBox.size.width * 0.5482f;
    float yCropAmount = bodyBoundingBox.size.height * 0.095f;
    
    if ([self flipX] == NO)
    {
        // Body is facing to the rigth, back is on the left
        xOffset = bodyBoundingBox.size.width * 0.1566f;
    } else
    {
        // Body is facing to the left; back is facing right
        xOffset = bodyBoundingBox.size.width * 0.4217f;
    }
    bodyBoundingBox =
    CGRectMake(bodyBoundingBox.origin.x + xOffset,
               bodyBoundingBox.origin.y,
               bodyBoundingBox.size.width - xCropAmount,
               bodyBoundingBox.size.height - yCropAmount);
    
    if (characterState == kStateCrouching) {
		// Shrink the bounding box to 56% of height
        // 88 pixels on top on iPad
		bodyBoundingBox = CGRectMake(bodyBoundingBox.origin.x,
                                     bodyBoundingBox.origin.y,
                                     bodyBoundingBox.size.width,
                                     bodyBoundingBox.size.height * 0.56f);
	}
    
    return bodyBoundingBox;
}

#pragma mark -
-(void)initAnimations
{
    // load animations from Classname.plist to animation array
    NSString *str = NSStringFromClass([self class]);
    ccAnimArray = [NSMutableArray new];
    for (int i = 0; i<kNumOfCharacterAnimeTypes; i++)
    {
        CCAnimation *temp = [self loadPlistForAnimationWithName:[ANIM_NAMES objectAtIndex:i] andClassName:str];
        [ccAnimArray addObject:temp];
    }
    
}

#pragma mark -
- (id)init
{
    self = [super init];
    if (self != nil)
    {
        self.gameObjectType = kBodyType;
        
        millisecondsStayingIdle = 0.0f;
        
        [self initAnimations];
        
        [self onExit];
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"son3_idle_1.png"]];
        self.characterState = kStateIdle;

        
    }
    return self;
}

@end
