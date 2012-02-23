//
//  HelloWorldLayer.h
//  MagicRocketsRemake
//
//  Created by Troll ololo on 20.08.10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//


#import "cocos2d.h"
#import "FieldLayer.h"
#import "BackgroundLayer.h"
#import "InterfaceLayer.h"
#import "Skin.h"

/**
 Main scene of the game.
 Created as a singleton in order to separate model and view.
 
 Scene made from 3 layers - interface, background and field.
 */

@interface GameScene : CCScene {
	FieldLayer* fieldLayer;
	BackgroundLayer* backgroundLayer;
	InterfaceLayer* interfaceLayer;
	Skin* skin;
}

@property(readonly) FieldLayer* fieldLayer;
@property(retain) Skin* skin;

/**
 Get access to the scene.
 All access must be performed with this method
 */
+(id)scene;

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
-(void)addNodeToFrontLayer:(CCNode*)node;

/**
 Removes renderable node directly from field layer
 @param node node to remove
 @see FieldLayer
 */
-(void)removeNodeFromFrontLayer:(CCNode*)node;

/**
 Adds renderable node to background layer
 @param node node to add
 @see BackgroundLayer
 */
-(void)addNodeToBackgroundLayer:(CCNode*)node;

/**
 Removes renderable node directly from Background layer
 @param node node to remove
 @see BackgroundLayer
 */
-(void)removeNodeFromBackgroundLayer:(CCNode*)node;


-(void)createInterfaceFromElements:(NSArray*)elements;
/**
 Enable touches to field and start game timer
 */
-(void)enable;

/**
 Disable touches to field and stop game timer
 */
-(void)disable;

/**
 Show notification about lauched rockets
 Launched rockets amount below 3 is ignored
 
 @param amoun launched rockets amount
 */
-(void)launchedRockets:(int)amount;

/**
 Show points for rocket when its launched
 @param rocket launched rocket
 @param row rocket's row
 @param pointsForRocket points granted for launched rocket
 */
-(void)launchedRocket:(Rocket*)rocket atRow:(int)row forPoints:(int)pointsForRocket;

/**
 Show level up notification
 */
-(void)levelUp;

/**
 Show upgrading notification
 */
-(void)upgrading;

/**
 Show hurry up notification
 */
-(void)hurryUp;

/**
 Show game over notification
 */
-(void)gameOver;

/**
 Show menu button
 */
-(void)showMenu;

/**
 Hide menu button
 */
-(void)hideMenu;

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
 Get start position for upgrade coin
 */
-(CGPoint)getScreenPositionForUpgradeCoin;
 
@end
