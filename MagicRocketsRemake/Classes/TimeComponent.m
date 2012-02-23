//
//  TimeComponent.m
//  MagicRocketsRemake
//
//  Created by SwinX on 13.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TimeComponent.h"
#import "Game.h"
#import "GameScene.h"
#import "GameMode.h"

@interface TimeComponent(Private)

-(void)setTimeRemaining:(ccTime)value;

@end


@implementation TimeComponent

-(void)timeElapsed:(NSNumber*)dt {
	[self setTimeRemaining:timeRemaining-[dt floatValue]];
} 

-(void)timeChangedBy:(NSNumber *)dt {
	[self setTimeRemaining:timeRemaining+[dt floatValue]];
}

-(void)newGame {
	hurryUpShown = NO;
	[self setTimeRemaining:TIME_PER_LEVEL];
}

-(void)levelUp {
	[self setTimeRemaining:TIME_PER_LEVEL];
}

-(void)nextLevel {
	[self setTimeRemaining:TIME_PER_LEVEL];
}

-(void)setTimeRemaining:(ccTime)value {
	timeRemaining = MIN(value, TIME_PER_LEVEL);
	
	if (timeRemaining < HURRY_UP_NOTIFICATION_TIME && !hurryUpShown) {
		[[GameScene scene] hurryUp];
		hurryUpShown = YES;
	} else if (timeRemaining < 0) {
		[owner handleEvent:@selector(gameOver)];
	}
	
	[owner handleEvent:@selector(timeUpdated)];
}

-(void)saveGame {
	[[NSUserDefaults standardUserDefaults] setFloat:timeRemaining forKey:@"TimeRemaining"];	
}

-(void)loadGame {
	timeRemaining = [[NSUserDefaults standardUserDefaults] floatForKey:@"TimeRemaining"];
}

-(float)timeRemainingPart {
	return timeRemaining/TIME_PER_LEVEL;
}

@end
