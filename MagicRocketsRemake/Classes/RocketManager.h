//
//  RocketManager.h
//  MagicRocketsRemake
//
//  Created by SwinX on 30.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Rocket.h"
#import "Field.h"


/**
 A manager responsible for rockets. Creates and launches rockets
 */
@interface RocketManager : NSObject {
	Rocket* rockets[ROWS];
	int rocketLevels[ROWS];
	
	int launchedRocketsCount;
}

@property(readonly) int launchedRocketsCount;

/**
 Creates rockets accrding rocket levels
 */
-(void)createRockets;

/**
 Kills all rockets
 */
-(void)killRockets;

/**
 Sets all rocket levels to 1
 */
-(void)reset;

/**
 Save rocket levels
 */
-(void)saveGame;

/**
 Load rocket levels
 */
-(void)loadGame;

/**
 Get rocket at row
 */
-(Rocket*)rocketAt:(int)row;

/**
 Creates new rocket at row
 */
-(void)newRocketAt:(int)row;

/**
 Launches rocket at row
 */
-(void)launchRocketAt:(int)row;

/**
 Increases rocket level and recreates rocket
 */
-(void)upgradeRocket:(int)rocket;

/**
 Event triggered by rocket when its exploded
 */
-(void)rocketExploded:(Rocket*)rocket;

@end
