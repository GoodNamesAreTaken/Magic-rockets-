//
//  BonusCreationConitions.h
//  MagicRocketsRemake
//
//  Created by SwinX on 25.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Bonus.h"

@interface BonusCreationConitions : NSObject {
	int levelNumber;
}

-(BOOL)canCreateBonus:(Bonus*)bonus;
-(BOOL)canCreateCoins;

@end
