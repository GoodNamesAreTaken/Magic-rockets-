//
//  ViewRocketsCountComponent.h
//  MagicRocketsRemake
//
//  Created by SwinX on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewComponent.h"


@interface ViewRocketsCountComponent : ViewComponent {
	CCSprite* rocket;
	CCLabelTTF* rocketsCount;
}

-(void)rocketsCountUpdated;

@end
