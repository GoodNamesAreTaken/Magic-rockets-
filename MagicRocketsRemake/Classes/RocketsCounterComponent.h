//
//  RocketsCounterComponent.h
//  MagicRocketsRemake
//
//  Created by SwinX on 14.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModeComponent.h"


@interface RocketsCounterComponent : ModeComponent {
	int rocketsToLaunch;
	int rocketsRemaining;
	
	BOOL finished;
}	

@property(readonly) int rocketsRemaining;

-(void)newGame;
-(void)loadGame;

-(void)saveGame;

@end
