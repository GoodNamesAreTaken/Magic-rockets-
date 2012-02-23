//
//  ModeSelectionScene.m
//  MagicRocketsRemake
//
//  Created by SwinX on 04.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModeSelection.h"
#import "Configuration.h"
#import "Types.h"
#import "MainMenu.h"
#import "MessageBox.h"
#import "Skin.h"

@interface ModeSelection(Private)

-(void)swapSprites;
-(void)changeSpriteTo:(NSString*)sprite;
-(void)selectedState:(GameState)state; 
-(BOOL)pressedSameButton;
-(void)newGameAccepted;

@end


@implementation ModeSelection

+(id)scene {
	CCScene* scene = [CCScene node];
	ModeSelection* layer = [ModeSelection node];
	[scene addChild:layer];
	return scene;
}

-(id)init {
	if ((self = [super init])) {
		
		frontImage = [CCSprite spriteWithFile:[[Skin currentSkin] textureNameFor:@"Backgrounds/DefaultBack.png"]];
		frontImage.position = SCREEN_CENTER;
		[self addChild:frontImage];
		CCMenuItem* classic = [CCMenuItemImage itemFromNormalImage:[[Skin currentSkin] textureNameFor:@"Interface/Buttons/Classic.png"] 
													 selectedImage:[[Skin currentSkin] textureNameFor:@"Interface/Buttons/ClassicSel.png"]
															target:self selector:@selector(classicSelected)];
		
		CCMenuItem* timeAttack = [CCMenuItemImage itemFromNormalImage:[[Skin currentSkin] textureNameFor:@"Interface/Buttons/TimeAttack.png"]
														selectedImage:[[Skin currentSkin] textureNameFor:@"Interface/Buttons/TimeAttackSel.png"]  
															target:self selector:@selector(timeAttackSelected)];
		
		CCMenuItem* matchBox = [CCMenuItemImage itemFromNormalImage:[[Skin currentSkin] textureNameFor:@"Interface/Buttons/MatchBox.png"] 
													  selectedImage:[[Skin currentSkin] textureNameFor:@"Interface/Buttons/MatchBoxSel.png"]
															target:self selector:@selector(matchBoxSelected)];
		
		modeSelectionMenuPart = [CCRadioMenu menuWithItems:classic, timeAttack, matchBox, nil];
		[modeSelectionMenuPart alignItemsHorizontally];
		[self addChild:modeSelectionMenuPart];
		[self reorderChild:modeSelectionMenuPart z:INT_MAX];
		
		ok = [CCMenuItemImage itemFromNormalImage:[[Skin currentSkin]textureNameFor:@"Interface/Buttons/OkActive.png"]
									selectedImage:[[Skin currentSkin]textureNameFor:@"Interface/Buttons/OkSel.png" ]
									disabledImage:[[Skin currentSkin]textureNameFor:@"Interface/Buttons/OkInactive.png"]
									target:self selector:@selector(ok)];
		ok.isEnabled = NO;
		CCMenuItem* back = [CCMenuItemImage itemFromNormalImage:[[Skin currentSkin]textureNameFor:@"Interface/Buttons/Back.png"] 
												  selectedImage:[[Skin currentSkin]textureNameFor:@"Interface/Buttons/BackSel.png"]
														target:self selector:@selector(back)];
		CCMenu* navigationMenuPart = [CCMenu menuWithItems:ok, back, nil];
		
		[navigationMenuPart alignItemsHorizontally];
		navigationMenuPart.position = ccp(100, 100);
		[self addChild:navigationMenuPart];
		[self reorderChild:navigationMenuPart z:INT_MAX-1];
	}
	return self;
}

-(void)classicSelected {
	[self selectedState:GSPlayingClassic];
}

-(void)timeAttackSelected {
	[self selectedState:GSPlayingTimeAttack];
}

-(void)matchBoxSelected {
	[self selectedState:GSPlayingMatchBox];
}

-(void)selectedState:(GameState)state {
	if (![self pressedSameButton]) {
		ok.isEnabled = YES;
		[modeSelectionMenuPart disable];
		futureState = state;
		NSString* sprite;
		switch (state) {
			case GSPlayingClassic:
				sprite = [[Skin currentSkin] textureNameFor:@"Backgrounds/ClassicBack.png"];
				break;
			case GSPlayingTimeAttack:
				sprite = [[Skin currentSkin] textureNameFor:@"Backgrounds/TimeAttackBack.png"];
				break;
			case GSPlayingMatchBox:
				sprite = [[Skin currentSkin] textureNameFor:@"Backgrounds/MatchBoxBack.png"];
				break;
			default:
				NSLog(@"Unhandled state");
				return;
		}
		[self changeSpriteTo:sprite];
	}
}

-(void)ok {
	//
	if ([Game sharedGame].state != GSNotPlaying) {
		MessageBox* mb = [MessageBox messageBoxWithMessage:@"Start new game?" target:self action:@selector(newGameAccepted)];
		[self addChild:mb];
		[self reorderChild:mb z:INT_MAX];
	} else {
		[self newGameAccepted];
	}

}

-(void)back {
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:SCENE_TRANSITION_TIME scene:[MainMenu scene]]];
}

-(void)newGameAccepted {
	[[Game sharedGame] newGame:futureState];
}

//Private

-(BOOL)pressedSameButton {
	return modeSelectionMenuPart.selectedItemIndex == modeSelectionMenuPart.fallBackItemIndex;
}

-(void)changeSpriteTo:(NSString*)sprite {
	[self removeChild:backImage cleanup:YES];
	backImage = [CCSprite spriteWithFile:sprite];
	backImage.position = SCREEN_CENTER;
	backImage.opacity = 0.0f;
	[self addChild:backImage];
	[self swapSprites];
}

-(void)swapSprites  {
	[frontImage runAction:[CCFadeOut actionWithDuration:FADE_DURATION]];
	[backImage runAction:[CCSequence actions:[CCFadeIn actionWithDuration:FADE_DURATION],
						  [CCCallFunc actionWithTarget:self selector:@selector(fadeInOutComplete)],
						  nil]
	 ];
}

-(void)fadeInOutComplete {
	CCSprite* temp = backImage;
	backImage = frontImage;
	frontImage = temp;
	[modeSelectionMenuPart enable];
}

@end
