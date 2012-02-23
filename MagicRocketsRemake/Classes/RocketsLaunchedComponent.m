//
//  RocketsComponent.m
//  MagicRocketsRemake
//
//  Created by SwinX on 14.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RocketsLaunchedComponent.h"
#import "GameScene.h"
#import "GameMode.h"

@interface RocketsLaunchedComponent(Private)

-(void)setRocketsLaunched:(int)value;

@end

@implementation RocketsLaunchedComponent

@synthesize rocketsLaunched;

-(void)newGame {
	[self setRocketsLaunched:0];
}

-(void)saveGame {
	[[NSUserDefaults standardUserDefaults] setInteger:rocketsLaunched forKey:@"RocketsLaunched"];
}

-(void)loadGame {
	rocketsLaunched = [[NSUserDefaults standardUserDefaults] integerForKey:@"RocketsLaunched"];
}

-(void)rocketLaunched:(Rocket *)rocket {
	rocketsLaunched++;
	[self setRocketsLaunched:rocketsLaunched];
}

-(void)setRocketsLaunched:(int)value {
	rocketsLaunched = value;
	[owner handleEvent:@selector(rocketsCountUpdated)];
}

@end
