//
//  UserPreferences.m
//  hako
//
//  Created by Jean-Jean Wei on 13-01-19.
//
//

#import "UserPreferences.h"

#define kLevelCount 21

@implementation UserPreferences

@synthesize stage1, stage2, stage3, stage4, stage5;
@synthesize currentStage,isMusicOn,isSoundEffectOn;
@synthesize lbStage1,lbStage2,lbStage3,lbStage4,lbStage5;
@synthesize achievementStage1, achievementStage2, achievementStage3, achievementStage4, achievementStage5;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        stage1 = [NSMutableArray new];
        stage2 = [NSMutableArray new];
        stage3 = [NSMutableArray new];
        stage4 = [NSMutableArray new];
        stage5 = [NSMutableArray new];
        currentStage = 1;
        isMusicOn = YES;
        isSoundEffectOn = YES;
        lbStage1 = 0;
        lbStage2 = 0;
        lbStage3 = 0;
        lbStage4 = 0;
        lbStage5 = 0;
        achievementStage1 = [NSMutableArray new];
        achievementStage2 = [NSMutableArray new];
        achievementStage3 = [NSMutableArray new];
        achievementStage4 = [NSMutableArray new];
        achievementStage5 = [NSMutableArray new];
        
        [self creatScoreArray];
    }
    return self;
}

- (void)creatScoreArray
{
    for (int i = 0; i<kLevelCount; i++) {
        [stage1 addObject:[NSNumber numberWithInt:0]];
        [stage2 addObject:[NSNumber numberWithInt:0]];
        [stage3 addObject:[NSNumber numberWithInt:0]];
        [stage4 addObject:[NSNumber numberWithInt:0]];
        [stage5 addObject:[NSNumber numberWithInt:0]];
        
        [achievementStage1 addObject:[NSNumber numberWithInt:0]];
        [achievementStage2 addObject:[NSNumber numberWithInt:0]];
        [achievementStage3 addObject:[NSNumber numberWithInt:0]];
        [achievementStage4 addObject:[NSNumber numberWithInt:0]];
        [achievementStage5 addObject:[NSNumber numberWithInt:0]];
    }
}

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        stage1 = [coder decodeObjectForKey:@"stage1"];
        stage2 = [coder decodeObjectForKey:@"stage2"];
        stage3 = [coder decodeObjectForKey:@"stage3"];
        stage4 = [coder decodeObjectForKey:@"stage4"];
        stage5 = [coder decodeObjectForKey:@"stage5"];
        currentStage = [coder decodeIntForKey:@"currentStage"];
        isMusicOn = [coder decodeBoolForKey:@"isMusicOn"];
        isSoundEffectOn = [coder decodeBoolForKey:@"isSoundEffectOn"];
        lbStage1 = [coder decodeIntForKey:@"lbStage1"];
        lbStage2 = [coder decodeIntForKey:@"lbStage2"];
        lbStage3 = [coder decodeIntForKey:@"lbStage3"];
        lbStage4 = [coder decodeIntForKey:@"lbStage4"];
        lbStage5 = [coder decodeIntForKey:@"lbStage5"];
        
        achievementStage1 = [coder decodeObjectForKey:@"achievementStage1"];
        achievementStage2 = [coder decodeObjectForKey:@"achievementStage2"];
        achievementStage3 = [coder decodeObjectForKey:@"achievementStage3"];
        achievementStage4 = [coder decodeObjectForKey:@"achievementStage4"];
        achievementStage5 = [coder decodeObjectForKey:@"achievementStage5"];
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:stage1 forKey:@"stage1"];
    [coder encodeObject:stage2 forKey:@"stage2"];
    [coder encodeObject:stage3 forKey:@"stage3"];
    [coder encodeObject:stage4 forKey:@"stage4"];
    [coder encodeObject:stage5 forKey:@"stage5"];
    [coder encodeInt:currentStage forKey:@"currentStage"];
    [coder encodeBool:isMusicOn forKey:@"isMusicOn"];
    [coder encodeBool:isSoundEffectOn forKey:@"isSoundEffectOn"];
    [coder encodeInt:lbStage1 forKey:@"lbStage1"];
    [coder encodeInt:lbStage2 forKey:@"lbStage2"];
    [coder encodeInt:lbStage3 forKey:@"lbStage3"];
    [coder encodeInt:lbStage4 forKey:@"lbStage4"];
    [coder encodeInt:lbStage5 forKey:@"lbStage5"];
    
    [coder encodeObject:achievementStage1 forKey:@"achievementStage1"];
    [coder encodeObject:achievementStage2 forKey:@"achievementStage2"];
    [coder encodeObject:achievementStage3 forKey:@"achievementStage3"];
    [coder encodeObject:achievementStage4 forKey:@"achievementStage4"];
    [coder encodeObject:achievementStage5 forKey:@"achievementStage5"];
}

@end
