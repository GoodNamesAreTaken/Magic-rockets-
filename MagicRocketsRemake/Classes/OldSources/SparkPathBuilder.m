//
//  SparkWalker.m
//  Rocket
//
//  Created by Inf on 18.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Brick.h"
#import "Game.h"
#import "SparkPathBuilder.h"
#import "SparkManager.h"

@implementation SparkPathBuilder

-(void)brickAddedToPath:(Brick*)brick {
	[brick setState:BSDead];
	[[Game sharedGame].bonusManager collectBonusAt:*brick.positionAtField];
}

-(void)nextBrick {
	[super nextBrick];
	[[Game sharedGame].sparkManager clearSparks];
}
	
-(void)processNeighbour:(Brick*)negihbour of:(Brick*)brick {
	[[Game sharedGame].sparkManager moveSparkFrom:brick to:negihbour withWalker:self];
}

-(void)pathComplete {
}

-(void) startFromBrick:(Brick*)brick {
	[super startFromBrick:brick];
}

-(void)dealloc {
	[super dealloc];
}

@end
