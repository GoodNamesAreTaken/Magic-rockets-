//
//  ConnctedToFirePathBuilder.h
//  Rocket
//
//  Created by Inf on 18.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PathBuilder.h"

/**
 The subclass of PathBuilder, that performs path search from fire to rockets.
 Changes the state of bricks in path.
 */

@interface ConnctedToFirePathBuilder : PathBuilder {
	
}

-(void) brickAddedToPath:(Brick*)brick;
-(BOOL) canGoThrought:(Brick*)brick;

@end
