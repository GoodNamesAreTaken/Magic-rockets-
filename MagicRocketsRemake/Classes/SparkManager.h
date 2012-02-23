//
//  Spark.h
//  Rocket
//
//  Created by Inf on 09.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import "cocos2d.h"
#import "SparkPathBuilder.h"
#import "Brick.h"
#import "Spark.h"

/**
 The spark manager that manages sparks. Creates and stores sparks
 */
@interface SparkManager : NSObject {
	NSMutableArray* sparks;
}

@property(readonly) BOOL sparksAtField;

/**
 Moves spark from one brick to another
 @param walker a path builder that builds path now
 */
-(void)moveSparkFrom:(Brick*)startBrick to:(Brick*)finishBrick withWalker:(SparkPathBuilder*)walker;

/**
 Adds a spark for processing
 */
-(void)addSpark:(Spark*)spark;

/**
 Removes spark from processing
 */
-(void)removeSpark:(Spark*)spark;

/**
 Removes stopped sparks
 */
-(void)clearSparks; 

@end
