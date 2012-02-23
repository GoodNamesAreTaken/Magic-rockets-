//
//  Spark.m
//  Rocket
//
//  Created by Inf on 09.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import	"Game.h"
#import "SparkPathBuilder.h"
#import "SparkManager.h"
#import "SimpleAudioEngine.h"

@interface SparkManager(Private)

-(void)sparksFinishedMoving;

@end


@implementation SparkManager

-(id)init {
	if ((self = [super init])) {
		sparks = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void)moveSparkFrom:(Brick*)startBrick to:(Brick*)finishBrick withWalker:(SparkPathBuilder*)walker {
	
	BOOL foundSpark = NO;
	for (Spark* spark in sparks) {
		if (spark.currentBrick == startBrick && !spark.moving) {
			[spark moveTo:finishBrick];
			foundSpark = YES;
			break;
		}
	}
	
	if (!foundSpark) {
		Spark* spark = [Spark createAt:startBrick MovingTo:finishBrick Walker:walker];
		spark.soundSource = [[SimpleAudioEngine sharedEngine] playEffect:@"Fuse.caf"];
		[self addSpark:spark];
	}
}

-(void)clearSparks {
	
	NSArray* copy = [sparks copy];
	
	for (Spark* spark in copy) {
		if (!spark.moving) {
			[[SimpleAudioEngine sharedEngine] stopEffect:spark.soundSource];
			[spark die];
			[self removeSpark:spark];
		}
	}
	
	[copy release];
}

-(void)addSpark:(Spark *)spark {
	[sparks addObject:spark]; 
}

-(void)removeSpark:(Spark *)spark {
	[sparks removeObject:spark];
	if (!self.sparksAtField) {
		[self sparksFinishedMoving];
	}
}

-(void)sparksFinishedMoving {
	[[Game sharedGame].field clearField];
	[[Game sharedGame].mode handleEvent:@selector(sparksGone)];
}

-(BOOL)sparksAtField {
	return sparks.count != 0;
}

-(void)dealloc {
	[sparks release];
	[super dealloc];
}

@end
