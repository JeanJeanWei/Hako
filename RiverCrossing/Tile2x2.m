//
//  Tile2x2.m
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-03.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "Tile2x2.h"

@implementation Tile2x2

-(void)checkAndClampSpritePosition
{
    float adjustedX = self.boundingBox.size.width/2;
    float adjustedY = self.boundingBox.size.height/2;
    CGPoint currentSpritePosition = self.position;

    BOOL shouldStop = NO;
    
    [super checkAndClampSpritePosition];
    if (currentSpritePosition.y < BUTTONBOUND + adjustedY)// && !isOut)
    {
        
        CGPoint p;
        if (currentSpritePosition.x < 70 + adjustedX) {
            p  = [TileHelper.instance getPosition:11 forTile:k2x2];
            
            shouldStop = YES;
            self.position = p;
        } else if (currentSpritePosition.x > 250 - adjustedX) {
            p = [TileHelper.instance getPosition:9 forTile:k2x2];
            
            shouldStop = YES;
            self.position = p;
        }
        
       // NSLog(@"check clamp %@", NSStringFromCGPoint(self.position));
    }
    if (shouldStop)
    {
        [SoundManager.instance playSoundEffect:@"collision"];
        [self stopAllActions];
        [self changeState:kStatePreIdle];
        GameManager.instance.movingInProgress = NO;
        characterIsPicked = NO;
    }
    // get curren position again to check if the 2x2 tile is over the botton boundary
    currentSpritePosition = [self position];
    if (CGPointEqualToPoint(currentSpritePosition,goalPoint)) {
        [self onExit];
        self.position = ccp(goalPoint.x, goalPoint.y-1);
       
        [self stopAllActions];
        degrees = 90;
        dSqrt = 60;
        velocity = CGPointMake(0, -1);
        [self changeState:kStateWalking];
        

#if DEBUG
        NSLog(@"check 2x2 hit the screen botton %@", NSStringFromCGPoint(currentSpritePosition));
#endif

        
    }
//    if (currentSpritePosition .y <  BUTTONBOUND + adjustedY-2)
//    {
//#if DEBUG
//        NSLog(@"check 2x2 is out %@", NSStringFromCGPoint(currentSpritePosition));
//#endif
//      
//        [self onExit];
//        [GameManager.instance saveLevelTime];
    if (currentSpritePosition.y < adjustedY) {
#if DEBUG
        NSLog(@"check 2x2 hit the screen botton %@", NSStringFromCGPoint(currentSpritePosition));
#endif
 
        [[GameManager instance] runSceneWithID:kLevelCompleteScene];
        GameManager.instance.movingInProgress = NO;
        characterIsPicked = NO;
    }
//    }
}

-(void)applyTimeDelta:(float)deltaTime
{
    CGPoint newPosition = self.position;
    
    oldPosition = self.position;
    //CGPoint velocity = CGPointMake(1, 1);
    CGPoint scaledVelocity;
    if (dSqrt >= 60) {
        scaledVelocity = ccpMult(velocity, SPEED_FAST);
    } else {
        scaledVelocity = ccpMult(velocity, SPEED_SLOW);
    }
    
    //float distance = scaledVelocity.x * deltaTime;
    
    if ((degrees > 45 && degrees < 135) || (degrees > 225 && degrees < 315)) {
        
        float distance = scaledVelocity.y * deltaTime;
        //   NSLog(@"distance = %f",distance);
        newPosition.y+=distance;
    } else {
        float distance = scaledVelocity.x * deltaTime;
        newPosition.x+=distance;
        //     NSLog(@"distance = %f",distance);
    }
    
    //     NSLog(@"distance = %f",distance);
    
    self.position = newPosition;
    accessary.position = newPosition;
}


-(void)changeState:(CharacterStates)newState
{
    [self stopAllActions];
    id action = nil;
    self.characterState = newState;
    
    switch (newState)
    {
        case kStateIdle:
            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kIdlingAnim]];
            break;
            
        case kStateWalking:
            accessary.characterState = kStateWalking;
            // [captain changeState:kStateWalking];
            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kWalkingAnim]];
            
            break;
            
        case kStateCrouching:            
            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kCrouchingAnim]];
            break;
            
        case kStateBreathing:
            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kBreathingAnim]];
            break;
            
        case kStatePreIdle:
            [accessary changeState:kStatePreIdle];
            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kPreIdlingAnim]];
            break;
            
        default:
            break;
    }
    if (action != nil)
    {
        [self runAction:action];
    }
}

#pragma mark -
-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray*)listOfGameObjects
{
#if DEBUG
    //    for (GameCharacter *character in listOfGameObjects) {
    //        NSLog(@"character.tag = %i", character.tag);
    //    }
#endif
    
    // Check for collisions
    // Change this to keep the object count from querying it each time
    if (characterIsPicked)
    {
        CGRect myBoundingBox = [self boundingBox];
        for (GameCharacter *character in listOfGameObjects) {
            // No need to check collision with one's self
            
            if (character.tag != self.tag)
            {
                CGRect characterBox = [character boundingBox];
                
                if (CGRectIntersectsRect(myBoundingBox, characterBox))
                {
                    [SoundManager.instance playSoundEffect:@"collision"];
                    [self stopAllActions];
                    
                    [self changeState:kStatePreIdle];
                    if (!isnan(self.position.x) && !isnan(self.position.y)) {
                        CGPoint pos = [TileHelper.instance getClosest_2x2:self.position];
                        self.position = pos;
                        accessary.position = pos;
                    }
                    else
                    {
                        self.position = oldPosition;
                        accessary.position = oldPosition;
                    }
                    GameManager.instance.movingInProgress = NO;
                    characterIsPicked = NO;
                }
            }
        }
    }
    
    [self checkAndClampSpritePosition];
    
    if (self.characterState == kStateWalking)
    {
        [self applyTimeDelta:deltaTime];
    }
    
    if ([self numberOfRunningActions] == 0)
    {
        if (self.characterState == kStatePreIdle)
        {
            [self changeState:kStateIdle];
            characterIsPicked = NO;
            GameManager.instance.movingInProgress = NO;
        }
        else
        {
            [self changeState:self.characterState];
        }
        
    }
    
}

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
- (id)initWithPosition:(int)pos andSprite:(id)obj
{
    
    self = [super init];
    if (self != nil)
    {
        is2x2 = YES;
        goalPoint = [TileHelper.instance getPosition:10 forTile:k2x2];
        CGPoint p = [TileHelper.instance getPosition:pos forTile:k2x2];
        self.position = p;
        oldPosition = p;
        
        accessary = obj;
        accessary.position = p;
        
        millisecondsStayingIdle = 0.0f;
        
        [self initAnimations];
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"2x2_idle_1.png"]];
        
    }
    return self;
}
@end
