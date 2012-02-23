//
//  ClassicMode.h
//  MagicRocketsRemake
//
//  Created by SwinX on 11.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "ModeComponent.h"

@class ModeComponent;

@interface GameMode : NSObject {
	NSMutableDictionary* components;
}

+(id)gameMode;
+(id)classicMode;
+(id)timeAttackMode;
+(id)matchboxMode;

-(void)addComponent:(ModeComponent*)component named:(NSString*)name;

-(id)componentNamed:(NSString*)name;

-(void)removeComponentByName:(NSString*)name;

-(void)removeAllComponents;

-(void)handleEvent:(SEL)message;	
-(void)handleEvent:(SEL)message withObject:(id)object;

-(NSArray*)getIntefraceComponents;

@end
