//
//  FrontLayer.h
//  MagicRocketsRemake
//
//  Created by SwinX on 09.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Rocket.h"
#import "ProgressBar.h"

/**
 The interface layer of the game scene.
 All method purpose discussed in GameScene class
 
 @see GameScene
 */

@interface InterfaceLayer : CCLayer {
	CCMenu* menu;
}

-(void)launchedRockets:(int)amount;
-(void)launchedRocket:(Rocket*)rocket atRow:(int)row forPoints:(int)pointsForRocket;
-(void)levelUp;
-(void)hurryUp;
-(void)upgrading;
-(void)gameOver;

-(void)showMenu;
-(void)hideMenu;

-(CGPoint)coinSpritePosition;

@end
