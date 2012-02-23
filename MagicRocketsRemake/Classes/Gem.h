//
//  Gem.h
//  MagicRocketsRemake
//
//  Created by SwinX on 30.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Bonus.h"

typedef enum _GemType {
	GTBlue = 0,
	GTOrange,
	GTMagenta,
	GTYellow,
	GTAmount
}GemType;

/**
 Gem that provides bonus points
 */
@interface Gem : Bonus {
	uint16_t points;
}
/**
 Creates random gem
 */
+(Gem*)gem;

@end
