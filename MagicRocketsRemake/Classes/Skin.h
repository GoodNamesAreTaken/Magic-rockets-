//
//  Skin.h
//  MagicRocketsRemake
//
//  Created by Inf on 04.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

#define SkinDidChangeNotification @"SkinDidChangeNotification"

@interface Skin : NSObject {
	NSString* basicDirectory;
}

+(id)defaultSkin;

+(id)currentSkin;

+(void)installFromFile:(NSString*)fileName;

+(void)setCurrentSkin:(Skin*)skin;

+(id)skinWithName:(NSString*)skinName;
-(id)initWithName:(NSString*)skinName;
-(NSString*)textureNameFor:(NSString*)skinnable;
-(CCTexture2D*)textureFor:(NSString*)skinnable;

@end
