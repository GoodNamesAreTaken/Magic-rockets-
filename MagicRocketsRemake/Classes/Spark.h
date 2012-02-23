//
//  Spark.h
//  MagicRocketsRemake
//
//  Created by SwinX on 25.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <OpenAL/al.h>
#import "cocos2d.h"
#import "SparkPathBuilder.h"

@interface Spark : NSObject {
	CCParticleSystemQuad* fire;
	SparkPathBuilder* walker;	
	
	Brick* currentBrick;
	BOOL moving;
	
	ALuint soundSource;
}

@property(assign) Brick* currentBrick;
@property(readonly) BOOL moving;

@property ALuint soundSource;

/**
 Creates a spark
 */
+(Spark*)createAt:(Brick*)brick MovingTo:(Brick*)neighbour Walker:(SparkPathBuilder*)newWalker;

/**
 Initialises a spark
 */
-(id)initWithStartBrick:(Brick*)start andFinishBrick:(Brick*)finish andWalker:(SparkPathBuilder*)newWalker;

/**
 Move spark to a brick
 */
-(void)moveTo:(Brick*)brick;

/**
 Kill spark
 */
-(void)die;

@end
