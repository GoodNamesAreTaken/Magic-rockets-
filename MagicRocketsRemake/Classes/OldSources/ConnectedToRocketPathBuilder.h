//
//  ConnectedToRocketPathBuilder.h
//  Rocket
//
//  Created by Inf on 18.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PathBuilder.h"
#import "Brick.h"

/**
 Subclass of PathBuilder, that performs path search from rockets to fire.
 
 Changes the state of bricks and path to BSConnectedToRocket or BSConnectedToBoth if pth is alsso connected to a fire.
 */
@interface ConnectedToRocketPathBuilder : PathBuilder {
	Brick* fireBrick;
}

/**
 The brick, that is connected to a fire.
 
 If it is not nil, that means that the path is connected to both fire and rocket. So, the spark should be launched.
 */
@property(readonly) Brick* fireBrick;

@end
