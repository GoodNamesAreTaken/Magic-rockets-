//
//  PointsComponent.m
//  MagicRocketsRemake
//
//  Created by SwinX on 12.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PointsComponent.h"
#import "GameScene.h"
#import "GameMode.h"
#import "cocos2d.h"

@interface PointsComponent(Private)

-(void)setPoints:(int)value;

@end

@implementation PointsComponent

@synthesize points;

-(id)init {
	if ((self = [super init])) {
		multiplier = 1;
		doubleScoreRemainingTime = 0;
	}
	return self;
}

-(void)pointsChangedBy:(NSNumber*)value {
	[[CCActionManager sharedManager] removeAllActionsFromTarget:self];
	self.points = lastPoints;
	float valueToAdd = [value floatValue]*multiplier;
	id action = [CCActionTween actionWithDuration:0.8f key:@"points" from:self.points to:self.points+valueToAdd];
	[[CCActionManager sharedManager] addAction:action target:self paused:NO];
	lastPoints = self.points + valueToAdd;
}

-(void)doubleScore {
	multiplier = 2;
	doubleScoreRemainingTime = DOUBLE_SCORE_TIME;
}

-(void)timeElapsed:(NSNumber *)dt {
	if (doubleScoreRemainingTime > 0) {
		doubleScoreRemainingTime -= [dt floatValue];
		if (doubleScoreRemainingTime <= 0) {
			multiplier = 1;
			[owner handleEvent:@selector(doubleScoreFinished)];
		}
	}
}

-(void)levelUp {
	multiplier = 1;
	doubleScoreRemainingTime = 0;
}

-(void)newGame {
	multiplier = 1;
	doubleScoreRemainingTime = 0;
	[self setPoints:0];
}	

-(void)saveGame {
	[[NSUserDefaults standardUserDefaults] setInteger:points forKey:@"Points"];
	//[[NSUserDefaults standardUserDefaults] setFloat:doubleScoreRemainingTime forKey:@"DoubleScoreRemainingTime"];
	[[NSUserDefaults standardUserDefaults] setInteger:lastPoints forKey:@"LastPoints"];
	[[NSUserDefaults standardUserDefaults] setInteger:multiplier forKey:@"Multiplier"];
}

-(void)loadGame {
	[self setPoints:[[NSUserDefaults standardUserDefaults] integerForKey:@"Points"]]; 
	lastPoints = [[NSUserDefaults standardUserDefaults] integerForKey:@"LastPoints"];
	multiplier = [[NSUserDefaults standardUserDefaults] integerForKey:@"Multiplier"];
	if (multiplier > 1) {
		//doubleScoreRemainingTime = [[NSUserDefaults standardUserDefaults] floatForKey:@"DoubleScoreRemainingTime"];
		[owner handleEvent:@selector(doubleScore)];
	}
}

-(void)setPoints:(int)value { 
	points = MAX(value, 0);
	[owner handleEvent:@selector(pointsUpdated)];
}

@end
