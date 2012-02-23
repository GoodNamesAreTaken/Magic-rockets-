//
//  Firework.h
//  MagicRocketsRemake
//
//  Created by Inf on 31.08.10.
//  Copyright 2010 Soulteam. All rights reserved.
//

#import <OpenAL/al.h>
#import "cocos2d.h"
#import "Configuration.h"

@class FireworkManager;
@interface Firework : CCParticleSystemQuad {
	FireworkManager* manager;
	
	ALuint soundSource;
}

@property ALuint soundSource;

/**
 Creates firework
 @param file firework configuration file
 @param manager firework manager
 */
+(id)fireworkWithFile:(NSString*)file manager:(FireworkManager*)fireworkManager;
-(id)initWithFile:(NSString *)plistFile manager:(FireworkManager*)fireworkManager;

@end
