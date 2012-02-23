//
//  Rocket.h
//  MagicRocketsRemake
//
//  Created by SwinX on 27.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@class RocketManager;
@interface Rocket : CCSprite {
	CCParticleSun* fire;
	
	int positionAtField;
	
	RocketManager* manager;
}

@property(readonly) int row;

/**
 Creates rocket
 @param level future rocket's level
 @param row row where rocket located
 @param manager reference to a rocket manager
 */
+(Rocket*)rocketWithLevel:(int)level AtRow:(int)row manager:(RocketManager*)manager;

/**
 Initialises rocket
 */
-(id)initWithlevel:(int)level andRow:(int)row manager:(RocketManager*)_manager;

/**
 Launches rocket
 */
-(void)launch;

@end
