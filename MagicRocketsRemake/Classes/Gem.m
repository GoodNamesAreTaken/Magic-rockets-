//
//  Gem.m
//  MagicRocketsRemake
//
//  Created by SwinX on 30.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Gem.h"
#import "Game.h"
#import "GameScene.h"
#import "RisingNotification.h"
#import "ViewPointsComponent.h"

@implementation Gem

+(Gem*)gem {
	return [[[self alloc] init] autorelease];
}

-(id)init {
	if ((self = [super initWithTextureName:@"Gem.png" andPositionAtField:[[Game sharedGame].bonusManager getFreePosition]])) {
		GemType type = arc4random()%GTAmount;
		switch (type) {
			case GTBlue:
				self.color = ccBLUE;
				points = BLUE_GEM_POINTS;
				break;
			case GTOrange:
				self.color = ccORANGE;
				points = ORANGE_GEM_POINTS;
				break;
			case GTMagenta:
				self.color = ccMAGENTA;
				points = MAGENTA_GEM_POINTS;
				break;
			case GTYellow:
				self.color = ccYELLOW;
				points = YELLOW_GEM_POINTS;
				break;
			default:
				NSLog(@"Something fucked up random T_T");
				return nil;
		}
	}
	return self;
}

-(void)collect {
	[[GameScene scene] addNodeToFrontLayer:[RisingNotification notificationWithText:[NSString stringWithFormat:@"+%d",points] position:self.position andSize:RISING_NOTIFICATION_SIZE]];
	[super collect];
}

-(CCFiniteTimeAction*)performAnimation {
	ViewPointsComponent* component = [[Game sharedGame].mode componentNamed:@"ViewPoints"];
	return [CCMoveTo actionWithDuration:BONUS_FLY_TIME position:[component pointsPosition]];
}

-(void)effect {
	[[Game sharedGame].mode handleEvent:@selector(pointsChangedBy:) withObject:[NSNumber numberWithInt:points]];
}

@end
