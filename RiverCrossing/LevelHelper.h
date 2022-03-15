//
//  LevelHelper.h
//  puzzle
//
//  Created by Jean-Jean Wei on 13-02-24.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelHelper : NSObject
{
    NSArray *levelDeployment;
}

+ (LevelHelper*)instance;
- (void)loadLevelPlistByAvator:(int)groupID;
- (NSArray*)getLevelMatrix:(int)idx;

- (void)print;
@end
