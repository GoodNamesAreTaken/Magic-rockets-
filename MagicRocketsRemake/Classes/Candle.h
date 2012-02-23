//
//  Fire.h
//  MagicRocketsRemake
//
//  Created by SwinX on 16.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Configuration.h"

@interface Candle : CCNode {
	CCSprite* candle;
	CCSprite* fire;
	
	CCSpriteBatchNode* spriteSheet;
}

/**
 Creates a new candle
 */
+(Candle*)candle;
-(id)init;

-(float)width;
-(float)height;

@end
