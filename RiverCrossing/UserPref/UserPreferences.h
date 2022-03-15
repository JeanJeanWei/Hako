//
//  UserPreferences.h
//  hako
//
//  Created by Jean-Jean Wei on 13-01-19.
//
//
// this class define user data model, don't change data model unless the app has implemented a feature to recover user data for upgrade or other instance
#import <Foundation/Foundation.h>

@interface UserPreferences : NSObject <NSCoding>
{
    NSMutableArray *stage1;
    NSMutableArray *stage2;
    NSMutableArray *stage3;
    NSMutableArray *stage4;
    NSMutableArray *stage5;
    int currentStage;     //user
    BOOL isMusicOn;  //music
    BOOL isSoundEffectOn;   // soundEffect
    int lbStage1;
    int lbStage2;
    int lbStage3;
    int lbStage4;
    int lbStage5;
    
    NSMutableArray *achievementStage1;
    NSMutableArray *achievementStage2;
    NSMutableArray *achievementStage3;
    NSMutableArray *achievementStage4;
    NSMutableArray *achievementStage5;
}

@property (strong) NSMutableArray *stage1;
@property (strong) NSMutableArray *stage2;
@property (strong) NSMutableArray *stage3;
@property (strong) NSMutableArray *stage4;
@property (strong) NSMutableArray *stage5;
@property (assign) int currentStage;
@property (assign) BOOL isMusicOn;
@property (assign) BOOL isSoundEffectOn;
@property (assign) int lbStage1;
@property (assign) int lbStage2;
@property (assign) int lbStage3;
@property (assign) int lbStage4;
@property (assign) int lbStage5;
@property (strong) NSMutableArray *achievementStage1;
@property (strong) NSMutableArray *achievementStage2;
@property (strong) NSMutableArray *achievementStage3;
@property (strong) NSMutableArray *achievementStage4;
@property (strong) NSMutableArray *achievementStage5;

@end
