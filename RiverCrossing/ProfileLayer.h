//
//  ProfileLayer.h
//  puzzle
//
//  Created by Jean-Jean Wei on 13-03-04.
//  Copyright (c) 2013 Ice Whale Inc. All rights reserved.
//

#import "CCLayer.h"

@interface ProfileLayer : CCLayer
{
    CCLabelTTF *fbLabel;
    CCLabelTTF *fbName;
    CCLabelTTF *fbLogBtn;
    CCLabelTTF *gameCenterLabel;
    CCLabelTTF *gameCenterName;
    CGSize screenSize;
}
@end
