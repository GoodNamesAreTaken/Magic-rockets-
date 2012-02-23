//
//  BonusManagerInterface.m
//  MagicRocketsRemake
//
//  Created by SwinX on 25.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BonusManagerInterface.h"
#import "Game.h"

@implementation BonusManagerInterface

-(void)timeElapsed:(NSNumber *)dt {
	[[Game sharedGame].bonusManager updateBonuses:[dt floatValue]];
}

@end
