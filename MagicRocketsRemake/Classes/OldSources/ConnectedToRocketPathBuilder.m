//
//  ConnectedToRocketPathBuilder.m
//  Rocket
//
//  Created by Inf on 18.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ConnectedToRocketPathBuilder.h"


@implementation ConnectedToRocketPathBuilder
@synthesize fireBrick;

-(void)brickAddedToPath:(Brick*)brick {
	brick.state = BSConnectedToRocket;
	if (fireBrick == nil && brick.positionAtField->col == 0 && [brick hasOutlet:BOLeftOutlet]) {
		fireBrick = [brick retain];
	}
}

-(BOOL)canGoThrought:(Brick*)brick {
	return brick.state != BSDead && brick.state != BSConnectedToRocket;
}

-(void) dealloc {
	[fireBrick release];
	[super dealloc];
}
@end
