//
//  SparkWalker.h
//  Rocket
//
//  Created by Inf on 18.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PathBuilder.h"
#import "Field.h"

/**
 The subclass of PathBuilder, that launches sparks along it. 
 
 Launches sparks to each brick in path, starting to the fire side. After all sparks die, starts a rockets, if there was at least one brick, connected to rocket in path, or simply changes the state of a bricks back to BSNone, if
 no rockets can be launched.
 */
@interface SparkPathBuilder : PathBuilder {
}


@end
