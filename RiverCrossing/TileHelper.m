//
//  TileHelper.m
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-22.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "TileHelper.h"

@implementation TileHelper

//Singleton Setup
+ (TileHelper*)instance
{
    static dispatch_once_t pred = 0;
    __strong static TileHelper *_instance = nil;
    
    dispatch_once(&pred, ^{
        _instance = [[self alloc] init];
        
    });
    return _instance;
    
}



-(id)init
{
    self = [super init];
    if (self != nil)
    {
        // TileHelper initialized
        CCLOG(@"TileHelper Singleton, init");
        t_1x1 = [self create_t1x1];
        t_1x2 = [self create_t1x2];
        t_2x1 = [self create_t2x1];
        t_2x2 = [self create_t2x2];
    }
    return self;
}

- (CGPoint)getClosest_1x1:(CGPoint)pos
{
    int idx = -1;
    float distance = 46001.00;
    
    for (int i = 0; i < 20; i++) {
        CGPoint t = [[t_1x1 objectAtIndex:i] CGPointValue];
        float dx = t.x - pos.x;
        float dy = t.y - pos.y;
        float tmp = dx*dx +dy*dy;
        if (tmp < distance) {
            distance = tmp;
            idx = i;
        }
    }
    if (idx == -1) {
        
        return pos;
    } else {
        return [[t_1x1 objectAtIndex:idx] CGPointValue];
    }
}

- (CGPoint)getClosest_1x2:(CGPoint)pos
{
    int idx = -1;
    float distance = 46001.00;
    
    for (int i = 0; i < 16; i++) {
        CGPoint t = [[t_1x2 objectAtIndex:i] CGPointValue];
        float dx = t.x - pos.x;
        float dy = t.y - pos.y;
        float tmp = dx*dx +dy*dy;
        if (tmp < distance) {
            distance = tmp;
            idx = i;
        }
    }
    if (idx == -1) {
        return pos;
    } else {
        return [[t_1x2 objectAtIndex:idx] CGPointValue];
    }
}

- (CGPoint)getClosest_2x1:(CGPoint)pos
{
    int idx = -1;
    float distance = 46001.00;
    
    for (int i = 0; i < 15; i++) {
        CGPoint t = [[t_2x1 objectAtIndex:i] CGPointValue];
        float dx = t.x - pos.x;
        float dy = t.y - pos.y;
        float tmp = dx*dx +dy*dy;
        if (tmp < distance) {
            distance = tmp;
            idx = i;
        }
    }
    if (idx == -1) {
        return pos;
    } else {
        return [[t_2x1 objectAtIndex:idx] CGPointValue];
    }
}

- (CGPoint)getClosest_2x2:(CGPoint)pos
{
    int idx = -1;
    float distance = 46001.00;
    
    for (int i = 0; i < 12; i++) {
        CGPoint t = [[t_2x2 objectAtIndex:i] CGPointValue];
        float dx = t.x - pos.x;
        float dy = t.y - pos.y;
        float tmp = dx*dx +dy*dy;
        if (tmp < distance) {
            distance = tmp;
            idx = i;
        }
    }
    if (idx == -1) {
        return pos;
    } else {
        return [[t_2x2 objectAtIndex:idx] CGPointValue];
    }
}

- (CGPoint)getPosition:(int)idx forTile:(TileType)type
{
    CGPoint p;
    switch (type) {
        case k1x1:
            p = [[t_1x1 objectAtIndex:idx] CGPointValue];
            break;
        case k1x2:
            p = [[t_1x2 objectAtIndex:idx] CGPointValue];
            break;
        case k2x1:
            p = [[t_2x1 objectAtIndex:idx] CGPointValue];
            break;
        case k2x2:
            p = [[t_2x2 objectAtIndex:idx] CGPointValue];
            break;
            CCLOG(@"unknow tile type");
        default:
            break;
    }
    return p;
}
//-(NSArray*)create_t1x1_x
//{
//    NSMutableArray *temp = [NSMutableArray new];
//    float start = RIGHTBOUND - 37.5f;
//    float off = 75.0f;
//    
//    for (int i=0; i<20; i++) {
//        float num = start - off * (i%4);
//        [temp addObject:[NSNumber numberWithFloat:num]];
//    }
//    return temp;
//}
- (NSArray*)create_t1x1
{
    NSMutableArray *temp = [NSMutableArray new];
    
    float startX = RIGHTBOUND - 37.5f;
    float offX = 75.0f;
    
    float startY = UPBOUND - 37.5f;
    float offY = 75.0f;
    
    for (int i=0; i<5; i++) {
        float numY = startY - offY * i;
        for (int j=0; j<4; j++) {
            float numX = startX - offX*j;
            [temp addObject:[NSValue valueWithCGPoint:CGPointMake(numX, numY)]];
        }
        
    }
    return temp;
}

- (NSArray*)create_t1x2
{
    NSMutableArray *temp = [NSMutableArray new];
    
    float startX = RIGHTBOUND - 37.5f;
    float offX = 75.0f;
    float startY = UPBOUND - 75.0f;
    float offY = 75.0f;
    
    for (int i=0; i<4; i++) {
        float numY = startY - offY * i;
        for (int j=0; j<4; j++) {
            float numX = startX - offX*j;
            [temp addObject:[NSValue valueWithCGPoint:CGPointMake(numX, numY)]];
        }
        
    }
    return temp;
}

- (NSArray*)create_t2x1
{
    NSMutableArray *temp = [NSMutableArray new];
    
    float startX = RIGHTBOUND - 75.0f;
    float offX = 75.0f;
    float startY = UPBOUND - 37.5f;
    float offY = 75.0f;
    
    for (int i=0; i<5; i++) {
        float numY = startY - offY * i;
        for (int j=0; j<3; j++) {
            float numX = startX - offX*j;
            [temp addObject:[NSValue valueWithCGPoint:CGPointMake(numX, numY)]];
        }
        
    }
    return temp;
}

- (NSArray*)create_t2x2
{
    NSMutableArray *temp = [NSMutableArray new];
    
    float startX = RIGHTBOUND - 75.0f;
    float offX = 75.0f;
    float startY = UPBOUND - 75.0f;
    float offY = 75.0f;
    
    for (int i=0; i<4; i++) {
        float numY = startY - offY * i;
        for (int j=0; j<3; j++) {
            float numX = startX - offX*j;
            [temp addObject:[NSValue valueWithCGPoint:CGPointMake(numX, numY)]];
        }
        
    }
    return temp;
}
//-(NSArray*)create_t1x1_y
//{
//    NSMutableArray *temp = [NSMutableArray new];
//    float start = UPBOUND - 37.5f;
//    float off = 75.0f;
//    for (int i=0; i<5; i++) {
//        float num = start - off * (i%4);
//        for (int j=0; j<4; j++) {
//            [temp addObject:[NSNumber numberWithFloat:num]];
//        }
//    
//    }
//    return temp;
//}
@end
