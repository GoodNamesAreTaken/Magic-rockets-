//
//  BonusCreationConitions.m
//  MagicRocketsRemake
//
//  Created by SwinX on 25.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BonusCreationConitions.h"
#import "Game.h"

#import "Gem.h"
#import "Bomb.h"
#import "TimeBoost.h"
#import "BonusCollector.h"
#import "DoubleScore.h"
#import "RocketLauncher.h"

#import "Configuration.h"

#import "LevelNumberComponent.h"

@interface BonusCreationConitions(Private)

-(BOOL)canCreateGem;
-(BOOL)canCreateBomb;
-(BOOL)canCreateClock;
-(BOOL)canCreateBonusCollector;
-(BOOL)canCreateDoubleScore;
-(BOOL)canCreateRocketLauncher;

-(int)levelNumber;

@end


@implementation BonusCreationConitions


-(BOOL)canCreateBonus:(Bonus*)bonus {
		
	if ([bonus isKindOfClass:[Gem class]]) {
		return [self canCreateGem];
	} else if ([bonus isKindOfClass:[Bomb class]]) {
		return [self canCreateBomb];
	} else if ([bonus isKindOfClass:[TimeBoost class]]) {
		return [self canCreateClock];
	} else if ([bonus isKindOfClass:[BonusCollector class]]) {
		return [self canCreateBonusCollector];
	} else if ([bonus isKindOfClass:[DoubleScore class]]) {
		return [self canCreateDoubleScore];
	} else if ([bonus isKindOfClass:[RocketLauncher class]]) {
		return [self canCreateRocketLauncher];
	} else {
		@throw [NSException exceptionWithName:@"Unknown bonus exception" reason:@"Getting avalibility of unknown bonus" userInfo:nil];
	}
	
}

-(BOOL)canCreateCoins {
	if ([Game sharedGame].state == GSPlayingTimeAttack) {
		return NO;
	}
	return YES;
}

-(BOOL)canCreateGem {
	int level = [self levelNumber];
	switch ([Game sharedGame].state) {
		case GSPlayingClassic:
		case GSPlayingMatchBox:
			return level >= GEM_AVALIABLE_LEVEL;
		case GSPlayingTimeAttack:
			return YES;
		default:
			return NO;
	}
}

-(BOOL)canCreateBomb {
	int level = [self levelNumber];
	switch ([Game sharedGame].state) {
		case GSPlayingClassic:
		case GSPlayingMatchBox:
			return level >= BOMB_AVALIABLE_LEVEL;
		case GSPlayingTimeAttack:
			return YES;
		default:
			return NO; 
	}
}

-(BOOL)canCreateClock {
	int level = [self levelNumber];
	switch ([Game sharedGame].state) {
		case GSPlayingClassic:
			return level >= CLOCK_AVALIABLE_LEVEL;
		case GSPlayingMatchBox:
			return NO;
		case GSPlayingTimeAttack:
			return YES;
		default:
			return NO; 
	}
}

-(BOOL)canCreateBonusCollector {
	return YES;
}

-(BOOL)canCreateDoubleScore {
	return YES;
}

-(BOOL)canCreateRocketLauncher {
	return YES;
}

-(int)levelNumber {
	LevelNumberComponent* component = [[Game sharedGame].mode componentNamed:@"LevelNumber"];
	return component.levelNumber;
}

@end
