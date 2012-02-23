//
//  CollectAllBonuses.m
//  MagicRocketsRemake
//
//  Created by SwinX on 10.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BonusCollector.h"
#import "Game.h"
#import "GameScene.h"

@implementation BonusCollector

+(BonusCollector*)bonusCollector {
	return [[[self alloc] initWithTextureName:@"Magnet.png" andPositionAtField:[[Game sharedGame].bonusManager getFreePosition]] autorelease];
}

-(CCFiniteTimeAction*)performAnimation {
	return [CCFiniteTimeAction action];
}

-(void)effect {
	[[Game sharedGame].bonusManager collectAllBonuses];
}

@end
