//
//  LanguageManager.h
//  Copyright (c) Ice Whale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageManager : NSObject

+ (NSString*)applicationName;

// loads a localised string value for a given phrase
+ (NSString*)stringForString:(NSString*)string;

/* loads a localised string for a message key in the format MSG_****** from the
    strings localisation file
*/
+ (NSString*)stringForKey:(NSString*)key;

@end
