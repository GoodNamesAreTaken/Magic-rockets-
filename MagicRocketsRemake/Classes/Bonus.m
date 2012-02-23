//
//  Bonus.m
//  MagicRocketsRemake
//
//  Created by SwinX on 31.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Bonus.h"
#import "Game.h"
#import "GameScene.h"
#import "CollectBonusEffect.h"
#import "SimpleAudioEngine.h"

@interface Bonus(Private)

-(void)restoreState;

@end


@implementation Bonus

-(id)initWithTextureName:(NSString *)name andPositionAtField:(PositionAtField)posAtField {
	if ((self = [super initWithTextureName:name andPositionAtField:posAtField])) {
		lifeTime = BONUS_LIFE_TIME;
	}
	return self;
}

-(void)fallFinished {
	[super fallFinished];
	[[SimpleAudioEngine sharedEngine] playEffect:@"Coin.caf"];
	[[Game sharedGame].bonusManager addBonus:self];
}

-(void)collect {
	[self restoreState];
	[[GameScene scene] addNodeToFrontLayer:[CollectBonusEffect effectAt:self.position]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"Bonus.caf"];
	[self runAction:[CCSequence actions: 
					 [self performAnimation],
					 [self performEffect],
					 [CCCallFunc actionWithTarget:self selector:@selector(die)],
					 nil]
	 ];
}

-(CCFiniteTimeAction*)performAnimation {
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

-(CCFiniteTimeAction*)performEffect {
	return [CCCallFunc actionWithTarget:self selector:@selector(effect)];
}

-(void)effect {
	[self doesNotRecognizeSelector:_cmd];
}

-(void)die {
	[[GameScene scene] removeSpriteFromField:self];
}

-(void)update:(ccTime)dt {
	lifeTime-=dt;
	if (lifeTime < BONUS_START_BLINK_TIME && !blink) {
		blink = [CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeOut actionWithDuration:BONUS_BLINK_DURATION],
												   [CCFadeIn actionWithDuration:BONUS_BLINK_DURATION],
												   nil]
				 ];
		
		[self runAction:blink];
	}
	
	if (lifeTime < 0) {
		[[Game sharedGame].bonusManager removeBonus:self];
		[self die];
	}
	
}

-(void)restoreState {
	[[CCActionManager sharedManager] removeAllActionsFromTarget:self];
	self.opacity = 255;
}

@end
