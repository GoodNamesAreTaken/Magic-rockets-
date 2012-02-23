//
//  FinisherComponent.m
//  MagicRocketsRemake
//
//  Created by SwinX on 13.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FinisherComponent.h"
#import "Game.h"
#import "GameScene.h"
#import "GameMode.h"

@interface FinisherComponent(Private)

-(void)checkForLevelUp;
-(void)reset;

@end

@implementation FinisherComponent

@synthesize levelFinished;

-(void)newGame {
	[self reset];
}

-(void)levelUp {
	[self reset];
	[[Game sharedGame] saveGame];
	[[Game sharedGame].bonusManager killAllBonuses];
	[[Game sharedGame].field killField];
	[[Game sharedGame].upgradeManager upgradeRockets];
}

-(void)gameOver {
	gameOver = YES;
	[self levelEnded];
	[[Game sharedGame] gameOver];
}

-(void)levelEnded {
	[[GameScene scene] disable];
	levelFinished = YES;
	[self checkForLevelUp];
}

-(void)rocketLaunched:(Rocket *)rocket {
	rocketsGone = NO;
}

-(void)fireworkExploded:(Firework *)firework {
	fireworksGone = NO;
}

-(void)fuseBurned {
	sparksGone = NO;
}

-(void)sparksGone {
	sparksGone = YES;
	[self checkForLevelUp];
}

-(void)rocketsGone {
	rocketsGone = YES;
	[self checkForLevelUp];
}

-(void)fireworksGone {
	fireworksGone = YES;
	[self checkForLevelUp];
}

//Private methods

-(void)checkForLevelUp { 
	if (!gameOver) {
		if (sparksGone && rocketsGone && fireworksGone && levelFinished) {
			[owner handleEvent:@selector(levelUp)];
		}
	}
}

-(void)reset {
	sparksGone = YES;
	rocketsGone = YES;
	fireworksGone = YES;
	levelFinished = NO;
	gameOver = NO;
}

@end
