//
//  UpgradeManager.h
//  MagicRocketsRemake
//
//  Created by SwinX on 09.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Configuration.h"
#import "UpgradeCoin.h"

/**
 A manager that is resposible for upgrades. Creates and obseves upgrade coins
 */
@interface UpgradeManager : NSObject {
	NSMutableArray* coins;
	
	int rocketsToUpgrade;
	int wavesRemaining;
	BOOL selectedRockets[ROWS];
}

-(void)upgradeRockets;

/**
 Event triggered when coin finished upgrading a rocket
 If upgrade finished checked here
 */
-(void)coinFinishFlying:(UpgradeCoin*)coin;

@end
