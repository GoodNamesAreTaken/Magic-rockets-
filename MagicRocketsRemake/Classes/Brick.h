
//////

//
//  Brick.h
//  MagicRocketsRemake
//
//  Created by SwinX on 02.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"
#import "Types.h"


@interface Brick: GameObject {
	BrickType type;
	BrickState state;
	BOOL outlets[BOOutletsCount];
	BOOL futureOutlets[BOOutletsCount];
	
	int rotationsCount;
}

@property(readonly) BrickType type;
@property BrickState state;

@property(readonly) float width;
@property(readonly) float height;

/**
 Creates random brick at (0:0) position in field
 */
+(Brick*)newBrick;

/**
 Cretes random brick at fixed position
 */
+(Brick*)newBrickAt:(PositionAtField)_positionAtField;

/**
 Initialises a brick with a position
 */
-(id)initWithPositionAtField:(PositionAtField)_positionAtField;

/**
 Rotates a brick
 */
-(void)rotate;

-(BOOL)hasOutlet:(BrickOutlet)outlet;
-(BOOL)canConnectTo:(Brick*)other from:(BrickOutlet)outlet;

/**
 Changes brick state to connectedToFire
 */
-(void)makeConnectedToFire;

/**
 Changes brick state to connectedToRocket
 */
-(void)makeConnectedToRocket;

/**
 Changes brick state to both
 */
-(void)makeConnectedToBoth;

/**
 Changes brick state to independent
 */
-(void)makeIndependant;

/**
 Returns if point inside the brick
 */
-(BOOL)pointInside:(CGPoint)point;

@end



