//
//  ViewPointsComponent.m
//  MagicRocketsRemake
//
//  Created by SwinX on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewComponent.h"


@implementation ViewComponent

-(id)init {
	if ((self = [super init])) {
		view = [[CCNode alloc] init];
	}
	return self;
}

-(CCNode*)getView {
	return view;
}

-(void)componentRemoved {
	[view.parent removeChild:view cleanup:YES];
}

-(void)dealloc {
	[view release];
	[super dealloc];
}

@end
