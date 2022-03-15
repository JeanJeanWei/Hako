//
//  RatingManager.m
//  Copyright (c) Ice Whale. All rights reserved.
//

#import "RatingManager.h"
#import "LanguageManager.h"

@implementation RatingManager

+ (RatingManager*)instance
{
    static RatingManager* instance = nil;
    
    if (!instance)
    {
        instance = [RatingManager new];
    }
    
    return instance;
}

- (void)manageRating
{
    if ([RatingManager.instance shouldShowRateApp])
    {
        [RatingManager.instance performSelector:@selector(showRateApp) withObject:nil afterDelay:3.0];
    }
}

- (BOOL)shouldShowRateApp
{
    BOOL show = NO;
    
#ifdef APPLICATION_RATINGS_FORCE

    return YES;
    
#endif

    NSString* bundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    NSString* ratedAppVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"RateManager.ratedAppVersion"];

    if (ratedAppVersion == nil || ![ratedAppVersion isEqualToString:bundleVersion])
    {
        NSDate* lastRateShownDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"RateManager.lastRateShownDate"];
    
        if (!lastRateShownDate)
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"RateManager.lastRateShownDate"];
        }
        else
        {
            NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:lastRateShownDate];
            
            if (interval > RATING_DAY_DELAY * 86400)
            {
                show = YES;
            }
        }
    }
    
    return show;
}

- (void)showRateApp
{
    if (!rating)
    {
        rating = YES;
        
        NSString* message = [NSString stringWithFormat:NSLocalizedString(@"MSG_RATING_DESCRIPTION", nil) , LanguageManager.applicationName];
        
        NSString* cancelTitle = [LanguageManager stringForString:@"No, thanks"];
        
        //NSString* rate = [LanguageManager stringForString:@"Rate"];
        NSString* rateTitle = [NSString stringWithFormat:NSLocalizedString(@"Rate", nil), LanguageManager.applicationName];
        
        NSString* remindTitle = [LanguageManager stringForString:@"Remind me later"];
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:rateTitle, remindTitle, nil];
        
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    rating = NO;
    
    NSString* bundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
                    
    switch (buttonIndex)
    {
        case 0:
            {
                [[NSUserDefaults standardUserDefaults] setObject:bundleVersion forKey:@"RateManager.ratedAppVersion"];
            }
            break;
        case 1:
            {
                [[NSUserDefaults standardUserDefaults] setObject:bundleVersion forKey:@"RateManager.ratedAppVersion"];

                NSString* templateReviewURL = @"itms://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=APP_ID";

                NSString* reviewURL = [templateReviewURL stringByReplacingOccurrencesOfString:@"APP_ID" withString:ITUNES_APP_ID];
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURL]];
            }
            break;
        case 2:
            {
                [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"RateManager.lastRateShownDate"];
            }
            break;
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
