//
//  PointsComponent.h
//  MagicRocketsRemake
//
//  Created by SwinX on 12.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModeComponent.h"
#import "cocos2d.h"

@interface PointsComponent : ModeComponent {
	int points;
	int multiplier;
	
	int lastPoints;
	
	ccTime doubleScoreRemainingTime;
}

@property int points;

-(void)pointsChangedBy:(NSNumber*)value;
-(void)doubleScore;

@end
