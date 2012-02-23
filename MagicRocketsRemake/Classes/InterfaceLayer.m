//
//  FrontLayer.m
//  MagicRocketsRemake
//
//  Created by SwinX on 09.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "InterfaceLayer.h"
#import "Game.h"
#import "GameScene.h"
#import "Configuration.h"
#import "Positions.h"
#import "RisingNotification.h"
#import "GrowingNotification.h"

@interface InterfaceLayer(Private)

-(void)showNotification:(NSString*)notificationText;
-(void)notificationShown;

@end

@implementation InterfaceLayer

-(id)init {
	if ((self = [super init])) {
		
		self.isTouchEnabled = YES;
		//Top menu part
		
		CCLabelTTF* label = [CCLabelTTF labelWithString:NSLocalizedString(@"Menu", @"Menu name") fontName:@"Marker Felt" fontSize:24];
		label.color = ccBLUE;
		CCMenuItemFont* menuItem = [CCMenuItemFont itemWithLabel:label target:[Game sharedGame] selector:@selector(mainMenu)];
		menu = [[CCMenu menuWithItems:menuItem, nil] retain];
		menu.position = ccp([CCDirector sharedDirector].winSize.width - menuItem.contentSize.width, [CCDirector sharedDirector].winSize.height - label.contentSize.height/2);
		[self addChild:menu];
	 
	}
	return self;
}	

-(void)launchedRockets:(int)amount {
	if (amount < 3) { //unremarkable cases
		return;
	}
	
	NSString* text = @"";
	switch (amount) {
		case 3:
			text = NSLocalizedString(@"Tripple launch!", @"Tripple launch notification");
			break;
		case 4:
			text = NSLocalizedString(@"Quadriple launch!", @"Quadriple launch notification");
			break;
			
		default:
			text = NSLocalizedString(@"Ultra Launch!", @"Ultra launch notification");
			break;
	}
	
	CGPoint pos = ccp([CCDirector sharedDirector].winSize.width/2, [CCDirector sharedDirector].winSize.height/2 + 30);
	
	[self addChild: [RisingNotification notificationWithText:text position:pos andSize:RISING_NOTIFICATION_SIZE]];
}

-(void)launchedRocket:(Rocket*)rocket atRow:(int)row forPoints:(int)pointsForRocket {
	CGPoint pos = [[GameScene scene] getScreenPositionForRocket:rocket at:row];
	[self addChild: [RisingNotification notificationWithText:[NSString stringWithFormat:@"+%d", pointsForRocket] position:pos andSize:RISING_NOTIFICATION_SIZE]];
}
	
-(void)levelUp {
	[self addChild:[GrowingNotification notificationWithText:NSLocalizedString(@"Level up!", @"Level up notification") position:SCREEN_CENTER andSize:GROWING_NOTIFICATION_SIZE]];
}

-(void)hurryUp {
	[self addChild:[GrowingNotification notificationWithText:NSLocalizedString(@"Hurry up!", @"Hurry up notification") position:SCREEN_CENTER andSize:GROWING_NOTIFICATION_SIZE]];
}

-(void)upgrading {
	[self addChild:[GrowingNotification notificationWithText:NSLocalizedString(@"Upgrading", @"Upgrading notification") position:SCREEN_CENTER andSize:GROWING_NOTIFICATION_SIZE]];
}

-(void)gameOver {
	[self addChild:[GrowingNotification notificationWithText:NSLocalizedString(@"GameOver", @"Game over notification") position:SCREEN_CENTER andSize:GROWING_NOTIFICATION_SIZE]];
}

-(void)hideMenu {
	[self removeChild:menu cleanup:YES];
}

-(void)showMenu {
	[self addChild:menu];
}	

-(CGPoint)coinSpritePosition {
	return ccp(COINS_X_POSITION, [CCDirector sharedDirector].winSize.height - 15);
}	

-(void)dealloc {
	[menu release];
	[super dealloc];
}

@end
