//
//  ScoreReporterComponent.h
//  MagicRocketsRemake
//
//  Created by Inf on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModeComponent.h"


@interface ScoreReporterComponent : ModeComponent {
	NSString* category;
}

@property(retain) NSString* category;

+(id)componentWithCategory:(NSString*)category;
-(id)initWithCategory:(NSString*)category;

@end
