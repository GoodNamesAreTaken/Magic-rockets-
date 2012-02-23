//
//  Game.h
//  MagicRocketsRemake
//
//  Created by Troll ololo on 20.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Field.h"
#import "SparkManager.h"
#import "RocketManager.h"
#import "BonusManager.h"
#import "FireworkManager.h"
#import "UpgradeManager.h"
#import "GameMode.h"

#import "Types.h"

/**
 The abstarction that represents game itself.
 Contains methods to prepare game at launch, save and load game, switch between scenes.
 
 Also contents managers that with whom different parts of game interact.
 */
@interface Game : NSObject {
	
	GameState state;
	
	GameMode* mode;
	Field* field;
	SparkManager* sparkManager;
	RocketManager* rocketManager;
	BonusManager* bonusManager;
	UpgradeManager* upgradeManager;
	
}
@property(readonly) GameState state;
@property(readonly) GameMode* mode;
@property(readonly) Field* field;
@property(readonly) SparkManager* sparkManager;
@property(readonly) RocketManager* rocketManager;
@property(readonly) BonusManager* bonusManager;
@property(readonly) FireworkManager* fireworkManager;
@property(readonly) UpgradeManager* upgradeManager;

+(Game*)sharedGame;

-(void)newGame:(GameState)_state;

/**
 Continue a game
 */
-(void)continueGame;

/**
 Exit to main menu from game
 */
-(void)mainMenu;

/**
 Goes to scoreboard
 */
-(void)scores;

/**
 End game and exit to main menu
 */
-(void)gameOver;

/**
 Save game
 */
-(void)saveGame;

/**
 Load game
 */
-(void)loadGame;

/**
 Performs field. fires, rockets and bonuses initialisation.
 */
-(void)prepareGame;

@end
