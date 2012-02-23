//
//  GameLayer.m
//  MagicRocketsRemake
//
//  Created by SwinX on 27.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FieldLayer.h"
#import "Game.h"
#import "Skin.h"
 
@implementation FieldLayer

-(id)init {
	if ((self = [super init])) {
		self.isTouchEnabled = YES;
		
		spriteSheet = [CCSpriteBatchNode batchNodeWithTexture:[[Skin currentSkin] textureFor:@"OnFieldTextures/OnFieldTextures.png"] capacity: ROWS*COLS];
		[self addChild:spriteSheet];
		
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[[Skin currentSkin] textureNameFor:@"OnFieldTextures/OnFieldTextures.plist"]];
		
		CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:@"Brick0.png"];
		brickWidth = sprite.contentSize.width;
		brickHeight = sprite.contentSize.height;
		
		xOffset =  [CCDirector sharedDirector].winSize.width*0.5 - (brickWidth*COLS*0.5) + brickWidth/2;
		yOffset =  [CCDirector sharedDirector].winSize.height*0.5 - (brickHeight*ROWS*0.5) + brickHeight/2;
		
	}
	return self;
}

-(void)addSpriteToField:(CCSprite*)sprite {
	[spriteSheet addChild:sprite];
}

-(void)removeSpriteFromField:(CCSprite*)sprite {
	[spriteSheet removeChild:sprite cleanup:YES];
}

-(void)createFires {
	for (int i=0; i<ROWS; i++) {
		Candle* fire = [Candle candle];
		fire.position = [self getScreenPositionForFire:fire at:i];
		[self addChild:fire];
	}
}

//Catching touches
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {	
	for (UITouch* touch in [touches allObjects]) {
		
		CGPoint point = [touch locationInView: touch.view];
		point =[[CCDirector sharedDirector] convertToGL:point];
		
		for (int i=0; i<ROWS; i++) {
			for (int j=0; j<COLS; j++) {
				
				Brick* brick = [[Game sharedGame].field brickAtRow:i col:j];
				
				if ([brick pointInside:point] && brick.state != BSDead) {
					[brick rotate];
				}
				
			}
		}
		
	}
}

-(CGPoint)getScreenPositionFor:(PositionAtField)positionAtField {
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	CGPoint newPosition;
	newPosition.x = xOffset + brickWidth*positionAtField.col;
	newPosition.y = screenSize.height - yOffset - brickHeight*positionAtField.row + UI_OFFSET;
	return newPosition;
}

-(CGPoint)getScreenStartPositionToFallFor:(PositionAtField)positionAtField {
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	CGPoint newPosition;
	newPosition.x = xOffset + brickWidth*positionAtField.col;
	newPosition.y = screenSize.height - brickHeight/2;
	return newPosition;
}

-(CGPoint)getScreenPositionForFire:(Candle*)fire at:(int)row {
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	CGPoint newPosition;
	newPosition.x = xOffset - [fire width]*2 - FIELD_BORDER_WIDTH;
	newPosition.y = screenSize.height - yOffset - brickHeight*row + UI_OFFSET;
	return newPosition;
}

-(CGPoint)getScreenPositionForRocket:(Rocket*)rocket at:(int)row {
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	CGPoint newPosition;
	newPosition.x = xOffset + brickWidth*(COLS-1) + rocket.contentSize.width;
	newPosition.y = screenSize.height - yOffset - brickHeight*row + 15 + UI_OFFSET;
	return newPosition;
}

-(void)dealloc {
	[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	[super dealloc];
}

@end
