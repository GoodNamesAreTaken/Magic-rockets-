//
//  LevelComponent.m
//  MagicRocketsRemake
//
//  Created by SwinX on 13.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LevelNumberComponent.h"
#import "GameScene.h"
#import "GameMode.h"

@interface LevelNumberComponent(Private)

-(void)setLevelNumber:(int)value;

@end


@implementation LevelNumberComponent

@synthesize levelNumber;

-(void)levelUp {
	levelNumber++;
	[self setLevelNumber:levelNumber];
}

-(void)newGame {
	[self setLevelNumber:1];
}

-(void)saveGame {
	[[NSUserDefaults standardUserDefaults] setInteger:levelNumber forKey:@"Level"];
}

-(void)loadGame {
	[self setLevelNumber:[[NSUserDefaults standardUserDefaults] integerForKey:@"Level"]];
}

-(void)setLevelNumber:(int)value {
	levelNumber = MAX(value, 1);
	[owner handleEvent:@selector(levelNumberUpdated)];
}

@end
