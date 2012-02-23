//
//  FireworkManager.m
//  MagicRocketsRemake
//
//  Created by Inf on 31.08.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "FireworkManager.h"
#import "GameScene.h"
#import "Firework.h"
#import "Configuration.h"
#import "Game.h"
#import "SimpleAudioEngine.h"

static NSString* fireoworkEffects[FIREWORKS_AMOUNT] = {
	@"Fireworks/Fw01.plist",
	@"Fireworks/Fw02.plist",
	@"Fireworks/Fw03.plist",
	@"Fireworks/Fw04.plist",
	@"Fireworks/Fw05.plist"
};

@implementation FireworkManager

-(void)launchFirework { 
	activeFireworksCount++;
	NSString* fireworkFile = [[Skin currentSkin] textureNameFor:fireoworkEffects[arc4random()%FIREWORKS_AMOUNT]];
	Firework* newFirework = [Firework fireworkWithFile:fireworkFile manager:self];
	CGSize winSize = [CCDirector sharedDirector].winSize;
	
	newFirework.position = ccp(arc4random() % (int)winSize.width, arc4random() % (int)winSize.height);
	newFirework.soundSource = [[SimpleAudioEngine sharedEngine] playEffect:@"Firework.caf"];
	[[Game sharedGame].mode handleEvent:@selector(fireworkExploded:) withObject:self];
	[[GameScene scene] addNodeToBackgroundLayer:newFirework];
}

-(void)fireworkDestroyed:(Firework*)firework {
	[[SimpleAudioEngine sharedEngine] stopEffect:firework.soundSource];
	activeFireworksCount--;
	if (!self.fireworksOnScene) {
		[[Game sharedGame].mode handleEvent:@selector(fireworksGone)];
	}
}

-(BOOL)fireworksOnScene {
	return activeFireworksCount > 0;
}
@end


