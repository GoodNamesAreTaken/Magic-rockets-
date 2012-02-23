//
//  GameLayer.h
//  MagicRocketsRemake
//
//  Created by SwinX on 27.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Brick.h"
#import "Rocket.h"
#import "Candle.h"

/**
 A field layer of the game scene. 
 
 For performance improvements all field elements (bricks and bonuses) rendering implemented with the spritesheet. 
 So, this elements must be added to the spritesheet. Others (particles) must be added directly to the field layer.
 */

@interface FieldLayer : CCLayer {
	CCSpriteBatchNode* spriteSheet;
	
	float brickWidth;
	float brickHeight;
	
	float xOffset;
	float yOffset;
}
 
/**
 Adds a sprite to field layer spritesheet. 
 @param sprite sprite to add
 @see FieldLayer
 */
-(void)addSpriteToField:(CCSprite*)sprite;

/**
 Removes sprite from field layer spritesheet.
 @param sprite sprite to remove
 @see FieldLayer
 */
-(void)removeSpriteFromField:(CCSprite*)sprite;

/**
 Adds renderable node to to directly to field layer
 @param node node to add
 @see FieldLayer
 */

/**
 Create fires(at left side of the field)
 */
-(void)createFires;

/**
 Convert field coordinates into screen position
 */
-(CGPoint)getScreenPositionFor:(PositionAtField)positionAtField;

/**
 Get starting position for falling objects
 */
-(CGPoint)getScreenStartPositionToFallFor:(PositionAtField)positionAtField;

/**
 Get screen position for rocket
 */
-(CGPoint)getScreenPositionForRocket:(Rocket*)rocket at:(int)row;

/**
 Get screen position for fire 
 */
-(CGPoint)getScreenPositionForFire:(Candle*)fire at:(int)row;

@end
