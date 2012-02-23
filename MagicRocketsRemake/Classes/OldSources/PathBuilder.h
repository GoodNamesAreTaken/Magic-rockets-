//
//  PathWalker.h
//  Rocket
//
//  Created by Inf on 18.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import "Field.h"
#import "Brick.h"


/**
 This abstract class performs search of all bricks, that connected to some starting brick on a field.
 Exact behaviour of this class is implemented in subclasses.
 */
@interface PathBuilder : NSObject {
	NSMutableArray* bricksToWalk;
	NSMutableSet* walkedBricks;
}


/**
 YES, if the field containts no bricks, that can be added to path.
 */
@property(readonly) BOOL finished;

/**
 Begins building a path from starting brick. Processes only first brick. To process all other bricks you need to call nextBrick while finished is NO.
 */
-(void) startFromBrick:(Brick*)brick;

/**
 If a field has at least one brick, that can be added to path, adds it and processes all of its neighbours
 */
-(void) nextBrick;

/**
 YES, if a given brick was already processed (added or discovered, that given brick can not be added)
 */
-(BOOL) brickAlreadyProcessed:(Brick*)cell;

/**
 Called, when the field contains no more bricks, tat can be added to path.å
 */
-(void) pathComplete;

/**
 Called by path builder while nextBrick call if discovered, that current brick neighbour can be added to path
 
 Can be overrided by subcalsses
 @param neighbour neighbour brick
 @param brick current brick
 */
-(void) processNeighbour:(Brick*)negihbour of:(Brick*)brick;

/**
 Builds a complete path starting from brick. Processes all of bricks, that can be joined with this path.
 */
-(void) buildStartingFrom:(Brick*)brick;

/**
 Called, when new brick is added to path. Can be overriden by subclasses.
 */
-(void) brickAddedToPath:(Brick*)brick;

/**
 Must return YES, if path can go throught a given brick.
 Can be overriden in subcalsses.
 */
-(BOOL) canGoThrought:(Brick*) brick;

-(NSMutableSet*)walkedBricks;


@end
