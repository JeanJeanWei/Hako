//
//  LanguageManager.m
//  Copyright (c) Ice Whale. All rights reserved.
//

#import "LanguageManager.h"

@implementation LanguageManager

+ (NSString*)applicationName
{
    NSDictionary* dictionary = [[NSBundle mainBundle] localizedInfoDictionary];
    
    if (!dictionary)
    {  
        dictionary =  [[NSBundle mainBundle] infoDictionary];
    }
    
    //return [dictionary objectForKey:@"CFBundleDisplayName"];
    return @"Break Out";
}

+ (NSString*)stringForString:(NSString*)string
{
    return NSLocalizedString(string, string);
}

+ (NSString*)stringForKey:(NSString*)key
{
    return [LanguageManager stringForString:key];
}

@end
