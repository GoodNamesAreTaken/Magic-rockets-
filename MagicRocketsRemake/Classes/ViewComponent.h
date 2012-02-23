//
//  ViewPointsComponent.h
//  MagicRocketsRemake
//
//  Created by SwinX on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "ModeComponent.h"

@interface ViewComponent : ModeComponent {
	CCNode* view;
}

-(CCNode*)getView;

@end
