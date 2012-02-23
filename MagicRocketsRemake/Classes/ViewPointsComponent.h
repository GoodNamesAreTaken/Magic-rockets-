//
//  ViewPointsComponent.h
//  MagicRocketsRemake
//
//  Created by SwinX on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewComponent.h"
#import "Configuration.h"

@interface ViewPointsComponent : ViewComponent {
	CCLabelTTF* points;
}

-(void)pointsUpdated;

-(CGPoint)pointsPosition;

@end
