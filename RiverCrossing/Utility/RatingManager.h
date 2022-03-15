//
//  RatingManager.h
//  Copyright (c) Ice Whale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RatingManager : NSObject<UIAlertViewDelegate>
{
    BOOL rating;
}

+ (RatingManager*)instance;

- (void)manageRating;

@end
