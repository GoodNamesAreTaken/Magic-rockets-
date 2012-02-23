//
//  FallingObject.m
//  MagicRocketsRemake
//
//  Created by SwinX on 02.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"
#import "GameScene.h"
#import "Configuration.h"

@implementation GameObject

@synthesize falling;
@synthesize moving;

-(id)initWithTextureName:(NSString*)name andPositionAtField:(PositionAtField)posAtField {
	if ((self = [super init])) {
		positionAtField = malloc(sizeof(PositionAtField));
		positionAtField->row = posAtField.row;
		positionAtField->col = posAtField.col;
	
		falling = NO;
		moving = NO;
		
		CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name];
		
		[self setTexture:frame.texture];
		[self setTextureRect:frame.rect];
		[self setDisplayFrame:frame];
		
		self.position = [[GameScene scene] getScreenStartPositionToFallFor:*positionAtField]; 
		[self fallTo:[[GameScene scene] getScreenPositionFor:*positionAtField]];
	}
	return self;
}

-(void)fallTo:(CGPoint)fallPosition {
	falling = YES;
	//[[CCActionManager sharedManager] removeAllActionsFromTarget:self];
	[self runAction:[CCSequence actions:[CCMoveTo actionWithDuration:FALL_TIME position:fallPosition],
					   [CCCallFunc actionWithTarget:self selector:@selector(fallFinished)],		
					   nil]
	 ];
}

-(void)fallFinished {
	falling = NO; 
	//Must be exetended
}

-(void)moveTo:(CGPoint)movePosition {
	moving = YES;
	[self runAction:[CCSequence actions:[CCMoveTo actionWithDuration:FALL_TIME position:movePosition],
					 [CCCallFunc actionWithTarget:self selector:@selector(moveFinished)],
					 nil]
	 ];
}

-(void)moveFinished {
	moving = NO;
	//must be extended
}

-(PositionAtField*)positionAtField {
	return positionAtField;
}

-(void)explodeWithEpicenter:(PositionAtField)epicenter {
	
	[self.parent reorderChild:self z:100];
	
	float destinationX;
	
	if (positionAtField->col < epicenter.col) {
		destinationX = - 50;
	} else if (positionAtField->col > epicenter.col) {
		destinationX = [CCDirector sharedDirector].winSize.width + 50;
	} else {
		destinationX = (rand() % 2 == 0)? -50:  [CCDirector sharedDirector].winSize.width + 50;
	}

	float duration = 1.0f + CCRANDOM_0_1() /* * 2.0f*/;
	
	CCSequence* explodeSequence = [CCSequence actions:
								   [CCSpawn actions:[CCJumpTo actionWithDuration:duration position:ccp(destinationX, -50) height:180 jumps:1],
										[CCRotateBy actionWithDuration:duration angle:360*(1+arc4random()%3)],
										nil
									],
								   [CCCallFuncN actionWithTarget:[GameScene scene] selector:@selector(removeSpriteFromField:)],
								   nil 
	];
	
	[self runAction:explodeSequence];
}

-(void)dealloc {
	free(positionAtField);
	[super dealloc];
}

@end


