//
//  RocketManager.m
//  MagicRocketsRemake
//
//  Created by SwinX on 30.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RocketManager.h"
#import "FireworkManager.h"
#import "Game.h"
#import "GameScene.h"

@implementation RocketManager
@synthesize launchedRocketsCount;

-(id)init {
	if ((self = [super init])) {
		[self reset];
	}
	return self;
}

-(void)createRockets {
	for (int i=0; i<ROWS; i++) {
		[self newRocketAt:i];
	}
}

-(void)killRockets {
	for (int i=0; i<ROWS; i++) {
		[[GameScene scene] removeNodeFromFrontLayer:rockets[i]];
	}
}

-(void)reset {
	for (int i=0; i<ROWS; i++) {
		rocketLevels[i] = 1;
	}
	launchedRocketsCount = 0;
}

-(void)saveGame {
	for (int i=0; i<ROWS; i++) {
		[[NSUserDefaults standardUserDefaults] setInteger:rocketLevels[i] forKey:[NSString stringWithFormat:@"R%d", i]];
	}
}

-(void)loadGame {
	for (int i=0; i<ROWS; i++) {
		[[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"R%d", i]];
	}
}

-(Rocket*)rocketAt:(int)row {
	return rockets[row];
}

-(void)newRocketAt:(int)row {
	rockets[row] = [Rocket rocketWithLevel:rocketLevels[row] AtRow:row manager:self];
	[[GameScene scene] addNodeToFrontLayer:rockets[row]];
}

-(void)launchRocketAt:(int)row {
	
	if (!rockets[row]) {
		return;			//Т.к ракета, которую пытается запустить искра, может быть уже запущена бонусом. Это может привести к тому, что счетчик запущенных ракет  собьется.
	}
	
	[[Game sharedGame].mode handleEvent:@selector(pointsChangedBy:) withObject:[NSNumber numberWithInt:POINTS_PER_ROCKET * rocketLevels[row]]];
	[[Game sharedGame].mode handleEvent:@selector(rocketLaunched:) withObject:rockets[row]];
	[[GameScene scene] launchedRocket:rockets[row] atRow:row forPoints:POINTS_PER_ROCKET * rocketLevels[row]];
	launchedRocketsCount++;
	[rockets[row] launch];
	rockets[row] = nil;
}

-(void)rocketExploded:(Rocket*)rocket {
	[[Game sharedGame].fireworkManager launchFirework];
	[self newRocketAt:rocket.row];
	launchedRocketsCount--;
	if (launchedRocketsCount == 0) {
		[[Game sharedGame].mode handleEvent:@selector(rocketsGone)];
	}
}

-(void)upgradeRocket:(int)rocket {
	rocketLevels[rocket]++;
	[[GameScene scene] removeNodeFromFrontLayer:rockets[rocket]];
	[self newRocketAt:rocket];
}

-(void)dealloc {
	[self killRockets];
	[super dealloc];
}

@end
