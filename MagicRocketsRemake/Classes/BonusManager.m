//
//  BonusManager.m
//  MagicRocketsRemake
//
//  Created by SwinX on 30.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "GameScene.h"
#import "Game.h"
#import "BonusManager.h"
#import "Configuration.h"
#import "Coin.h"
#import "Gem.h"
#import "Bomb.h"
#import "TimeBoost.h"
#import "BonusCollector.h"
#import "DoubleScore.h"
#import "RocketLauncher.h"
#import "FinisherComponent.h"


@implementation BonusManager

@synthesize canCreateBonus;

-(id)init {
	if ((self = [super init])) {
		conditions = [[BonusCreationConitions alloc] init];
		coinsToThrow = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void)tryToCreateBonus {
	
	if ((arc4random()%BONUS_CREATION_PROBABILITY)) {
		return;
	}
	
	if (!self.canCreateBonus) {
		return;
	}
	
	int rand = arc4random() % BONUSES_AMOUNT;
	
	Bonus* bonus;
	
	switch (rand) {
		case 0:
			bonus = [TimeBoost clock];
			break;
			
		case 1:
			bonus = [Bomb bomb]; 
			break;
			
		case 2:
			bonus = [Gem gem];
			break;
			
		case 3:
			bonus = [BonusCollector bonusCollector];
			break;
			
		case 4:
			bonus = [DoubleScore doubleScore];
			break;
			
		case 5:
			bonus = [RocketLauncher rocketLauncher];
			break;
	}
	
	if ([conditions canCreateBonus:bonus]) {
		[self createBonus:bonus];
	}
}

-(void)createBonus:(Bonus*)bonus {
	[[GameScene scene] addSpriteToField:bonus];
	[bonus.parent reorderChild:bonus z:BONUS_LAYER];
}

-(void)launchedRockets:(int)amount {
	
	if ([conditions canCreateCoins]) {
		switch (amount) {
			case 2:
				[coinsToThrow addObject:[Coin createWithNominal:CNTwo]];
				break;
			case 3:
				[coinsToThrow addObject:[Coin createWithNominal:CNFive]];
				[coinsToThrow addObject:[Coin createWithNominal:CNOne]];
				break;
			case 4:
				[coinsToThrow addObject:[Coin createWithNominal:CNTen]];
				[coinsToThrow addObject:[Coin createWithNominal:CNTwo]];
				break;
			case 5:
				[coinsToThrow addObject:[Coin createWithNominal:CNTen]];
				[coinsToThrow addObject:[Coin createWithNominal:CNTen]];
				break;
			case 6:
				[coinsToThrow addObject:[Coin createWithNominal:CNTen]];
				[coinsToThrow addObject:[Coin createWithNominal:CNTen]];
				[coinsToThrow addObject:[Coin createWithNominal:CNTwo]];
				break;
			case 7:
				[coinsToThrow addObject:[Coin createWithNominal:CNTen]];
				[coinsToThrow addObject:[Coin createWithNominal:CNTen]];
				[coinsToThrow addObject:[Coin createWithNominal:CNTwo]];
				[coinsToThrow addObject:[Coin createWithNominal:CNFive]];
				break;
			case 8:
				[coinsToThrow addObject:[Coin createWithNominal:CNTen]];
				[coinsToThrow addObject:[Coin createWithNominal:CNTen]];
				[coinsToThrow addObject:[Coin createWithNominal:CNTen]];
				break;
			case 9:
				[coinsToThrow addObject:[Coin createWithNominal:CNTen]];
				[coinsToThrow addObject:[Coin createWithNominal:CNTen]];
				[coinsToThrow addObject:[Coin createWithNominal:CNTen]];
				[coinsToThrow addObject:[Coin createWithNominal:CNTen]];
				break;
		}
		if (self.canCreateBonus) {
			[self throwCoins];
		}
		
	}
	
}

-(PositionAtField)getFreePosition {
	PositionAtField pos;
	do {
		pos.row = arc4random()%ROWS;
		pos.col = arc4random()%COLS;
	} while (bonuses[pos.row][pos.col]);
	return pos;
}

-(void)addBonus:(Bonus*)bonus {
	PositionAtField pos = *bonus.positionAtField;
	if (bonuses[pos.row][pos.col]) { //в случае, если бонус упал на место другого бонуса
		[self collectBonusAt:pos];
	}
	bonuses[pos.row][pos.col] = bonus;
}

-(Bonus*)bonusAtPosition:(PositionAtField)pos {
	if (pos.row >= ROWS || pos.col >= COLS || pos.row < 0 || pos.col < 0) {
		return nil; 
	} else {
		return bonuses[pos.row][pos.col];
	}
}

-(void)removeBonus:(Bonus *)bonus {
	bonuses[bonus.positionAtField->row][bonus.positionAtField->col] = nil;
}

-(void)killAllBonuses {
	for (int i=0; i<ROWS; i++) {
		for (int j=0; j<COLS; j++) {
			if (bonuses[i][j]) {
				[[GameScene scene] removeSpriteFromField:bonuses[i][j]];
				bonuses[i][j] = nil;
			}
		}
	}
}

-(void)explodeBonusesWithEpicenter:(PositionAtField)epicenter {

	for (int i=epicenter.row-1; i<=epicenter.row+1; i++) {
		for (int j=epicenter.col-1; j<=epicenter.col+1; j++) {
			
			Bonus* bonus = [self bonusAtPosition:posAtField(i, j)];
			
			if (bonus) {
				[bonus explodeWithEpicenter:epicenter];
				bonuses[bonus.positionAtField->row][bonus.positionAtField->col] = nil;
				
			}
		}
	}

}

-(void)collectBonusAt:(PositionAtField)pos {
	Bonus* bonus = bonuses[pos.row][pos.col];
	bonuses[pos.row][pos.col] = nil;
	[bonus collect];
}

-(void)collectAllBonuses {
	for (int i=0; i<ROWS; i++) {
		for (int j=0; j<COLS; j++) {
			[self collectBonusAt:posAtField(i, j)];
		}
	}
}

-(void)throwCoins {
	for (Coin* coin in coinsToThrow) {
		[[GameScene scene] addSpriteToField:coin];
		[coin.parent reorderChild:coin z:BONUS_LAYER];
	}
	[coinsToThrow removeAllObjects];
}

-(void)updateBonuses:(ccTime)dt { 
	for (int i=0; i<ROWS; i++) {
		for (int j=0; j<COLS; j++) {
			[bonuses[i][j] update:dt];
		}
	}
}

-(void)bonusAtPosition:(PositionAtField)pos mustFallTo:(PositionAtField)target {
	if (bonuses[pos.row][pos.col]) {
		bonuses[pos.row][pos.col].positionAtField->row = target.row;
		bonuses[pos.row][pos.col].positionAtField->col = target.col;
		[bonuses[pos.row][pos.col] fallTo:[[GameScene scene] getScreenPositionFor:target]];
		bonuses[pos.row][pos.col] = nil;
	}
}

-(BOOL)canCreateBonus {
	return !((FinisherComponent*)[[Game sharedGame].mode componentNamed:@"Finisher"]).levelFinished;
}

-(void)dealloc {
	[coinsToThrow release];
	[conditions release];
	[super dealloc];
}

@end
