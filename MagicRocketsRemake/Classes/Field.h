//
//  Field.h
//  MagicRocketsRemake
//
//  Created by Troll ololo on 20.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Configuration.h"
#import "cocos2d.h"
#import "Brick.h"

@interface Field: NSObject {
	Brick* bricks[ROWS][COLS];
}
/**
 Creates field
 */
-(void)createField;

-(void)createNewBricks;

/**
 Killes field
 */
-(void)killField;

/**
 Adds brick to processing
 */
-(void)addBrick:(Brick*)brick at:(PositionAtField)pos;

/**
 Returns brick at position
 */
-(Brick*)brickAt:(PositionAtField)pos;
-(Brick*)brickAtRow:(int)row col:(int)col;

/**
 kills dead bricks and launches rockets or updates field
 */
-(void)clearField;

/**
 Kills brick from game
 */
-(void)killBrick:(Brick*)brick;

/**
 Kills brick instantly(required for bomb)
 */
-(void)instantlyKillBricks:(NSArray*)deadBricks;

-(void)explodeBricksWithEpicenter:(PositionAtField)epicenter;

/**
 Kills dead bricks
 */
-(void)killDeadBricks;

/**
 Sets bricks state to BSNone
 */
-(void)restoreBricksState;

/**
 Updates bricks state
 */
-(void)updateBricks;

/**
 Make bricks fall the bottom of the field and create new bricks instead of missing
 */
-(void)fallBricks;

/**
 Checks if bricks falling
 */
-(BOOL)bricksFalling;

/**
 Event that bricks triggers when finishes falling
 */
-(void)brickFinishedFalling:(Brick*)brick;

@end
