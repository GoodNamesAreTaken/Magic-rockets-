//
//  ViewTimeComponent.h
//  MagicRocketsRemake
//
//  Created by SwinX on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewComponent.h"
#import "ProgressBar.h"

@interface ViewTimeComponent : ViewComponent {
	ProgressBar* progressBar;
}

-(void)timeUpdated;

-(CGPoint)progressBarPosition;

@end
