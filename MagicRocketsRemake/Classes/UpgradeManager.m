//
//  UpgradeManager.m
//  MagicRocketsRemake
//
//  Created by SwinX on 09.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UpgradeManager.h"
#import "Game.h"
#import "GameScene.h"
#import "CoinsComponent.h"

@interface UpgradeManager(Private)

-(void)continueGame;
-(void)findRocketsToUpgrade;
-(void)createCoins;
-(void)createCoinMovinTo:(Rocket*)rocket;
-(void)reset;

@end


@implementation UpgradeManager

-(id)init {
	if ((self = [super init])) {
		coins = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void)upgradeRockets {
	rocketsToUpgrade = MIN(((CoinsComponent*)[[Game sharedGame].mode componentNamed:@"Coins"]).coins/UPGRADE_COST, ROWS);
	if (!rocketsToUpgrade) {
		[self continueGame];
	} else {
		[[GameScene scene] upgrading];
		[self findRocketsToUpgrade];
		[self createCoins];
	}
}

-(void)findRocketsToUpgrade {
	[self reset];
	int remainsToFind = rocketsToUpgrade;
	do {
		int slot = arc4random() % ROWS;
		if (!selectedRockets[slot]) {
			selectedRockets[slot] = YES;
			remainsToFind--;
		}
	} while (remainsToFind > 0);
}

-(void)createCoins {
	for (int i=0; i<ROWS; i++) {
		if (selectedRockets[i]) {
			[self createCoinMovinTo:[[Game sharedGame].rocketManager rocketAt:i]];
		}
	}
}

-(void)createCoinMovinTo:(Rocket*)rocket {
	UpgradeCoin* coin = [UpgradeCoin createMovingTo:rocket];
	[[GameScene scene] addNodeToFrontLayer:coin];
	[coins addObject:coin];
}

-(void)reset {
	for (int i=0; i<ROWS; i++) {
		selectedRockets[i] = NO;
	}
}

-(void)coinFinishFlying:(UpgradeCoin*)coin {
	[coins removeObject:coin];
	[[GameScene scene] removeNodeFromFrontLayer:coin];
	if (coins.count == 0) {
		for (int i=0; i<ROWS; i++) {
			if (selectedRockets[i]) {
				[[Game sharedGame].rocketManager upgradeRocket:i];
			}
		}
		[self reset];
		[self continueGame];
	}
}

-(void)continueGame {
	[[Game sharedGame].field createField];
	[[Game sharedGame].bonusManager throwCoins];
	[[GameScene scene] enable];
	
}

@end
