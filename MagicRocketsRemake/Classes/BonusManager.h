//
//  BonusManager.h
//  MagicRocketsRemake
//
//  Created by SwinX on 30.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Configuration.h"
#import "Bonus.h"
#import "Brick.h" 
#import "BonusCreationConitions.h"

/**
 A class that creates, holds and observes bonuses.
 This manager designed in way that it only operates with bonuses that are stand still. Flying bonuses (when spawn or falling with bricks) are not processed
 */

@interface BonusManager : NSObject {
	Bonus* bonuses[ROWS][COLS];
	BonusCreationConitions* conditions;
	NSMutableArray* coinsToThrow;
}

@property(readonly) BOOL canCreateBonus;

/**
 Try to create random bonus considering level number and bonus creation probability
 */
-(void)tryToCreateBonus;

/**
 Create bonus 
 */
-(void)createBonus:(Bonus*)bonus;

/**
 Launch rockets event needed to spawn coins 
 @param amoun rockets launched amount
 */
-(void)launchedRockets:(int)amount;

/**
 Get free position for bonus at field
 */
-(PositionAtField)getFreePosition;

/**
 Adds bonus to processing by bonus manager
 */
-(void)addBonus:(Bonus*)bonus;

/**
 Returns bonus at position
 */
-(Bonus*)bonusAtPosition:(PositionAtField)pos;

/**
 Removes bonus from processing by manager
 */
-(void)removeBonus:(Bonus*)bonus;

/**
 Totally kills all bouses 
 */
-(void)killAllBonuses;

/**
 Kills all bonuses around some position
 */
-(void)explodeBonusesWithEpicenter:(PositionAtField)epicenter;

/**
 Collects bonus at position
 */
-(void)collectBonusAt:(PositionAtField)pos;

-(void)collectAllBonuses;

-(void)throwCoins;

-(void)updateBonuses:(ccTime)dt;

/**
 Make bonus fall from start position to target position
 */
-(void)bonusAtPosition:(PositionAtField)pos mustFallTo:(PositionAtField)target;

@end
