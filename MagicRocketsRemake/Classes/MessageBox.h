//
//  MessageBox.h
//  MagicRocketsRemake
//
//  Created by SwinX on 09.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"


@interface MessageBox : CCLayer {
	CCLabelTTF* message;
	
	id target;
	SEL action;
}	

+(MessageBox*)messageBoxWithMessage:(NSString*)_message target:(id)_target action:(SEL)_action;
-(id)initWithMessage:(NSString*)_message target:(id)_target action:(SEL)_action;

@end
