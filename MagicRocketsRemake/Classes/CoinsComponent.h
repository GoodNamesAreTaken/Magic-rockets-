//
//  CoinsComponent.h
//  MagicRocketsRemake
//
//  Created by SwinX on 12.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModeComponent.h"


@interface CoinsComponent : ModeComponent {
	int coins;
}

@property(readonly) int coins;

-(void)coinsChangedBy:(NSNumber*)value;

@end
