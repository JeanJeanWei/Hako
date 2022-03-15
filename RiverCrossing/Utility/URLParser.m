//
//  URLParser.m
//  Copyright (c) Ice Whale. All rights reserved.
//

#import "URLParser.h"

@implementation URLParser

+ (NSURL*)urlForBaseURL:(NSString*)baseURL andParameters:(NSDictionary*)parameters
{
    NSMutableString* url = [NSMutableString string];
    
    [url appendString:baseURL];
    
    BOOL first = YES;
    
    for (NSString* name in parameters)
    {
        if (first)
        {
            [url appendString:@"?"];
        }
        else
        {
            [url appendString:@"&"];
        }
        
        [url appendString:name];
        
        [url appendString:@"="];
        
        NSString* value = [parameters objectForKey:name];
        
        NSString* encodedValue = [URLParser stringByEncodingURLFormat:value];
        
        [url appendString:encodedValue];
        
        first = NO;
    }
    
    return [NSURL URLWithString:url];
}

+ (NSString*)extractURLParameter:(NSString*)name fromURL:(NSURL*)url 
{
    NSString* urlParameter = nil;
    
    NSArray* components = nil;
    
    if ([url.absoluteString rangeOfString:@"?"].location != NSNotFound)
    {
        components = [url.absoluteString componentsSeparatedByString:@"?"];
    }
    else if ([url.absoluteString rangeOfString:@"#"].location != NSNotFound)
    {
        components = [url.absoluteString componentsSeparatedByString:@"#"];
    }
    
    if (components.count > 0)
    {
        NSString* parameters = [components objectAtIndex:(components.count - 1)];
        
        NSArray* ampComponents = [parameters componentsSeparatedByString:@"&"];
        
        for (NSString* keypair in ampComponents)
        {
            NSArray* values = [keypair componentsSeparatedByString:@"="];
            
            if (values.count == 2)
            {
                NSString* parameterName = [values objectAtIndex:0];
                NSString* encodedParameterValue = [values objectAtIndex:1];
                
                if ([parameterName isEqual:name])
                {
                    urlParameter = [URLParser stringByDecodingURLFormat:encodedParameterValue];
                    
                    break;
                }
            }
        }
    }
    
    return urlParameter;
}

+ (NSString*)stringByDecodingURLFormat:(NSString*)string
{
    NSString* result = [string stringByReplacingOccurrencesOfString:@"+" withString:@" "];
	
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
    return result;
}

+ (NSString*)stringByEncodingURLFormat:(NSString*)string
{
    NSMutableString* encodedString = [NSMutableString string];
    
    char const* chars = [string cStringUsingEncoding:NSASCIIStringEncoding];
    
    for (int i = 0; i < string.length; i++)
    {
        char c = chars[i];
        
        if (('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z') || ('0' <= c && c <= '9'))
        {
            [encodedString appendFormat:@"%c", c];
        }
        else if (c == ' ')
        {
            [encodedString appendString:@"+"];
        }
        else
        {
            [encodedString appendFormat:@"%%%x%x", c / 16, c % 16];
        }
    }
    
    return encodedString;
}

@end
