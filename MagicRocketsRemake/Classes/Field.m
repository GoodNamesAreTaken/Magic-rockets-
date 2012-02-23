//
//  Field.m
//  MagicRocketsRemake
//
//  Created by Troll ololo on 20.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Field.h"
#import "Game.h"
#import "ConnectedToRocketPathBuilder.h"
#import "ConnctedToFirePathBuilder.h"
#import "SparkPathBuilder.h"
 
#import "GameScene.h"

#import "FinisherComponent.h"

@implementation Field

-(id)init {
	if ((self = [super init])) {
	}
	return self;
}

-(void)createField {
	for (int i=0; i<ROWS; i++) {
		for (int j=0; j<COLS; j++) {
			Brick* brick = [Brick newBrickAt:posAtField(i, j)];
			[[GameScene scene] addSpriteToField:brick];
			[self addBrick:brick at:*brick.positionAtField];
		}
	}
}

-(void)createNewBricks {
	FinisherComponent* component = [[Game sharedGame].mode componentNamed:@"Finisher"];
	if (!component.levelFinished) {
		for (int i=0; i<ROWS; i++) {
			for (int j=0; j<COLS; j++) {
				if (!bricks[i][j]) {
					Brick* brick = [Brick newBrickAt:posAtField(i, j)];
					[self addBrick:brick at:*brick.positionAtField];
					[[GameScene scene] addSpriteToField:brick];
				}
			}
		}
	}
}

-(void)killField {
	for (int i=0; i<ROWS; i++) {
		for  (int j=0; j<COLS; j++) {
			[self killBrick:bricks[i][j]];
		}
	}
}

-(void)addBrick:(Brick*)brick at:(PositionAtField)pos {
	if (pos.row >= ROWS || pos.col >= COLS || pos.row < 0 || pos.col < 0) {
		NSLog(@"Wrong row or col");
		return;
	} 
	bricks[pos.row][pos.col] = brick;
}

-(Brick*)brickAt:(PositionAtField)pos {
	if (pos.row >= ROWS || pos.col >= COLS || pos.row < 0 || pos.col < 0 || bricks[pos.row][pos.col].falling) {
		return nil;
	} else {
		return bricks[pos.row][pos.col];
	}
}

-(Brick*)brickAtRow:(int)row col:(int)col {
	return [self brickAt:posAtField(row, col)];
}

-(void)killBrick:(Brick*)brick {
	if (brick) {
		bricks[brick.positionAtField->row][brick.positionAtField->col] = nil;
		[[GameScene scene] removeSpriteFromField:brick];
	}
}

-(void)instantlyKillBricks:(NSArray*)deadBricks {
	for (Brick* dead in deadBricks) {
		[self killBrick:dead];
	}
	[self fallBricks];
	
}

-(void)explodeBricksWithEpicenter:(PositionAtField)epicenter {
	for (int i=epicenter.row - 1; i<=epicenter.row+1; i++) {
		for (int j=epicenter.col - 1; j<=epicenter.col+1; j++) {
			Brick* brick = [self brickAtRow:i col:j];
			if (brick) {
				[brick explodeWithEpicenter:epicenter];
				bricks[i][j] = nil;
			}
 		}
	}
	[self fallBricks];
}

-(void)clearField {
	int launchedRockets = 0;
	
	for (int i=0; i<ROWS; i++) {
		Brick* brick = bricks[i][COLS-1];
		if (brick.state == BSDead && [brick hasOutlet:BORightOutlet] && [[Game sharedGame].rocketManager rocketAt:i]) {
			[[Game sharedGame].rocketManager launchRocketAt:brick.positionAtField->row];
			launchedRockets++;
		}
	}
	
	if (launchedRockets) {
		[[Game sharedGame].bonusManager launchedRockets:launchedRockets];
		[[GameScene scene] launchedRockets:launchedRockets];
		[self killDeadBricks];
		[self fallBricks];
	} else {
		[self restoreBricksState];
		[self updateBricks];
	}
	 
}

-(void)killDeadBricks {
	int bonus = 0;
	for (int i=0; i<ROWS; i++) {
		for (int j=0; j<COLS; j++) {
			if (bricks[i][j].state == BSDead) {
				[self killBrick:bricks[i][j]];
				bonus += POINTS_PER_BRICK;
			}
		}
	}
	[[Game sharedGame].mode handleEvent:@selector(pointsChangedBy:) withObject:[NSNumber numberWithInt:bonus]];
}

-(void)restoreBricksState {
	for (int i=0; i<ROWS; i++) {
		for (int j=0; j<COLS; j++) {
			bricks[i][j].state = BSNone;
		}
	}
}
-(void)updateBricks {

	//обнуление поля
	for (int i=0; i<ROWS; i++) {
		for (int j=0; j<COLS; j++) {
			if (bricks[i][j].state != BSDead) {
				bricks[i][j].state = BSNone;
			}
			
		}
	}
	
	//поиск всех путей
	for (int i=0; i < ROWS; i++) {
		if ([bricks[i][0] hasOutlet:BOLeftOutlet]) {
			ConnctedToFirePathBuilder* builder = [[[ConnctedToFirePathBuilder alloc] init] autorelease];
			[builder buildStartingFrom:bricks[i][0]];
		}
	}
	
	for (int i=0; i < ROWS; i++) {
		if ([bricks[i][COLS-1] hasOutlet:BORightOutlet]) {
			ConnectedToRocketPathBuilder* builder = [[[ConnectedToRocketPathBuilder alloc] init] autorelease];
			[builder buildStartingFrom:bricks[i][COLS-1]];
			if (builder.fireBrick) {
				SparkPathBuilder* sparkPath = [[[SparkPathBuilder alloc] init] autorelease];
				[sparkPath startFromBrick:builder.fireBrick];
				[[Game sharedGame].mode handleEvent:@selector(fuseBurned)];
			}
		}
	}
	
}

-(void)fallBricks {
	
	for (int col=0; col < COLS; col++) {
		
		for (int row=ROWS-2; row >= 0; row--) {
			if (bricks[row][col]) {
				int fallDistance = 0;
				for (int locatedRow=row+1; locatedRow < ROWS; locatedRow++) {
					if (!bricks[locatedRow][col]) {
						fallDistance++;
					} 
				}
				
				if (fallDistance > 0) {
					
					PositionAtField oldPos = posAtField(row, col);
					PositionAtField newPos = posAtField(row+fallDistance, col);
					
					[[Game sharedGame].bonusManager bonusAtPosition:oldPos mustFallTo:newPos];
					
					bricks[newPos.row][newPos.col] = bricks[oldPos.row][oldPos.col];
					bricks[oldPos.row][oldPos.col] = nil;
					bricks[newPos.row][newPos.col].positionAtField->row += fallDistance;
					[bricks[newPos.row][newPos.col] fallTo:[[GameScene scene] getScreenPositionFor:newPos]];
					
				}
				
			}
		}
	}
	
	[self createNewBricks];

}

-(void)resetStateForBricks:(NSArray*)bricksToReset {
	for (Brick* brick in bricksToReset) {
		brick.state = BSNone; 
	}
}

-(void)brickFinishedFalling:(Brick*)brick {

	[[Game sharedGame].bonusManager tryToCreateBonus];

	if (![self bricksFalling]) {
		[self updateBricks];
	}
}

-(BOOL)bricksFalling {
	for (int i=0; i<ROWS; i++) {
		for (int j=0; j<COLS; j++) {
			if (bricks[i][j].falling) {
				return YES;
			}
		}
	}
	return NO;
}	

-(void)dealloc {
	[self killField];
	[super dealloc];
}

@end
