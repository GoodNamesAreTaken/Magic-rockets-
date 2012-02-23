//
//  BackgroundLayer.m
//  MagicRocketsRemake
//
//  Created by SwinX on 01.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BackgroundLayer.h"
#import "Configuration.h"
#import "GameScene.h"

@implementation BackgroundLayer

-(id)init {
	if ((self = [super init])) {		
		back = [[CCSprite spriteWithTexture:
							[[Skin currentSkin] textureFor:@"Backgrounds/FieldBack.png"]
						] 
				retain];
		back.position = ccp(SCREEN_CENTER.x, SCREEN_CENTER.y + UI_OFFSET);
		[self addChild:back];
		[self reorderChild:back z:10];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadSkin) name:SkinDidChangeNotification object:nil];
	}
		 
	return self;
}

-(void)reloadSkin {
	[back setTexture:[[Skin currentSkin] textureFor:@"field"]];
}

-(void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:SkinDidChangeNotification object:nil];
	[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	[back release];
	[super dealloc];
}

@end
