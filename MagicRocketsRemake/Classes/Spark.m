//
//  Spark.m
//  MagicRocketsRemake
//
//  Created by SwinX on 25.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Spark.h"
#import "SparkManager.h"
#import "GameScene.h"
#import "Game.h"
#import "Skin.h"

#define SPARK_MOVE_TIME 0.15

@interface Spark(Private)

-(void)finishMoving;

@end


@implementation Spark

@synthesize currentBrick;
@synthesize moving;
@synthesize soundSource;

+(Spark*)createAt:(Brick*)brick MovingTo:(Brick*)neighbour Walker:(SparkPathBuilder*)newWalker {
	return [[[self alloc] initWithStartBrick:brick andFinishBrick:neighbour andWalker:newWalker] autorelease];
}

-(id)initWithStartBrick:(Brick*)start andFinishBrick:(Brick*)finish andWalker:(SparkPathBuilder*)newWalker {
	if ([super init]) {		
		walker = [newWalker retain];
		moving = NO;
		
		fire = [[CCParticleSun alloc] init]; 
		fire.texture = [[Skin currentSkin] textureFor:@"Particles/SparkParticles/Particle.png"];
		fire.emissionRate = 50;
		
		fire.position = start.position;
		
		[[GameScene scene] addNodeToFrontLayer:fire];
		[self moveTo:finish];
		
	}
	return self;
}

-(void)moveTo:(Brick*)brick {
	moving = YES;
	currentBrick = brick;
	[fire runAction:[CCSequence actions:
					  [CCMoveTo actionWithDuration:SPARK_MOVE_TIME position:brick.position], 
					  [CCCallFunc actionWithTarget:self selector:@selector(finishMoving)], 
					  nil]
	 ];
	
}

-(void)finishMoving {
	moving = NO;
	[walker nextBrick];	
}

-(void)die {
	[fire runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.3f scale:0.0f],
					  [CCCallFunc actionWithTarget:self selector:@selector(removeFromField)],
					  nil
					  ]
	 ];
}

-(void)removeFromField {
	[[GameScene scene]removeNodeFromFrontLayer:fire];
}

-(void)dealloc {
	[fire release];
	[walker release];
	[super dealloc];
}


@end
