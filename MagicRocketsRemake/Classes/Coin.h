//
//  Coin.h
//  MagicRocketsRemake
//
//  Created by SwinX on 30.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Bonus.h"
#import "cocos2d.h"
#import "Configuration.h"

typedef enum _CoinNominal {
	CNOne = 1,
	CNTwo = 2,
	CNFive = 5,
	CNTen = 10
}CoinNominal;

/**
 Coin needed to upgrade rockets
 */
@interface Coin : Bonus {
	CoinNominal nominal;
}

/**
 Creates coin
 @param coinNominal nominal of the coin.
 */
+(Coin*)createWithNominal:(CoinNominal)coinNominal;

/**
 Initialises coin
 */
-(id)initWithNominal:(CoinNominal)coinNominal;

@end
