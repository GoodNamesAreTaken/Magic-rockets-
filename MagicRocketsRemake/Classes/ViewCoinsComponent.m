//
//  ViewCoinsComponent.m
//  MagicRocketsRemake
//
//  Created by SwinX on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewCoinsComponent.h"
#import "GameMode.h"
#import "CoinsComponent.h" 
#import "Positions.h"
#import "Skin.h"

@implementation ViewCoinsComponent

-(id)init {
	if ((self = [super init])) {
		coin = [CCSprite spriteWithTexture:[[Skin currentSkin] textureFor:@"Interface/MenuCoin.png"]];
		coin.position = ccp(COINS_X_POSITION, [CCDirector sharedDirector].winSize.height - coin.contentSize.height/2);
		[view addChild:coin];
		
		coinsCount = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:DEFAULT_INTERFACE_LABEL_FONT_SIZE];
		coinsCount.anchorPoint = ccp(0, 1);
		coinsCount.position = ccp(coin.position.x + coin.contentSize.width/2, [CCDirector sharedDirector].winSize.height - coin.contentSize.height/2);
		[view addChild:coinsCount];
	}
	return self;
}

-(void)coinsUpdated {
	CoinsComponent* component = [owner componentNamed:@"Coins"];
	if (component) {
		[coinsCount setString:[NSString stringWithFormat:@"%d", component.coins]];
	}
}

-(CGPoint)getUpgradeCoinPosition {
	return coin.position;
}

@end
