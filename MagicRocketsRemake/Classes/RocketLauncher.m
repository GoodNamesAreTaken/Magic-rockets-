//
//  RocketLauncher.m
//  MagicRocketsRemake
//
//  Created by SwinX on 18.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RocketLauncher.h"
#import "Game.h"
#import "Configuration.h"
#import "GameScene.h"

@implementation RocketLauncher

+(RocketLauncher*)rocketLauncher {
	return [[self alloc] initWithTextureName:@"RocketLauncher.png" andPositionAtField:[[Game sharedGame].bonusManager getFreePosition]];
}

-(CCFiniteTimeAction*)performAnimation {
	idx = 0;
	Rocket* rocket = nil;
	do {
		idx = arc4random()%ROWS;
		rocket = [[Game sharedGame].rocketManager rocketAt:idx];
	} while (!rocket);
	return [CCMoveTo actionWithDuration:BONUS_FLY_TIME position:[[GameScene scene] getScreenPositionForRocket:rocket at:idx]];
}

-(void)effect {
	[[Game sharedGame].rocketManager launchRocketAt:idx];
}

@end
