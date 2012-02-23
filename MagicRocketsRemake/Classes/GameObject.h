//
//  FallingObject.h
//  MagicRocketsRemake
//
//  Created by SwinX on 02.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Types.h"

/**
 A base class for all falling enities in game (bricks and bonuses).
 
 Falling objects must be added to the field.
 */
@interface GameObject : CCSprite {
	PositionAtField* positionAtField;
	BOOL falling;
	BOOL moving;
}

@property(readonly) PositionAtField* positionAtField;
@property(readonly) BOOL falling;
@property(readonly) BOOL moving;


-(id)initWithTextureName:(NSString*)name andPositionAtField:(PositionAtField)posAtField;

-(void)fallTo:(CGPoint)fallPosition;
-(void)fallFinished;

-(void)moveTo:(CGPoint)movePosition;
-(void)moveFinished;

-(PositionAtField*)positionAtField;

-(void)explodeWithEpicenter:(PositionAtField)epicenter;

@end
