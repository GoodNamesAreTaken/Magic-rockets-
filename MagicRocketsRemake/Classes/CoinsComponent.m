//
//  CoinsComponent.m
//  MagicRocketsRemake
//
//  Created by SwinX on 12.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CoinsComponent.h"
#import "GameScene.h"
#import "GameMode.h"

@interface CoinsComponent(Private) 

-(void)setCoins:(int)value;

@end


@implementation CoinsComponent

@synthesize coins;

-(void)coinsChangedBy:(NSNumber*)value {
	[self setCoins:coins+[value intValue]];
}

-(void)newGame {
	[self setCoins:0];
}

-(void)saveGame {
	[[NSUserDefaults standardUserDefaults] setInteger:coins forKey:@"Coins"];
}

-(void)loadGame {
	[self setCoins:[[NSUserDefaults standardUserDefaults] integerForKey:@"Coins"]]; 
}

-(void)setCoins:(int)value {
	coins = MAX(value, 0);
	[owner handleEvent:@selector(coinsUpdated)];
}

@end
