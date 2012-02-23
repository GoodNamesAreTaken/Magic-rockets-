//
//  LevelBasedBonusManager.m
//  MagicRocketsRemake
//
//  Created by SwinX on 18.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LevelBasedBonusManager.h"
#import "Coin.h"
#import "Gem.h"
#import "TimeBoost.h"
#import "Bomb.h"
#import "Configuration.h"
#import "Types.h"
#import "GameScene.h"
#import "LevelNumberComponent.h"

#import "Game.h"

@implementation LevelBasedBonusManager

-(BOOL)canCreateBonus:(Bonus *)bounus {
	int levelNumber = ((LevelNumberComponent*)[[Game sharedGame].mode componentNamed:@"LevelNumber"]).levelNumber;
	if ([bounus isKindOfClass:[Gem class]]) {
		return levelNumber >= GEM_AVALIABLE_LEVEL;
	} else if ([bounus isKindOfClass:[Bomb class]]) {
		return levelNumber >= BOMB_AVALIABLE_LEVEL;
	} else if ([bounus isKindOfClass:[TimeBoost class]]) {
		return levelNumber >= CLOCK_AVALIABLE_LEVEL;
	} else {
		NSLog(@"Wrong bonus type");
		return NO; 
	}

}

@end
