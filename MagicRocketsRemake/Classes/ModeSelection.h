//
//  ModeSelectionScene.h
//  MagicRocketsRemake
//
//  Created by SwinX on 04.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Game.h"
#import "CCRadioMenu.h"

@interface ModeSelection : CCLayer {
	CCMenuItem* ok;
	CCRadioMenu* modeSelectionMenuPart;
	
	CCSprite* frontImage;
	CCSprite* backImage;
	
	GameState futureState;
	
	int previouslySelectedRadio;
}

+(id)scene;

@end
