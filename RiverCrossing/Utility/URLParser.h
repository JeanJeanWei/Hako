//
//  URLParser.h
//  Copyright (c) Ice Whale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLParser : NSObject

// create a GET url using the specified parameters
+ (NSURL*)urlForBaseURL:(NSString*)baseURL andParameters:(NSDictionary*)parameters;

// extract a parameter value from a URL
+ (NSString*)extractURLParameter:(NSString*)name fromURL:(NSURL*)url;

// URL encode a string
+ (NSString*)stringByDecodingURLFormat:(NSString*)URLString;

// URL decode a string
+ (NSString*)stringByEncodingURLFormat:(NSString*)string;

@end
