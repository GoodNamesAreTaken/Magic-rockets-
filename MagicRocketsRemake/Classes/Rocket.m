//
//  Rocket.m
//  MagicRocketsRemake
//
//  Created by SwinX on 27.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Rocket.h"
#import "RocketManager.h"
#import "GameScene.h"
#import "Game.h"
#import "SimpleAudioEngine.h"
#import "Skin.h"

@implementation Rocket

@synthesize  row=positionAtField;

+(Rocket*)rocketWithLevel:(int)level AtRow:(int)row manager:(RocketManager*)manager{
	return [[[Rocket alloc]initWithlevel:level andRow:row manager:manager] autorelease];
}

-(id)initWithlevel:(int)level andRow:(int)row manager:(RocketManager*)_manager{
	NSString* fileKey = [NSString stringWithFormat:@"Rockets/Rocket%d.png", MIN(level, MAX_ROCKET_LEVEL)];
	if ((self = [super initWithTexture:[[Skin currentSkin] textureFor:fileKey]])) {
		
		positionAtField = row;
		manager = _manager;
		
		self.position = [[GameScene scene] getScreenPositionForRocket:self at:row];
		
		fire = [[CCParticleSun alloc] init];
		fire.texture = [[Skin currentSkin] textureFor:@"Particles/RocketParticles/Particle.png"];
		fire.emissionRate = 42; // ;)
		fire.position = CGPointMake(-self.contentSize.width/2 + 5.0f, -self.contentSize.height/2 + 5.0f);

	}
	return self;
}

-(void)launch {
	[[SimpleAudioEngine sharedEngine] playEffect:@"Launch.caf"];
	CGSize screenSize = [CCDirector sharedDirector].winSize;
	[self addChild:fire];
	
	[fire runAction:[CCScaleTo actionWithDuration:1.0 scale:0.3]];
	[self runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1.0f position:CGPointMake(screenSize.width + self.contentSize.width*4, self.position.y + self.contentSize.height*3)],
					   [CCCallFunc actionWithTarget:self selector:@selector(rocketExploded)],
					   nil]
	 ];
}

-(void)rocketExploded {	
	[manager rocketExploded:self];
	[[GameScene scene] removeNodeFromFrontLayer:self];
}

-(void)dealloc {
	[fire release];
	[super dealloc];
}

@end
