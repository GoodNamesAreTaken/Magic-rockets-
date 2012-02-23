//
//  ViewRocketsCountComponent.m
//  MagicRocketsRemake
//
//  Created by SwinX on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewRocketsCountComponent.h"
#import "Configuration.h" 
#import "RocketsCounterComponent.h"
#import "RocketsLaunchedComponent.h"
#import "Game.h"
#import "Positions.h"
#import "Skin.h"

@implementation ViewRocketsCountComponent

-(id)init {
	if ((self = [super init])) {
		rocket = [CCSprite spriteWithTexture:[[Skin currentSkin] textureFor:@"Interface/MenuRocket.png"]];
		rocket.position = ccp(ROCKET_X_POSITION, [CCDirector sharedDirector].winSize.height - rocket.contentSize.height/2);
		[view addChild:rocket];
		
		rocketsCount = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:DEFAULT_INTERFACE_LABEL_FONT_SIZE];
		rocketsCount.anchorPoint = ccp(0, 1);
		rocketsCount.position = ccp(rocket.position.x + rocket.contentSize.width/2, [CCDirector sharedDirector].winSize.height - rocket.contentSize.height/2);
		[view addChild:rocketsCount];
		
	}
	return self;
}

-(void)rocketsCountUpdated {
	if ([Game sharedGame].state == GSPlayingTimeAttack) {
		RocketsLaunchedComponent* component = [owner componentNamed:@"RocketsLaunched"];
		if (component) {
			[rocketsCount setString:[NSString stringWithFormat:@"%d", component.rocketsLaunched]];
		}
	} else {
		RocketsCounterComponent* component = [owner componentNamed:@"RocketsCounter"];
		if (component) {
			[rocketsCount setString:[NSString stringWithFormat:@"%d",component.rocketsRemaining]];
		}
	}
}

@end
