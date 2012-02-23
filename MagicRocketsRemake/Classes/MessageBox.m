//
//  MessageBox.m
//  MagicRocketsRemake
//
//  Created by SwinX on 09.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MessageBox.h"
#import "Configuration.h"
#import "Skin.h"

@interface MessageBox(Private)

-(void)removeSelfFromTouchDispatcher;

@end


@implementation MessageBox

+(MessageBox*)messageBoxWithMessage:(NSString*)_message target:(id)_target action:(SEL)_action {
	return [[[MessageBox alloc] initWithMessage:_message target:_target action:_action] autorelease];
}

-(id)initWithMessage:(NSString*)_message target:(id)_target action:(SEL)_action {
	if ((self = [super init])) {
		
		target = _target;
		action = _action;
		
		CCSprite* back = [CCSprite spriteWithFile:[[Skin currentSkin] textureNameFor:@"Backgrounds/MessageBoxBack.png"]];
		back.position = SCREEN_CENTER;
		[self addChild:back];
		
		message = [CCLabelTTF labelWithString:_message fontName:@"Marker Felt" fontSize:24];
		message.position = ccp(SCREEN_CENTER.x, SCREEN_CENTER.y + message.contentSize.height);
		[self addChild:message];
		
		CCMenuItem* yes = [CCMenuItemImage itemFromNormalImage:[[Skin currentSkin] textureNameFor:@"Interface/Buttons/Yes.png"] 
												 selectedImage:[[Skin currentSkin] textureNameFor:@"Interface/Buttons/Yes.png"]
														target:self selector:@selector(yes)];
		
		CCMenuItem* no = [CCMenuItemImage itemFromNormalImage:[[Skin currentSkin] textureNameFor:@"Interface/Buttons/No.png"]
												selectedImage:[[Skin currentSkin] textureNameFor:@"Interface/Buttons/No.png"]
													   target:self selector:@selector(no)];
		
		CCMenu* yesNo = [CCMenu menuWithItems:yes, no, nil];
		[self addChild:yesNo];
		[yesNo alignItemsHorizontallyWithPadding:20];
		yesNo.position = ccp(SCREEN_CENTER.x, SCREEN_CENTER.y - message.contentSize.height);
		
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:kCCMenuTouchPriority swallowsTouches:YES];
		
	}
	return self;
}

-(void)yes {
	[target performSelector:action];
	[self removeSelfFromTouchDispatcher];
}

-(void)no {
	[self removeSelfFromTouchDispatcher];
	[self.parent removeChild:self cleanup:YES];
}

-(void)removeSelfFromTouchDispatcher {
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	return YES;
}	

@end
