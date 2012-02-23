//
//  RocketsCounterComponent.m
//  MagicRocketsRemake
//
//  Created by SwinX on 14.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RocketsCounterComponent.h"
#import "Configuration.h"
#import "GameScene.h"
#import "GameMode.h"

@interface RocketsCounterComponent(Private)

-(void)setRocketsRemaining:(int)value;

@end


@implementation RocketsCounterComponent

@synthesize rocketsRemaining;

-(void)newGame {
	finished = NO;
	rocketsToLaunch = ROCKETS_TO_LAUNCH_AT_FIRST_LEVEL;
	[self setRocketsRemaining:rocketsToLaunch];
}

-(void)loadGame {
	rocketsToLaunch = [[NSUserDefaults standardUserDefaults] integerForKey:@"RocketsToLaunch"];
	[self setRocketsRemaining:[[NSUserDefaults standardUserDefaults] integerForKey:@"RocketsRemaining"]]; 
}

-(void)saveGame {
	[[NSUserDefaults standardUserDefaults] setInteger:rocketsRemaining forKey:@"RocketsRemaining"];
	[[NSUserDefaults standardUserDefaults] setInteger:rocketsToLaunch forKey:@"RocketsToLaunch"];
}

-(void)levelUp {
	rocketsToLaunch++;
	[self setRocketsRemaining:rocketsToLaunch];
	finished = NO;
}

-(void)setRocketsRemaining:(int)value {
	rocketsRemaining = MAX(value, 0);
	[owner handleEvent:@selector(rocketsCountUpdated)];
}

-(void)rocketLaunched:(Rocket*)rocket {
	rocketsRemaining--;
	[self setRocketsRemaining:rocketsRemaining];
	if (rocketsRemaining <= 0 && !finished) {
		[[GameScene scene] levelUp];
		[owner handleEvent:@selector(levelEnded)];
		finished = YES;
	}
}

@end
