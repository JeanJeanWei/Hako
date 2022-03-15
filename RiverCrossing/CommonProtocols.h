//
//  Header.h
//  ro3
//
//  Created by JJ WEI on 12-06-27.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

typedef enum 
{
    kTileTag1,
    kTileTag2,
    kTileTag3,
    kTileTag4,
    kTileTag5,
    kTileTag6,
    kTileTag7,
    kTileTag8,
    kTileTag9,
    kTileTag10,
    kTileTag11,
    kTileTag12,
    kTileTag13,
    kTileTag14,
    kTile2x2Tag,
    kVikingTag = 101,
    kHeroTag,
    kCaptainTag,
    kAccessaryTag,
    kCharactorTag,
    kNumOfGameObjectTags
} GameObjectTag;

typedef enum 
{
    kBreathingAnim, 
    kWalkingAnim,
    kCrouchingAnim, 
    kIdlingAnim,
    kPreIdlingAnim,
    kNumOfCharacterAnimeTypes
} CharacterAnimTypes;


// for moving direction
typedef enum {
    none,
    up,
    down,
    left,
    right

} GameObjDirection;

// Tile helper
typedef enum {
    k2x2=0,
    k1x1=1,
    k1x2=2,
    k2x1=3
    
} TileType;

// Tile helper
typedef enum {
    k1x1_1=101,
    k1x1_2,
    k1x1_3,
    k1x2_1=201,
    k1x2_2,
    k2x1_1=301
    
} AccessaryType;


typedef enum {
    kStateIdle,
    kStateBreathing,
    kStateSelected,
    kStateWalking,
    kStateCrouching,
    kStatePreIdle
    
} CharacterStates; // 1

typedef enum {
    kObjectTypeNone,
    kPowerUpTypeHealth,
    kPowerUpTypeMallet,
    kEnemyTypeRadarDish,
    kEnemyTypeSpaceCargoShip,
    kEnemyTypeAlienRobot,
    kEnemyTypePhaser,
    kBodyType,
    kSkullType,
    kRockType,
    kMeteorType,
    kFrozenBodyType,
    kIceType,
    kLongBlockType,
    kCartType,
    kSpikesType,
    kDiggerType,
    kGroundType
} GameObjectType;

@protocol GameplayLayerDelegate
-(void)createObjectOfType:(GameObjectType)objectType
               withHealth:(int)initialHealth
               atLocation:(CGPoint)spawnLocation
               withZValue:(int)ZValue;

@end

