//
//  CollectBonusEffect.h
//  MagicRocketsRemake
//
//  Created by SwinX on 16.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Configuration.h"

/**
 Effect that appears when player collects bonus or when upgrade coin flied to rocket
 */
@interface CollectBonusEffect : CCParticleSystemQuad {
}

/**
 Create effect at position
 */
+(CollectBonusEffect*)effectAt:(CGPoint)collectPosition;

/**
 Initialises effect
 */
-(id)initWithFile:(NSString*)name andPosition:(CGPoint)pos;

@end
