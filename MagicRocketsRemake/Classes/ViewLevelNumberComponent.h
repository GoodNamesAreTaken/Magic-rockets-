//
//  ViewLevelNumberComponent.h
//  MagicRocketsRemake
//
//  Created by SwinX on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewComponent.h"


@interface ViewLevelNumberComponent : ViewComponent {
	CCLabelTTF* levelNumber;
}

-(void)levelNumberUpdated;

@end
