//
//  GameCharactor.m
//  ro3
//
//  Created by JJ WEI on 12-06-27.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "GameCharacter.h"

#define SJ_PI 3.14159265359f
#define SJ_PI_X_2 6.28318530718f
#define SJ_RAD2DEG 180.0f/SJ_PI


@implementation GameCharacter

@synthesize characterState;


-(void)checkAndClampSpritePosition 
{
    
    BOOL shouldStop = NO;
    float adjustedX = self.boundingBox.size.width/2;
    float adjustedY = self.boundingBox.size.height/2;
    CGPoint currentSpritePosition = self.position;
    
    if (currentSpritePosition.x > RIGHTBOUND - adjustedX) {
         NSLog(@"self.position.x = %f,RIGHTBOUND - adjustedX=%f, adjustedX=%f", self.position.x,RIGHTBOUND - adjustedX,adjustedX);
        [self setPosition:ccp(RIGHTBOUND - adjustedX, currentSpritePosition.y)];
        shouldStop = YES;
    }
    else if (currentSpritePosition.x < LEFTBOUND + adjustedX)
    {
        [self setPosition:ccp(LEFTBOUND + adjustedX, currentSpritePosition.y)];
        shouldStop = YES;
    }
    else if (currentSpritePosition.y > UPBOUND - adjustedY)
    {
        [self setPosition:ccp(currentSpritePosition.x, UPBOUND - adjustedY)];
        shouldStop = YES;
    }
    else if (currentSpritePosition.y < BUTTONBOUND + adjustedY)
    {
        if (!is2x2) {
            
           
       
            [self setPosition:ccp(currentSpritePosition.x, BUTTONBOUND + adjustedY)];
            shouldStop = YES;
        }
        
    }
    
    
    if (shouldStop)
    {
        [SoundManager.instance playSoundEffect:@"collision"];
        [self stopAllActions];
        [self changeState:kStatePreIdle];
        accessary.position = self.position;
        accessaryEffect.position = [self getEffectPos:self.position];
        GameManager.instance.movingInProgress = NO;
        characterIsPicked = NO;
    }
    
    
    
}


#pragma mark - touch event

- (void)onEnter
{
    CCDirector *director = [CCDirector sharedDirector];
	[[director touchDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
    [super onEnter];
}
/*
- (void) onEnterTransitionDidFinish
{
    CCDirector *director = [CCDirector sharedDirector];
	[[director touchDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
}
*/
- (void) onExit
{
    CCDirector *director = [CCDirector sharedDirector];
	[[director touchDispatcher] removeDelegate:self];
    [super onExit];
}

CGFloat CGPointToDegree(CGPoint point) {
    // Provides a directional bearing from (0,0) to the given point.
    // standard cartesian plain coords: X goes up, Y goes right
    // result returns degrees, -180 to 180 ish: 0 degrees = up, -90 = left, 90 = right
    CGFloat bearingRadians = atan2f(point.y, point.x);
 //   CGFloat bearingDegrees = bearingRadians * (180. / M_PI);
 //   return bearingDegrees;
    
    return bearingRadians;
}

-(BOOL)containsTouch:(UITouch *)touch 
{
    CGRect box= self.boundingBox;
    CGPoint touchLocation = [self convertTouchToNodeSpaceAR:touch];
    touchLocation = [self convertToWorldSpaceAR:touchLocation];
    return CGRectContainsPoint(box, touchLocation);
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event 
{
    if ([GameManager instance].movingInProgress == YES || characterIsPicked == YES) {
        return NO;
    }
    //CCLOG(@"ccTouchBegan");
    CGPoint touchLocation = [touch locationInView: [touch view]];
    //    CCLOG(@"x=%f, y=%f",touchLocation.x,touchLocation.y);
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    startPoint = [self convertToNodeSpace:touchLocation];


    if ([self containsTouch:touch])
    {
        characterIsPicked = YES;
        [self changeState:kStateCrouching];
        return YES;
    }
    else
    {
        characterIsPicked = NO;
        return NO;
    }
    
    
    
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	//CCLOG(@"ccTouchEnded");
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    endPoint = [self convertToNodeSpace:touchLocation];
    

    if (characterIsPicked) 
    {
        [self updateVelocity];
        [self changeState:kStateWalking];
        GameManager.instance.movingInProgress = YES;
        
    }
    
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
	CCLOG(@"ccTouchCenceled");
    
}

-(void)updateVelocity
{
    // Calculate distance and angle from the center.
	float dx = endPoint.x - startPoint.x;
	float dy = endPoint.y - startPoint.y;
	dSqrt = sqrt(dx * dx + dy * dy);
	

    
	float angle = atan2f(dy, dx); // in radians
	if(angle < 0){
		angle		+= SJ_PI_X_2;
	}
	float cosAngle;
	float sinAngle;
	
	
	cosAngle = cosf(angle);
	sinAngle = sinf(angle);
	
	// NOTE: Velocity goes from -1.0 to 1.0.
//	if (dSq > joystickRadiusSq || isDPad) {
//		dx = cosAngle * joystickRadius;
//		dy = sinAngle * joystickRadius;
//	}
	
//	velocity = CGPointMake(dx/joystickRadius, dy/joystickRadius);
//	degrees = angle * SJ_RAD2DEG;
     velocity = CGPointMake(dx/dSqrt, dy/dSqrt);
	degrees = angle * SJ_RAD2DEG;
	
 //NSLog(@"velocity = %@, degree = %f, distance = %f", NSStringFromCGPoint(velocity), degrees,dSqrt);
}

- (CGPoint)boundLayerPos:(CGPoint)newPos 
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -winSize.width+winSize.width); 
    retval.y = self.position.y;
    return retval;
}

- (void)panForTranslation:(CGPoint)translation 
{    
    CGPoint newPos = ccpAdd(self.position, translation);
    self.position = newPos;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {   
  //  CCLOG(@"ccTouchMoved");
//    if (characterIsPicked) 
//    {
//        lastTouch = touch;
//        if (!characterIsMoving) 
//        {
//            [self changeState:kStateAttacking];
//            characterIsMoving = YES;
//        }
//        CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
//        
//        CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
//        oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
//        oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
//        
//        CGPoint translation = ccpSub(touchLocation, oldTouchLocation);    
//        [self panForTranslation:translation]; 
//    }
    
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer 
{
    
    if (recognizer.state == UIGestureRecognizerStateBegan) 
    {    
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
        touchLocation = [self convertToNodeSpace:touchLocation];                
    } 
    else if (recognizer.state == UIGestureRecognizerStateChanged) 
    {    
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = ccp(translation.x, -translation.y);
        [self panForTranslation:translation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];    
    } 
    else if (recognizer.state == UIGestureRecognizerStateEnded) 
    {
        
        /*     if (!selSprite) {         
         float scrollDuration = 0.2;
         CGPoint velocity = [recognizer velocityInView:recognizer.view];
         CGPoint newPos = ccpAdd(self.position, ccpMult(velocity, scrollDuration));
         newPos = [self boundLayerPos:newPos];
         
         [self stopAllActions];
         CCMoveTo *moveTo = [CCMoveTo actionWithDuration:scrollDuration position:newPos];            
         [self runAction:[CCEaseOut actionWithAction:moveTo rate:1]];            
         }        
         */  
    }        
}

- (CGPoint) getEffectPos:(CGPoint)pos {
    CGFloat x = pos.x -(self.boundingBox.size.width/2)*0.7;
    CGFloat y = pos.y +(self.boundingBox.size.height/2)*0.7;
    CGPoint lp = CGPointMake(x, y);
    return lp;
}
@end
