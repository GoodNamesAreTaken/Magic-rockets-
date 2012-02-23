//
//  ViewTimeComponent.m
//  MagicRocketsRemake
//
//  Created by SwinX on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewTimeComponent.h"
#import "Configuration.h"
#import "TimeComponent.h"
#import "GameMode.h"
#import "Skin.h"

@implementation ViewTimeComponent

-(id)init {
	if ((self = [super init])) {
		progressBar = [ProgressBar progressBarWithFullImage:[[Skin currentSkin] textureNameFor:@"Interface/ProgressFull.png"] 
												 emptyImage:[[Skin currentSkin] textureNameFor:@"Interface/ProgressEmpty.png"]  
											     bordersImage:[[Skin currentSkin] textureNameFor:@"Interface/ProgressBorders.png"]];
		progressBar.position = ccp([CCDirector sharedDirector].winSize.width/2, progressBar.height*0.5);									
		[view addChild:progressBar];
	}
	return self;
}

-(void)timeUpdated {
	TimeComponent* component = [owner componentNamed:@"Time"];
	if (component) {
		[progressBar setProgress:component.timeRemainingPart];
	}
}

-(CGPoint)progressBarPosition {
	return progressBar.position;
}

@end
