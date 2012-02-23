//
//  ScoreReporterComponent.m
//  MagicRocketsRemake
//
//  Created by Inf on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import <GameKit/GameKit.h>


#import "ScoreReporterComponent.h"
#import "GameMode.h"
#import "PointsComponent.h"
#import <CoreFoundation/CoreFoundation.h>
#include "FileUtils.h"

@interface ScoreReporterComponent()

-(void)postScore;

@end


@implementation ScoreReporterComponent
@synthesize category;

+(id)componentWithCategory:(NSString*)category {
	return [[[self alloc] initWithCategory:category] autorelease];
}

-(id)initWithCategory:(NSString*)_category {
	if ((self = [super init])) {
		self.category = _category;
	}
	return self;
}

-(void)levelEnded {
	[self postScore];
}

-(void)gameOver {
	[self postScore];
}

-(void)postScore {
	int64_t score = [[self.owner componentNamed:@"Points"] points];
	
	GKScore* reporter = [[[GKScore alloc] initWithCategory:self.category] autorelease];
	
	
	reporter.value =  score;
	
	
	[reporter reportScoreWithCompletionHandler:^(NSError* error) {
		if (error) {
			NSLog(@"Score reporting error: %@", error);
			NSString* scoreSavePath = documentsFilePath(self.category);
			[NSKeyedArchiver archiveRootObject:reporter toFile:scoreSavePath];
		}
	}];
}
@end
