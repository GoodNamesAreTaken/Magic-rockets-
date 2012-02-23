//
//  DoubleScore.m
//  MagicRocketsRemake
//
//  Created by SwinX on 15.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DoubleScore.h"
#import "Game.h"
#import "GameScene.h"
#import "ViewPointsComponent.h"

@implementation DoubleScore

+(DoubleScore*)doubleScore {
	return [[[self alloc] initWithTextureName:@"DoubleScore.png" andPositionAtField:[[Game sharedGame].bonusManager getFreePosition]] autorelease];
}

-(CCFiniteTimeAction*)performAnimation {
	ViewPointsComponent* component = [[Game sharedGame].mode componentNamed:@"ViewPoints"];
	return [CCMoveTo actionWithDuration:BONUS_FLY_TIME position:[component pointsPosition]];
}

-(void)effect {
	[[Game sharedGame].mode handleEvent:@selector(doubleScore)];
}

@end
