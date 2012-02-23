//
//  FinisherComponent.h
//  MagicRocketsRemake
//
//  Created by SwinX on 13.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModeComponent.h"


@interface FinisherComponent : ModeComponent {
	
	BOOL levelFinished;
	BOOL gameOver;
	
	BOOL fireworksGone;
	BOOL rocketsGone;
	BOOL sparksGone;
}

@property(readonly) BOOL levelFinished;

-(void)newGame;

-(void)levelUp;

-(void)levelEnded;
-(void)gameOver;

-(void)rocketLaunched:(Rocket *)rocket;
-(void)fireworkExploded:(Firework *)firework;
-(void)fuseBurned;

-(void)sparksGone;
-(void)rocketsGone;
-(void)fireworksGone;



@end
