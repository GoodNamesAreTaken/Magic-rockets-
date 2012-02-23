//
//  ViewMatchesComponent.m
//  MagicRocketsRemake
//
//  Created by SwinX on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewMatchesComponent.h"
#import "Positions.h"
#import "MatchesCounterComponent.h"
#import "GameMode.h"
#import "Skin.h"

@implementation ViewMatchesComponent

-(id)init {
	if ((self = [super init])) {
		match = [CCSprite spriteWithTexture:[[Skin currentSkin] textureFor:@"Interface/Match.png"]];
		match.position = ccp(MATCHES_X_POSITION, [CCDirector sharedDirector].winSize.height - match.contentSize.height/2);
		[view addChild:match];
		
		matchesCount = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:DEFAULT_INTERFACE_LABEL_FONT_SIZE];
		matchesCount.anchorPoint = ccp(0, 1);
		matchesCount.position = ccp(match.position.x + match.contentSize.width/2, [CCDirector sharedDirector].winSize.height - match.contentSize.height/2);
		[view addChild:matchesCount];
	}
	return self;
}

-(void)matchesCountUpdated {
	MatchesCounterComponent* component = [owner componentNamed:@"Matches"];
	if (component) {
		[matchesCount setString:[NSString stringWithFormat:@"%d", component.matchesRemaining]];
	}
}

@end
