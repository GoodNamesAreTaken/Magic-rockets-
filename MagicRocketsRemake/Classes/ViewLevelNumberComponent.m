//
//  ViewLevelNumberComponent.m
//  MagicRocketsRemake
//
//  Created by SwinX on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewLevelNumberComponent.h"
#import "Positions.h"
#import "LevelNumberComponent.h"
#import "GameMode.h"

@implementation ViewLevelNumberComponent

-(id)init {
	if ((self = [super init])) {
		levelNumber = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@: 0", NSLocalizedString(@"Level", @"Level")] fontName:@"Marker Felt" fontSize:LEVEL_SIZE];
		levelNumber.position = ccp([CCDirector sharedDirector].winSize.width/2, LEVEL_NUMBER_Y_POSITION);	
		levelNumber.color = ccc3(0, 0, 255);
		[view addChild:levelNumber];
	}
	return self;
}

-(void)levelNumberUpdated {
	LevelNumberComponent* component = [owner componentNamed:@"LevelNumber"];
	if (component) {
		[levelNumber setString:[NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Level", @"Level"), component.levelNumber]];
	}
}

@end
