//
//  ConnctedToFirePathBuilder.m
//  Rocket
//
//  Created by Inf on 18.11.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ConnctedToFirePathBuilder.h"

@implementation ConnctedToFirePathBuilder

-(void)brickAddedToPath:(Brick*)brick {
	brick.state = BSConnectedToFire;
}

-(BOOL) canGoThrought:(Brick*)brick {
	return brick.state == BSNone;
}

@end
