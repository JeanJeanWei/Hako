//
//  TileHelper.h
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-22.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TileHelper : NSObject
{
    NSArray *t_1x1;
    NSArray *t_2x1;
    NSArray *t_1x2;
    NSArray *t_2x2;
}

+ (TileHelper*)instance;
 
- (CGPoint)getClosest_1x1:(CGPoint)pos;
- (CGPoint)getClosest_1x2:(CGPoint)pos;
- (CGPoint)getClosest_2x1:(CGPoint)pos;
- (CGPoint)getClosest_2x2:(CGPoint)pos;

- (CGPoint)getPosition:(int)idx forTile:(TileType)type;
@end
