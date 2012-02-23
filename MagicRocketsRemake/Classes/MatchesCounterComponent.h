//
//  MatchesCounterComponent.h
//  MagicRocketsRemake
//
//  Created by SwinX on 14.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModeComponent.h"


@interface MatchesCounterComponent : ModeComponent {
	int matchesRemaining;
}

@property(readonly) int matchesRemaining;

-(void)newGame;
-(void)saveGame;
-(void)loadGame;

-(void)levelUp;

-(void)fuseBurned;

@end
