//
//  Notification.m
//  MagicRocketsRemake
//
//  Created by SwinX on 15.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Notification.h"

@interface Notification(Private)

-(void)animationFinished;

@end


@implementation Notification

+(Notification*)notificationWithText:(NSString*)text position:(CGPoint)pos andSize:(float)size {
	return [[[self alloc] initWithText:text andPosition:pos andSize:size] autorelease];
}

-(id)initWithText:(NSString*)text andPosition:(CGPoint)pos andSize:(float)size {
	if ((self = [super initWithString:text fontName:@"Marker Felt" fontSize:size])) {
		self.position = pos;
		[self addAnimations];
	}
	return self;
}

-(void)addAnimations {
	//must be redefined
}

-(void)animationFinished {
	[self.parent removeChild:self cleanup:YES];
}

@end
