//
//  LevelProgress.h
//  Match4
//
//  Created by Inf on 24.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

/**
 A progress bar. Progress value varies from 0 to 1.
 Progress bar created from 3 images - full(top), empty(bottom) and borders images.
 When progress decreases, progress bar recalculates the visible part of full image and put it above the empty image.
 */
@interface ProgressBar : CCNode {
	CCSprite* empty;
	CCSprite* full;
	CCSprite* borders;
	float progress;
}
@property float progress;

@property(readonly) float width;
@property(readonly) float height;

/**
 Creates a progress bar with full progress
 @param fullImage full image of the progress bar
 @param emptyImage emptyImage of the progress bar
 @param borders borders image of the progress bar
 */
+(id)progressBarWithFullImage:(NSString*)fullImage emptyImage:(NSString*)emptyImage bordersImage:(NSString*)bordersImage;
-(id)initWithFullImage:(NSString*)fullImage emptyImage:(NSString*)emptyImage andBordersImage:(NSString*)bordersImage;

@end
