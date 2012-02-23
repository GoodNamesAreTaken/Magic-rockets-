//
//  LevelComponent.h
//  MagicRocketsRemake
//
//  Created by SwinX on 13.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModeComponent.h"


@interface LevelNumberComponent : ModeComponent {
	int levelNumber;
}

@property(readonly) int levelNumber;

-(void)levelUp;

@end
