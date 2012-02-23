//
//  MenuLayer.h
//  MagicRocketsRemake
//
//  Created by SwinX on 13.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

/**
 Main menu scene
 */

@interface MainMenu : CCLayer {
	CCMenuItem* enableSound;
	CCMenuItem* disableSound;
	
	CCMenuItem* easy;
	CCMenuItem* normal;
	CCMenuItem* hard;
}

/**
 Create initialised main menu scene.
 
 */
+(id)scene;

@end
