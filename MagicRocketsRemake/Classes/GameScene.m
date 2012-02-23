//
//  HelloWorldLayer.m
//  MagicRocketsRemake
//
//  Created by Troll ololo on 20.08.10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "GameScene.h"
#import "Game.h"
#import "SimpleAudioEngine.h" 

static GameScene* instance = nil;

@implementation GameScene
@synthesize fieldLayer, skin;

+(id)scene {
	@synchronized(self) {
		if (instance == nil) {
			instance = [[GameScene alloc] init];
		}
	}
	return instance;
}

-(id) init {
	if ((self=[super init])) {
		
		fieldLayer = [[FieldLayer alloc] init];
		backgroundLayer = [[BackgroundLayer alloc] init];
		interfaceLayer = [[InterfaceLayer alloc] init];
		
		[self addChild:backgroundLayer];
		[self addChild:fieldLayer];
		[self addChild:interfaceLayer];
		
	}
	return self;
}

-(void)enable {
	[self schedule:@selector(tick:)];
	fieldLayer.isTouchEnabled = YES;
}

-(void)disable {
	[self unschedule:@selector(tick:)];
	fieldLayer.isTouchEnabled = NO;
}

-(void)tick:(ccTime)dt {
	[[Game sharedGame].mode handleEvent:@selector(timeElapsed:) withObject:[NSNumber numberWithFloat:dt]];
}

-(void)addSpriteToField:(CCSprite*)sprite {
	[fieldLayer addSpriteToField:sprite];
}

-(void)removeSpriteFromField:(CCSprite*)sprite {
	[fieldLayer removeSpriteFromField:sprite];
}

-(void)addNodeToFrontLayer:(CCNode*)node {
	[fieldLayer addChild:node];
}

-(void)removeNodeFromFrontLayer:(CCNode*)node {
	[fieldLayer removeChild:node cleanup:YES];
}

-(void)addNodeToBackgroundLayer:(CCNode*)node {
	[backgroundLayer addChild:node];
}

-(void)removeNodeFromBackgroundLayer:(CCNode*)node {
	[backgroundLayer removeChild:node cleanup:YES];
}

-(void)createInterfaceFromElements:(NSArray*)elements {
	for (CCNode* node in elements) {
		[interfaceLayer addChild:node];
	}
}

-(void)launchedRockets:(int)amount {
	[interfaceLayer launchedRockets:amount];
}

-(void)launchedRocket:(Rocket*)rocket atRow:(int)row forPoints:(int)pointsForRocket {
	[interfaceLayer launchedRocket:rocket atRow:row forPoints:pointsForRocket];
}

-(void)levelUp {
	[interfaceLayer levelUp];
	[[SimpleAudioEngine sharedEngine] playEffect:@"LevelUp.caf"];
}

-(void)upgrading {
	[interfaceLayer upgrading];
}

-(void)hurryUp { 
	[interfaceLayer hurryUp];
	[[SimpleAudioEngine sharedEngine] playEffect:@"HurryUp.caf"];
}

-(void)createFires {
	[fieldLayer createFires];
}

-(void)gameOver {
	[interfaceLayer gameOver];
	[[SimpleAudioEngine sharedEngine] playEffect:@"TimeOver.caf"];
}

-(void)showMenu {
	[interfaceLayer showMenu];
}

-(void)hideMenu {
	[interfaceLayer hideMenu];
}

-(CGPoint)getScreenPositionFor:(PositionAtField)positionAtField {
	return [fieldLayer getScreenPositionFor:positionAtField];
}

-(CGPoint)getScreenStartPositionToFallFor:(PositionAtField)positionAtField {
	return [fieldLayer getScreenStartPositionToFallFor:positionAtField];
}

-(CGPoint)getScreenPositionForRocket:(Rocket*)rocket at:(int)row {
	return [fieldLayer getScreenPositionForRocket:rocket at:row];
}

-(CGPoint)getScreenPositionForUpgradeCoin {
	return [interfaceLayer coinSpritePosition]; 
}

-(void)dealloc {
	[fieldLayer release];
	[backgroundLayer release];
	[interfaceLayer release]; 
	[super dealloc];
}

@end
