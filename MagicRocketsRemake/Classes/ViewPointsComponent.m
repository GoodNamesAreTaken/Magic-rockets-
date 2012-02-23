//
//  ViewPointsComponent.m
//  MagicRocketsRemake
//
//  Created by SwinX on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewPointsComponent.h"
#import "PointsComponent.h"
#import "GameMode.h"
#import "Positions.h"

@implementation ViewPointsComponent

-(id)init {
	if ((self = [super init])) {
		points = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:DEFAULT_INTERFACE_LABEL_FONT_SIZE];
		points.position = ccp(POINTS_X_POSITION, [CCDirector sharedDirector].winSize.height - points.contentSize.height/2);
		[view addChild:points];
	}
	return self;
}
-(void)pointsUpdated {
	PointsComponent* component = [owner componentNamed:@"Points"];
	if (component) {
		[points setString:[NSString stringWithFormat:@"%d",component.points]]; 
	}
}
-(void)doubleScore {
	[points setColor:ccRED];
}

-(void)doubleScoreFinished {
	[points setColor:ccWHITE];
}

-(void)newGame {
	[points setColor:ccWHITE];
}

-(void)levelUp {
	[points setColor:ccWHITE];
}

-(CGPoint)pointsPosition {
	return points.position;
}
	
@end
