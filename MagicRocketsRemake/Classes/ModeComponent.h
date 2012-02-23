//
//  ModeComponent.h
//  MagicRocketsRemake
//
//  Created by SwinX on 12.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "ModeComponentProtocol.h"

@class GameMode;

@interface ModeComponent : NSObject<ModeComponentProtocol> {
	GameMode* owner;
}

@property(assign) GameMode* owner;

+(id)component;
-(void)componentAdded;
-(void)componentRemoved;

@end
