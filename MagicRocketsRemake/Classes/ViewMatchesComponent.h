//
//  ViewMatchesComponent.h
//  MagicRocketsRemake
//
//  Created by SwinX on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewComponent.h"


@interface ViewMatchesComponent : ViewComponent {
	CCSprite* match;
	CCLabelTTF* matchesCount;
}

-(void)matchesCountUpdated;

@end
