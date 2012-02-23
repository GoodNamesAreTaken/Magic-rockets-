//
//  UpgradeCoin.m
//  MagicRocketsRemake
//
//  Created by SwinX on 09.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UpgradeCoin.h"
#import "GameScene.h"
#import "Game.h"
#import "Configuration.h"
#import "CollectBonusEffect.h"
#import "SimpleAudioEngine.h"

#import "Skin.h"

@interface UpgradeCoin(Private)

-(void)flyToRocket;

@end


@implementation UpgradeCoin

+(UpgradeCoin*)createMovingTo:(Rocket*)rocket {
	return [[[self alloc] initWithRocket:rocket] autorelease];
}
-(id)initWithRocket:(Rocket*)rocket {
	
	if ((self = [super initWithTexture:[[Skin currentSkin] textureFor:@"Interface/UpgradeCoin.png"]])) {
		fliesRemaining = UPGRADE_COST;
		rocketPosition = rocket.position;
		[self flyToRocket];
	}
	
	return self;
	
}

-(void)flyToRocket {
	fliesRemaining--;
	[[Game sharedGame].mode handleEvent:@selector(coinsChangedBy:) withObject:[NSNumber numberWithInt:-1]];
	self.position = [[GameScene scene] getScreenPositionForUpgradeCoin];
	[self runAction:[CCSequence actions:[CCMoveTo actionWithDuration:UPGRADE_COIN_FLY_TIME position:rocketPosition],
					 [CCCallFunc actionWithTarget:self selector:@selector(finishFlying)],
					 nil]
	 ];
}

-(void)finishFlying {
	[[SimpleAudioEngine sharedEngine] playEffect:@"Coin.caf"];
	[[GameScene scene] addNodeToFrontLayer:[CollectBonusEffect effectAt:self.position]];
	if (fliesRemaining) {
		[self flyToRocket];
	} else {
		[[Game sharedGame].upgradeManager coinFinishFlying:self];
	}
}

@end
