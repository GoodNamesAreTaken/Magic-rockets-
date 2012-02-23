//
//  MatchesCounterComponent.m
//  MagicRocketsRemake
//
//  Created by SwinX on 14.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MatchesCounterComponent.h"
#import "GameMode.h"
#import "Configuration.h"
#import "RocketsCounterComponent.h"
#import "Game.h"

@interface MatchesCounterComponent(Private)

-(void)setMatchesRemaining:(int)value;
-(void)reset;

@end


@implementation MatchesCounterComponent

@synthesize matchesRemaining;

-(void)newGame {
	[self reset];
}

-(void)saveGame {
	[[NSUserDefaults standardUserDefaults] setInteger:matchesRemaining forKey:@"MatchesRemaining"];
}

-(void)loadGame {
	matchesRemaining = [[NSUserDefaults standardUserDefaults] integerForKey:@"MatchesRemaining"];
}

-(void)levelUp {
	[self reset];
}

-(void)fuseBurned {
	matchesRemaining--;
	[self setMatchesRemaining:matchesRemaining];
}

-(void)sparksGone {

	RocketsCounterComponent* counter = [[Game sharedGame].mode componentNamed:@"RocketsCounter"];
	
	if (matchesRemaining <= 0 && [Game sharedGame].rocketManager.launchedRocketsCount < counter.rocketsRemaining) {
		[owner handleEvent:@selector(gameOver)];
	}
}

-(void)setMatchesRemaining:(int)value {
	matchesRemaining = MAX(value,0);
	[owner handleEvent:@selector(matchesCountUpdated)];
}

-(void)reset {
	[self setMatchesRemaining:MATCHES_PER_LEVEL];
}

@end
