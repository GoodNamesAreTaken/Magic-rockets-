//
//  PathWalker.m
//  Rocket
//
//  Created by Inf on 18.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import "Brick.h"
#import "Game.h"
#import "PathBuilder.h"

@implementation PathBuilder
@dynamic finished;

-(id) init {
	if ([super init]) {
		walkedBricks = [[NSMutableArray alloc] init];
		bricksToWalk = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void) startFromBrick:(Brick*)brick {
	[bricksToWalk addObject:brick];
	[self nextBrick];
}

-(void)buildStartingFrom:(Brick*)brick {
	[bricksToWalk addObject:brick];
	while (bricksToWalk.count > 0) {
		[self nextBrick];
	}
}

-(void) nextBrick {
	if (self.finished) {
		return;
	}
	
	Brick* brick = [[bricksToWalk objectAtIndex:0] retain];
	[bricksToWalk removeObjectAtIndex:0];
	
	if (![self canGoThrought:brick]) {
		if (self.finished) {
			[brick release];
			[self pathComplete];
		}
		return;
	}
	
	
	[self brickAddedToPath:brick];	
	[walkedBricks addObject:brick];
	
	Brick* rightNeighbour = [[Game sharedGame].field brickAtRow:brick.positionAtField->row col:brick.positionAtField->col + 1];
	Brick* leftNeighbour = [[Game sharedGame].field brickAtRow:brick.positionAtField->row col:brick.positionAtField->col - 1];
	Brick* topNeighbour = [[Game sharedGame].field brickAtRow:brick.positionAtField->row - 1 col:brick.positionAtField->col];
	Brick* bottomNeighbour = [[Game sharedGame].field brickAtRow:brick.positionAtField->row + 1 col:brick.positionAtField->col];
	
	//просмотр соседей	
	if ([brick canConnectTo:rightNeighbour from:BORightOutlet] && ![self brickAlreadyProcessed:rightNeighbour] && rightNeighbour.state != BSDead) {
		[bricksToWalk addObject: rightNeighbour];
		[self processNeighbour:rightNeighbour of:brick];
	}
	
	
	if ([brick canConnectTo:bottomNeighbour from:BOBottomOutlet] && ![self brickAlreadyProcessed:bottomNeighbour] && bottomNeighbour.state != BSDead) {
		[bricksToWalk addObject: bottomNeighbour];
		[self processNeighbour:bottomNeighbour of:brick];
	}
	
	
	if ([brick canConnectTo:topNeighbour from:BOTopOutlet] && ![self brickAlreadyProcessed:topNeighbour] && topNeighbour.state != BSDead) {
		[bricksToWalk addObject: topNeighbour];
		[self processNeighbour:topNeighbour of:brick];
	}
	
	
	if ([brick canConnectTo:leftNeighbour from:BOLeftOutlet] && ![self brickAlreadyProcessed:leftNeighbour] && leftNeighbour.state != BSDead) {
		[bricksToWalk addObject: leftNeighbour];
		[self processNeighbour:leftNeighbour of:brick];
	}
	
	[brick release];
	
	
	if (self.finished) {
		[self pathComplete];
	}
}

-(BOOL)brickAlreadyProcessed:(Brick*)brick {
	return [walkedBricks containsObject:brick];
}

-(void)brickAddedToPath:(Brick*)brick {	
}

-(void) pathComplete {
}

-(void) processNeighbour:(Brick*)negihbour of:(Brick*)brick {
}

-(BOOL)canGoThrought:(Brick*) brick {
	return YES;
}

- (BOOL)finished {
	return bricksToWalk.count == 0;
}

-(NSMutableSet*)walkedBricks {
	return walkedBricks;	
}

-(void) dealloc {
	[walkedBricks release];
	[bricksToWalk release];
	[super dealloc];
}

@end
