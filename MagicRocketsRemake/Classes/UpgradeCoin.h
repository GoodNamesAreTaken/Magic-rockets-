//
//  UpgradeCoin.h
//  MagicRocketsRemake
//
//  Created by SwinX on 09.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Rocket.h"


/**
 An upgrading coin. 
 
 When created, coin flies to rocket UPGRADE_COST times, every time decreasing player's coins count
 */
@interface UpgradeCoin : CCSprite {
	int fliesRemaining;
	CGPoint rocketPosition;
}

/**
 Creates coin
 @param rocket rocket that coin must upgrade
 */
+(UpgradeCoin*)createMovingTo:(Rocket*)rocket;

/**
 Initialises coin
 */
-(id)initWithRocket:(Rocket*)rocket;

@end
