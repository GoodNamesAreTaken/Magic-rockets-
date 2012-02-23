//
//  Fire.m
//  MagicRocketsRemake
//
//  Created by SwinX on 16.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Candle.h"
#import "Configuration.h" 
#import "Skin.h"


@implementation Candle

+(Candle*)candle {
	return [[[self alloc] init] autorelease];
}

-(id)init {
	if ((self = [super init])) {
		
		[[CCSpriteFrameCache sharedSpriteFrameCache] 
			addSpriteFramesWithFile:[[Skin currentSkin] textureNameFor:@"Candle/Fires.plist"]];
		
		candle = [CCSprite spriteWithTexture:[[Skin currentSkin] textureFor:@"Candle/Candle.png"]];
		[self addChild:candle];
		
		fire = [CCSprite spriteWithSpriteFrameName:@"fire0.png"];
		fire.position = ccp(-candle.contentSize.width/2, 0);
		
		spriteSheet = [CCSpriteBatchNode batchNodeWithFile:[[Skin currentSkin] textureNameFor:@"Candle/Fires.png"]];
		[spriteSheet addChild:fire];
		[self addChild:spriteSheet];
		
		NSMutableArray *animFrames = [NSMutableArray array];
		for(int i = 1; i < FIRES_AMOUNT; i++) {
			
			CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fire%d.png",i]];
			[animFrames addObject:frame];
		}
		float delay = 0.1f + 0.001f * (arc4random() % 300);
		CCAnimation *animation = [[[CCAnimation alloc] initWithFrames:animFrames delay:delay] autorelease];

		[fire runAction:[CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:animation restoreOriginalFrame:YES]]];
		
		
	}
	return self;
}

-(float)width {
	return candle.contentSize.width;
}

-(float)height {
	return candle.contentSize.height;
}

-(void)dealloc {
	[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	[super dealloc];
}

@end
