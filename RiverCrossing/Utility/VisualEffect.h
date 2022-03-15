//
//  VisualEffect.h
//  puzzle
//
//  Created by Jean-Jean Wei on 13-03-05.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "CCNode.h"

@interface VisualEffect : CCNode

+ (void)pluseEffect:(CCNode*)node;
+ (void)pluseEffect:(CCNode*)node duration:(float)d;
+ (void)bouncingMove:(CCNode*)node duration:(float)d posistion:(CGPoint)p;
+ (void)fadeOutEffect:(CCNode*)node duration:(float)d;
+ (void)fadeOutInEffect:(CCNode*)node fadeDuration:(float)d idleDuration:(float)d2;
@end
