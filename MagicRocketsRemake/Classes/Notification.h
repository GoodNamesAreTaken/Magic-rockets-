//
//  Notification.h
//  MagicRocketsRemake
//
//  Created by SwinX on 15.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Configuration.h" 

/**
 A base class for animated text in game.
 The behaviour of text (animations) must be redefined in subclasses.
 */

@interface Notification : CCLabelTTF {

}

/**
 Create notification.
 @param text notification text
 @param pos text screen position
 @param size text size
 */
+(Notification*)notificationWithText:(NSString*)text position:(CGPoint)pos andSize:(float)size;

/**
 Initialise notification.
 @param text notification text
 @param pos text screen position
 @param size text size
 */
-(id)initWithText:(NSString*)text andPosition:(CGPoint)pos andSize:(float)size;

/**
 Adds animation to the text. This method is called in base init, so you don't need to call it obviously.
 Must be redefined in subclasses.
 */
-(void)addAnimations;

@end
