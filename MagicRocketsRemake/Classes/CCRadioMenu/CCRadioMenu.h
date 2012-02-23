/* cocos2d for iPhone
 *
 * http://www.cocos2d-iphone.org
 *
 * Copyright (C) 2008,2009 Ricardo Quesada
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the 'cocos2d for iPhone' license.
 *
 * You will find a copy of this license within the cocos2d for iPhone
 * distribution inside the "LICENSE" file.
 *
 */

#import "CCMenu.h"

#define NOTHING_WAS_SELECTED -1

@interface CCRadioMenu : CCMenu {
	int selectedItemIndex;
	int fallBackItemIndex;
}

@property int selectedItemIndex;
@property int fallBackItemIndex;


-(CCMenuItem *) itemForTouch: (UITouch *) touch;

/**
 My modification. Needs tests.
 */
-(void)enable;
-(void)disable;

@end