//
//  Bonus.h
//  MagicRocketsRemake
//
//  Created by SwinX on 31.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"

/**
 Base bonus class.
 Provides fall finished and collect events
 */

@interface Bonus : GameObject {
	ccTime lifeTime;
	id blink;
}

/**
 Triggered when bonus finished falling.
 Adds bonus to bonus manager
 */
-(void)fallFinished;

/**
 Playing collect sound and collect animation
 This method must be extended in subclasses with game functionality
 */
-(void)collect;

-(CCFiniteTimeAction*)performAnimation;

-(CCFiniteTimeAction*)performEffect;

-(void)effect;

-(void)update:(ccTime)dt;

@end
