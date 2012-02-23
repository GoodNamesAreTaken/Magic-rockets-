//
//  RisingNotification.m
//  MagicRocketsRemake
//
//  Created by SwinX on 15.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RisingNotification.h"


@implementation RisingNotification

-(void)addAnimations {
	self.color = ccc3(50, 192, 148);
	[self runAction: [CCSequence actions:
					  [CCMoveBy actionWithDuration:1.0 position:ccp(0, self.contentSize.height)],
					  [CCCallFunc actionWithTarget:self selector:@selector(animationFinished)],
					  nil
					  ]
	  ];
}

@end
