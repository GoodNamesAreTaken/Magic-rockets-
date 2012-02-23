//
//  MenuLayer.m
//  MagicRocketsRemake
//
//  Created by SwinX on 13.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.

#import <GameKit/GameKit.h>

#import "AppDelegate.h"
#import "MainMenu.h"
#import "SimpleAudioEngine.h"
#import "Game.h"
#import "GameScene.h"
#import "Configuration.h"
#import "Skin.h"
#import "ModeSelection.h"


@implementation MainMenu

+(id)scene {
	CCScene* scene = [CCScene node];
	MainMenu* layer = [MainMenu node];
	[scene addChild:layer];
	return scene;
}

-(id)init {
	if ((self = [super init])) {
		CGSize winSize = [CCDirector sharedDirector].winSize;
		
		CCSprite* background = [CCSprite spriteWithTexture:[[Skin currentSkin] textureFor:@"Backgrounds/MenuBack.png" ]];
		
		background.position = ccp(winSize.width * 0.5f, winSize.height * 0.5f);
		
		[self addChild:background];
		
		CCLabelTTF* name = [CCLabelTTF labelWithString:NSLocalizedString(@"%randomGameName%", @"Game name") fontName:@"Marker Felt" fontSize:GAME_NAME_SIZE];
		name.position = ccp(SCREEN_CENTER.x, [CCDirector sharedDirector].winSize.height - name.contentSize.height*3);
		name.color = ccMAGENTA;
		[self addChild:name];
		
		enableSound = [CCMenuItemFont itemFromString:NSLocalizedString(@"Enable sound", @"Enable sound menu item")];
		disableSound = [CCMenuItemFont itemFromString:NSLocalizedString(@"Disable sound", @"Disable sound menu item")];
		CCMenuItemToggle* toggleSound = [CCMenuItemToggle itemWithTarget:self selector:@selector(toggleSound:) items:enableSound, disableSound, nil];
		
		BOOL soundDisabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"soundDisabled"];
		
		if (soundDisabled) {
			[[SimpleAudioEngine sharedEngine] setEnabled:NO];
			toggleSound.selectedIndex = 0;
		} else {
			[[SimpleAudioEngine sharedEngine] setEnabled:YES];
			toggleSound.selectedIndex = 1;
		}
		
		if (soundDisabled) {
			[[SimpleAudioEngine sharedEngine] setEnabled:NO];
			toggleSound.selectedIndex = 0;
		} else {
			[[SimpleAudioEngine sharedEngine] setEnabled:YES];
			toggleSound.selectedIndex = 1;
		}
		
		CCMenu* menu;
		
		if ([[NSUserDefaults standardUserDefaults] integerForKey:@"GameState"] != GSNotPlaying) {
			menu = [CCMenu menuWithItems:[CCMenuItemFont itemFromString:NSLocalizedString(@"New game", @"New game menu item") target:self selector:@selector(newGame)], 
					[CCMenuItemFont itemFromString:NSLocalizedString(@"Continue", @"Continue menu item") target:[Game sharedGame] selector:@selector(continueGame)],
					toggleSound, 
					nil];
		} else {
			menu = [CCMenu menuWithItems:[CCMenuItemFont itemFromString:NSLocalizedString(@"New game", @"New game menu item") target:self selector:@selector(newGame)], 
					toggleSound, 
					nil];
		}
		
		
		
		if ([AppDelegate gameCenterAvaliable] && [GKLocalPlayer localPlayer].authenticated) {
			[menu addChild:[CCMenuItemFont itemFromString:NSLocalizedString(@"Scores", @"Scores menu item") target:[Game sharedGame] selector:@selector(scores)]];
		}
		
		[menu alignItemsVertically];
		[self addChild:menu];
		
		
	}
	return self;
}

-(void)toggleSound:(id)sender {
	if ([(CCMenuItemToggle*)sender selectedItem] == enableSound) {
		[[SimpleAudioEngine sharedEngine] setEnabled:NO];
	} else {
		[[SimpleAudioEngine sharedEngine] setEnabled:YES];
	}
	[[NSUserDefaults standardUserDefaults] setBool:![SimpleAudioEngine sharedEngine].enabled forKey:@"soundDisabled"];
}

-(void)newGame {
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:SCENE_TRANSITION_TIME scene:[ModeSelection scene]]];
}

@end
