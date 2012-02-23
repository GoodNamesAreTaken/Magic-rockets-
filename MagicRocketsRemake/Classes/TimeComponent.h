//
//  TimeComponent.h
//  MagicRocketsRemake
//
//  Created by SwinX on 13.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModeComponent.h"
#import "cocos2d.h"

@interface TimeComponent : ModeComponent {
	
	ccTime timeRemaining;
	
	BOOL hurryUpShown;
	
}

@property(readonly) float timeRemainingPart;

-(void)timeElapsed:(NSNumber *)dt;
-(void)timeChangedBy:(NSNumber*)dt;

@end
