//
//  Clock.m
//  MagicRocketsRemake
//
//  Created by SwinX on 14.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TimeBoost.h"
#import "BonusManager.h"
#import "Game.h"
#import "Configuration.h"
#import "GameScene.h"
#import "RisingNotification.h"
#import "ViewTimeComponent.h"

@implementation TimeBoost

+(TimeBoost*)clock {
	return [[[self alloc] initWithTextureName:@"Clock.png" andPositionAtField:[[Game sharedGame].bonusManager getFreePosition]] autorelease];
}

-(CCFiniteTimeAction*)performAnimation {
	[[GameScene scene] addNodeToFrontLayer:[RisingNotification notificationWithText:[NSString stringWithFormat:@"+%d %@",CLOCK_TIME_BONUS, NSLocalizedString(@"seconds", @"seconds")] position:self.position andSize:RISING_NOTIFICATION_SIZE]];
	ViewTimeComponent* component = [[Game sharedGame].mode componentNamed:@"ViewTime"];
	return [CCMoveTo actionWithDuration:BONUS_FLY_TIME position:[component progressBarPosition]];
}

-(void)effect {
	[[Game sharedGame].mode handleEvent:@selector(timeChangedBy:) withObject:[NSNumber numberWithFloat:CLOCK_TIME_BONUS]];
}

@end
