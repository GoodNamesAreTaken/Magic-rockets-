//
//  FireworkManager.h
//  MagicRocketsRemake
//
//  Created by Inf on 31.08.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import "Firework.h"

/**
 A class that launches and observes fireworks
 */

@interface FireworkManager : NSObject {
	int activeFireworksCount;
}

@property(readonly) BOOL fireworksOnScene;

/**
 Launches random firework
 */
-(void)launchFirework;

/**
 This action triggers launched firework when it ends
 @param firework ended firework
 */
-(void)fireworkDestroyed:(Firework*)firework;

@end
