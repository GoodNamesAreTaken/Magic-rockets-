//
//  Game.m
//  MagicRocketsRemake
//
//  Created by Troll ololo on 20.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Game.h"
#import "Configuration.h"
#import "GameScene.h"
#import "MainMenu.h"
#import "SimpleAudioEngine.h"
#import "LevelBasedBonusManager.h"
#import "AppDelegate.h"

static Game* instance = nil;

@interface Game(Private)

-(void)gameFinished;
-(void)createMode;

@end

@implementation Game

@synthesize state;
@synthesize mode;
@synthesize field;
@synthesize sparkManager;
@synthesize rocketManager;
@synthesize bonusManager;
@synthesize fireworkManager;
@synthesize upgradeManager;

+(Game*)sharedGame {
	@synchronized(self) {
		if (instance == nil) {
			instance = [[Game alloc] init];
		}
	}
	return instance;
}

-(id)init {
	if ((self = [super init])) {
		field = [[Field alloc] init];
		bonusManager = [[BonusManager alloc] init];
		sparkManager = [[SparkManager alloc] init];
		rocketManager = [[RocketManager alloc] init];
		fireworkManager = [[FireworkManager alloc] init];
		upgradeManager = [[UpgradeManager alloc] init];
	}
	return self;
}

-(void)newGame:(GameState)_state {
	
	state = _state;
	
	[[NSUserDefaults standardUserDefaults] setInteger:state forKey:@"GameState"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[self createMode];
	[self prepareGame]; 
	[mode handleEvent:@selector(newGame)];
	[[SimpleAudioEngine sharedEngine] playEffect:@"Ready.caf"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:SCENE_TRANSITION_TIME scene:[GameScene scene]]];
	
}

-(void)continueGame {
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:SCENE_TRANSITION_TIME scene:[GameScene scene]]];
}

-(void)mainMenu {
	[[CCDirector sharedDirector] pushScene:[CCTransitionFade transitionWithDuration:SCENE_TRANSITION_TIME scene:[MainMenu scene]]];
}

-(void)scores {
	AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
	[appDelegate.rootViewController openLeaderboards];
}

-(void)gameOver {
	state = GSNotPlaying;
	[[NSUserDefaults standardUserDefaults] setInteger:state forKey:@"GameState"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[[GameScene scene] hideMenu];
	[[GameScene scene] gameOver];
	[self performSelector:@selector(gameFinished) withObject:self afterDelay:GAME_OVER_DELAY];
}

//Saving and loading game
-(void)saveGame {	
	[[NSUserDefaults standardUserDefaults] setInteger:state forKey:@"GameState"];	
	[mode handleEvent:@selector(saveGame)];
	[rocketManager saveGame];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)loadGame {
	
	state = [[NSUserDefaults standardUserDefaults] integerForKey:@"GameState"];
	
	if (state != GSNotPlaying) {
		[self createMode];
		[mode handleEvent:@selector(loadGame)];
		[rocketManager loadGame];
	}

}
//Private methods

-(void)gameFinished {
	[self mainMenu];
	[[GameScene scene] showMenu];
}

-(void)createMode {
	[mode removeAllComponents];
	[mode release];
	switch (state) {
		case GSPlayingClassic:
			mode = [[GameMode classicMode] retain];
			break;
		case GSPlayingTimeAttack:
			mode = [[GameMode timeAttackMode] retain];
			break;
		case GSPlayingMatchBox:
			mode = [[GameMode matchboxMode] retain];
			break;
		case GSNotPlaying:
			break;
		default:
			@throw [NSException exceptionWithName:@"Unknown mode exception" reason:@"Unknown game mode loaded from NSUserDefaults" userInfo:nil];
			break;
	}
	[[GameScene scene] createInterfaceFromElements:[mode getIntefraceComponents]];
}

-(void)prepareGame {
	[bonusManager killAllBonuses];
	[field killField];
	[field createField];
	[rocketManager killRockets];
	[rocketManager reset];
	[rocketManager createRockets];
	//[[GameScene scene] createFires];
	[[GameScene scene] enable];
}

//Memory management
-(void)dealloc {
	[mode release];
	[upgradeManager release];
	[bonusManager release];
	[fireworkManager release];
	[field release];
	[sparkManager release];
	[rocketManager release];
	[super dealloc];
}

@end
