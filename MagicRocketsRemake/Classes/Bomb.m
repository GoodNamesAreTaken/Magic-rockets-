//
//  Bomb.m
//  MagicRocketsRemake
//
//  Created by SwinX on 06.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Bomb.h"
#import "Game.h"
#import "SimpleAudioEngine.h"
#import "GameScene.h"
#import "Configuration.h"

@interface Bomb(Private)

-(void)playBombEffect;

@end


@implementation Bomb

+(Bomb*)bomb {
	return [[[self alloc] initWithTextureName:@"Bomb.png" andPositionAtField:[[Game sharedGame].bonusManager getFreePosition]] autorelease];
}

-(CCFiniteTimeAction*)performAnimation {
	if (positionAtField->row == ROWS-1) {
		return [CCFiniteTimeAction action];
	} else {
		positionAtField->row = MIN(positionAtField->row + BOMB_FALL_DISTANCE, (ROWS-1));
		return [CCMoveTo actionWithDuration:BOMB_FALL_TIME position:[[GameScene scene] getScreenPositionFor:*positionAtField]];
	}
}

-(void)effect {
	[self playBombEffect];
	[[SimpleAudioEngine sharedEngine] playEffect:@"Bomb.caf"];
	[[Game sharedGame].field explodeBricksWithEpicenter:*positionAtField];
	[[Game sharedGame].bonusManager explodeBonusesWithEpicenter:*positionAtField];
}

-(void)playBombEffect {
	CCParticleSystemQuad* boom = [CCParticleSystemQuad particleWithFile:[[Skin currentSkin] textureNameFor:@"Interface/Boom.plist"]];
	boom.position = self.position;
	boom.autoRemoveOnFinish = YES;
	[[GameScene scene] addNodeToFrontLayer:boom];
}

@end
