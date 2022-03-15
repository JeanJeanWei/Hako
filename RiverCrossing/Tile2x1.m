//
//  Tile2x1.m
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-03.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "Tile2x1.h"


@implementation Tile2x1

-(void)checkAndClampSpritePosition
{
    [super checkAndClampSpritePosition];
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
    
    if ((degrees > 45 && degrees < 135) || (degrees > 225 && degrees < 315))
    {
        float distance = scaledVelocity.y * deltaTime;
        //   NSLog(@"distance = %f",distance);
        newPosition.y+=distance;
        
    }
    else
    {
        float distance = scaledVelocity.x * deltaTime;
        newPosition.x+=distance;
        if (distance > 0) {
            gameObjDirection = right;
            accessary.gameObjDirection = right;
        } else {
            gameObjDirection = left;
            accessary.gameObjDirection = left;
        }
    }
    //     NSLog(@"distance = %f",distance);
   
    self.position = newPosition;
    accessary.position = newPosition;
    accessaryEffect.position = [self getEffectPos:newPosition];
}


-(void)changeState:(CharacterStates)newState
{
    [self stopAllActions];
    id action = nil;
    self.characterState = newState;
    
    switch (newState)
    {
        case kStateIdle:
            [accessaryEffect changeState:kStateIdle];
            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kIdlingAnim]];
            break;
            
        case kStateWalking:
            accessary.characterState = kStateWalking;
            accessaryEffect.characterState = kStateWalking;
            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kWalkingAnim]];
            break;
            
        case kStateCrouching:
            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kCrouchingAnim]];
            break;
            
        case kStateBreathing:
            [accessaryEffect changeState:kStateBreathing];
            action = [CCAnimate actionWithAnimation:[ccAnimArray objectAtIndex:kBreathingAnim]];
            break;
            
        case kStatePreIdle:
            [accessary changeState:kStatePreIdle];
            [accessaryEffect changeState:kStatePreIdle];
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
    //    if (self.characterState == kStateDead)
    //        return; // Nothing to do if the Body is dead
    

    
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
                
                if (CGRectIntersectsRect(myBoundingBox, characterBox)) {
                    [SoundManager.instance playSoundEffect:@"collision"];
                    [self stopAllActions];
                    
                    [self changeState:kStatePreIdle];
                    if (!isnan(self.position.x) && !isnan(self.position.y))
                    {
                        CGPoint pos = [TileHelper.instance getClosest_2x1:self.position];
                        self.position = pos;
                        accessary.position = pos;
                        accessaryEffect.position = [self getEffectPos:pos];
                    }
                    else
                    {
                        self.position = oldPosition;
                        accessary.position = oldPosition;
                        accessaryEffect.position = [self getEffectPos:oldPosition];
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

- (id)initWithPosition:(int)pos andSprite:(id)obj andEffect:(GameItem*)effect
{
    
    self = [super init];
    if (self != nil)
    {
        is2x2 = NO;
        CGPoint p = [TileHelper.instance getPosition:pos forTile:k2x1];
        self.position = p;
        oldPosition = p;
        
        accessary = obj;
        accessary.position = p;
        
        accessaryEffect = effect;
        accessaryEffect.position = [self getEffectPos:p];
        
        millisecondsStayingIdle = 0.0f;
        
        [self initAnimations];
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"2x1_idle_1.png"]]; 
    }
    return self;
}


@end
