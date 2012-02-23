//
//  CollectBonusEffect.m
//  MagicRocketsRemake
//
//  Created by SwinX on 16.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CollectBonusEffect.h"
#import "Skin.h"


@implementation CollectBonusEffect

+(CollectBonusEffect*)effectAt:(CGPoint)collectPosition {
	NSString* effectPath  = [[Skin currentSkin] textureNameFor:@"Interface/BonusEffect.plist"];
	return [[[self alloc] initWithFile:effectPath andPosition:collectPosition] autorelease];
}
 
-(id)initWithFile:(NSString*)name andPosition:(CGPoint)pos {
	if ((self = [super initWithFile:name])) {
		self.position = pos;
		self.autoRemoveOnFinish = YES;
	}
	return self;
}

@end
