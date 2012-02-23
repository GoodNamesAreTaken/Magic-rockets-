//
//  RocketsComponent.h
//  MagicRocketsRemake
//
//  Created by SwinX on 14.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModeComponent.h"


@interface RocketsLaunchedComponent : ModeComponent {
	int rocketsLaunched;
}

@property(readonly) int rocketsLaunched;

-(void)rocketLaunched:(Rocket *)rocket;

@end
