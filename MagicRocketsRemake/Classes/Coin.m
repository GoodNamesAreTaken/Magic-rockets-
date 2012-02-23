//
//  Coin.m
//  MagicRocketsRemake
//
//  Created by SwinX on 30.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Coin.h"
#import "Game.h"
#import "GameScene.h"
#import "ViewCoinsComponent.h"

@implementation Coin

+(Coin*)createWithNominal:(CoinNominal)coinNominal {
	return [[[self alloc] initWithNominal:coinNominal] autorelease];
}

-(id)initWithNominal:(CoinNominal)coinNominal {
	if ((self = [super initWithTextureName:[NSString stringWithFormat:@"Coin%d.png", coinNominal] andPositionAtField:[[Game sharedGame].bonusManager getFreePosition]])) {
		nominal = coinNominal;
	}	
	return self;
}

-(CCFiniteTimeAction*)performAnimation {
	ViewCoinsComponent* component = [[Game sharedGame].mode componentNamed:@"ViewCoins"];
	return [CCMoveTo actionWithDuration:BONUS_FLY_TIME position:[component getUpgradeCoinPosition]];
}

-(void)effect {
	[[Game sharedGame].mode handleEvent:@selector(coinsChangedBy:) withObject:[NSNumber numberWithInt:nominal]];
}

-(void)dealloc {
	[super dealloc];
}

@end
