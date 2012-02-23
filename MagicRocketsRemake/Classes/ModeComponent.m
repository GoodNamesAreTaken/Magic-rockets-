//
//  ModeComponent.m
//  MagicRocketsRemake
//
//  Created by SwinX on 12.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModeComponent.h"

@implementation ModeComponent

@synthesize owner;

+(id)component {
	return [[[self alloc] init] autorelease];
}

-(void)componentAdded {
	
}

-(void)componentRemoved {
	
}

@end
