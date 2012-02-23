//
//  LevelProgress.m
//  Match4
//
//  Created by Inf on 24.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProgressBar.h"


@implementation ProgressBar
@synthesize progress;

@synthesize width, height;

+(id)progressBarWithFullImage:(NSString*)fullImage emptyImage:(NSString*)emptyImage bordersImage:(NSString*)bordersImage {
	return [[self alloc] initWithFullImage:fullImage emptyImage:emptyImage andBordersImage:bordersImage];
}

-(id)initWithFullImage:(NSString*)fullImage emptyImage:(NSString*)emptyImage andBordersImage:(NSString*)bordersImage {
	if ((self = [super init])) {
		full = [CCSprite spriteWithFile:fullImage];
		empty = [CCSprite spriteWithFile:emptyImage];
		borders = [CCSprite spriteWithFile:bordersImage];
	
		
		NSAssert(full.contentSize.width == empty.contentSize.width && full.contentSize.height == empty.contentSize.height, @"Sizes of full and empty images must be equal");
		[full setAnchorPoint:ccp(0, 0)];
		
		[empty addChild:full];
		[self setContentSize:full.contentSize];
		
		[self addChild:empty];
		[self addChild:borders];
		progress = 1.0f;
	}
	return self;
}

-(void)setProgress:(float)value {
	progress = clampf(value, 0.0f, 1.0f);
	CGRect rect = empty.textureRect;
	
	rect.size.width *= progress;
	
	[full setTextureRect:rect];
}

-(float)width {
	return full.contentSize.width;
}

-(float)height {
	return full.contentSize.height;
}

@end
