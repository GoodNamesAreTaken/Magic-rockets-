//
//  GrowingNotification.m
//  MagicRocketsRemake
//
//  Created by SwinX on 15.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GrowingNotification.h"


@implementation GrowingNotification

-(void)addAnimations {
	self.scale = 0.0f;
	self.color = ccRED;
	[self runAction: [CCSequence actions:
					  [CCScaleTo actionWithDuration:1.0f scale:3.0f],
					  [CCScaleTo actionWithDuration:1.0f scale:0.0f],
					  [CCCallFunc actionWithTarget:self selector:@selector(animationFinished)],
					  nil
					  ]
	 ];
}

@end
