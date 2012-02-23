//
//  Firework.m
//  MagicRocketsRemake
//
//  Created by Inf on 31.08.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Firework.h"
#import "FireworkManager.h"


@implementation Firework

@synthesize soundSource;

+(id)fireworkWithFile:(NSString*)file manager:(FireworkManager*)fireworkManager {
	return [[[self alloc] initWithFile:file manager:fireworkManager] autorelease];
}
-(id)initWithFile:(NSString *)plistFile manager:(FireworkManager*)fireworkManager {
	if ((self = [super initWithFile:plistFile])) {
		manager = fireworkManager;
		self.autoRemoveOnFinish = YES;
	}
	return self;
}

-(void)onExit {
	[super onExit];
	[manager fireworkDestroyed:self];
}

@end
