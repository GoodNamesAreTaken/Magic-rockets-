//
//  ClassicMode.m
//  MagicRocketsRemake
//
//  Created by SwinX on 11.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameMode.h"
#import "GameScene.h"
#import "ModeComponent.h"
#import "PointsComponent.h"
#import "CoinsComponent.h"
#import "LevelNumberComponent.h"
#import "TimeComponent.h"
#import "FinisherComponent.h"
#import "RocketsLaunchedComponent.h"
#import "RocketsCounterComponent.h"
#import "MatchesCounterComponent.h"

#import "ViewComponent.h"
#import "ViewPointsComponent.h"
#import "ViewCoinsComponent.h"
#import "ViewMatchesComponent.h"
#import "ViewTimeComponent.h"
#import "ViewLevelNumberComponent.h"
#import "ViewRocketsCountComponent.h"
#import "ScoreReporterComponent.h"
#import "BonusManagerInterface.h"

#import "AppDelegate.h"

@implementation GameMode

+(id)gameMode {
	return [[[self alloc] init] autorelease];
}

+(id)classicMode {
	GameMode* mode = [GameMode gameMode];
	
	[mode addComponent:[PointsComponent component] named:@"Points"];
	[mode addComponent:[CoinsComponent component] named:@"Coins"];
	[mode addComponent:[LevelNumberComponent component] named:@"LevelNumber"];
	[mode addComponent:[TimeComponent component] named:@"Time"];
	[mode addComponent:[FinisherComponent component] named:@"Finisher"];
	[mode addComponent:[RocketsCounterComponent component] named:@"RocketsCounter"];
	[mode addComponent:[BonusManagerInterface component] named:@"BonusManagerInterface"];
	
	[mode addComponent:[ViewPointsComponent component] named:@"ViewPoints"] ;
	[mode addComponent:[ViewCoinsComponent component] named:@"ViewCoins"];
	[mode addComponent:[ViewLevelNumberComponent component] named:@"ViewLevelNumber"];
	[mode addComponent:[ViewTimeComponent component] named:@"ViewTime"];
	[mode addComponent:[ViewRocketsCountComponent component] named:@"ViewRocketsCount"];
	
	if ([AppDelegate gameCenterAvaliable]) {
		[mode addComponent:[ScoreReporterComponent componentWithCategory:@"uk.co.soulteam.magicRockets2.classic"] named:@"ScoreReporter"];
	}
	
	return mode;
}

+(id)timeAttackMode {
	GameMode* mode = [GameMode gameMode];
	
	[mode addComponent:[PointsComponent component] named:@"Points"];
	[mode addComponent:[TimeComponent component] named:@"Time"];
	[mode addComponent:[FinisherComponent component] named:@"Finisher"];
	[mode addComponent:[RocketsLaunchedComponent component] named:@"RocketsLaunched"];
	[mode addComponent:[BonusManagerInterface component] named:@"BonusManagerInterface"];
	
	[mode addComponent:[ViewPointsComponent component] named:@"ViewPoints"];
	[mode addComponent:[ViewTimeComponent component] named:@"ViewTime"];
	[mode addComponent:[ViewRocketsCountComponent component] named:@"ViewRocketsCount"];
	
	if ([AppDelegate gameCenterAvaliable]) {
		[mode addComponent:[ScoreReporterComponent componentWithCategory:@"uk.co.soulteam.magicRockets2.timeattack"] named:@"ScoreReporter"];
	}
	return mode;
}

+(id)matchboxMode {
	GameMode* mode = [GameMode gameMode];
	
	[mode addComponent:[PointsComponent component] named:@"Points"];
	[mode addComponent:[CoinsComponent component] named:@"Coins"];
	[mode addComponent:[FinisherComponent component] named:@"Finisher"];
	[mode addComponent:[LevelNumberComponent component] named:@"LevelNumber"];
	[mode addComponent:[RocketsCounterComponent component] named:@"RocketsCounter"];
	[mode addComponent:[MatchesCounterComponent component] named:@"Matches"];
	[mode addComponent:[BonusManagerInterface component] named:@"BonusManagerInterface"];
	
	[mode addComponent:[ViewPointsComponent component] named:@"ViewPoints"];
	[mode addComponent:[ViewMatchesComponent component] named:@"ViewMatches"];
	[mode addComponent:[ViewLevelNumberComponent component] named:@"ViewLevelNumber"];
	[mode addComponent:[ViewRocketsCountComponent component] named:@"ViewRocketsCount"];
	
	if ([AppDelegate gameCenterAvaliable]) {
		[mode addComponent:[ScoreReporterComponent componentWithCategory:@"uk.co.soulteam.magicRockets2.matchbox"] named:@"ScoreReporter"];
	}
	return mode;
}

-(id)init {
	if ( (self = [super init]) ) {
		components = [[NSMutableDictionary alloc] init];
	}
	return self;
}

-(void)addComponent:(ModeComponent*)component named:(NSString*)name {
	[components setObject:component forKey:name];
	component.owner = self;
}

-(id)componentNamed:(NSString*)name {
	return [components objectForKey:name];
}


-(void)removeComponentByName:(NSString*)name {
	[components removeObjectForKey:name];
}

-(void)handleEvent:(SEL)message {
	for (ModeComponent* comp in [components allValues]) {
		if ([comp respondsToSelector:message]) {
			[comp performSelector:message];
		}
	}
}

-(void)handleEvent:(SEL)message withObject:(id)object {
	for (ModeComponent* comp in [components allValues]) {
		if ([comp respondsToSelector:message]) {
			[comp performSelector:message withObject:object];
		}
	}
}

-(void)removeAllComponents {
	[self handleEvent:@selector(componentRemoved)];
	[components removeAllObjects];
}	

-(NSArray*)getIntefraceComponents {
	NSMutableArray* array = [NSMutableArray array];
	for (id component in [components allValues]) {
		if ([component isKindOfClass:[ViewComponent class]]) {
			[array addObject:[(ViewComponent*)component getView]];
		}
	}
	return array;
}

-(void)dealloc {
	[components release];
	[super dealloc];
}


@end
