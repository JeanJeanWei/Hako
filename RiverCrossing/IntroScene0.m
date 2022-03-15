//
//  IntroScene.m
//  SpaceViking
//
#import "IntroScene0.h"


@implementation IntroScene0
-(id)init {
	self = [super init];
	if (self != nil) {
		IntroLayer0 *myLayer = [IntroLayer0 node];
		[self addChild:myLayer];
		
	}
	return self;
}
@end
