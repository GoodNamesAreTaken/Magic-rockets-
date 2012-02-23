//
//  Skin.m
//  MagicRocketsRemake
//
//  Created by Inf on 04.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <ZKFileArchive.h>

#import "Skin.h"
#import "FileUtils.h"

static Skin* defaultSkin = nil;
static Skin* currentSkin = nil;
@implementation Skin

+(id)defaultSkin {
	@synchronized(self) {
		if (!defaultSkin) {
			defaultSkin = [[[self class] alloc] initWithName:@"Default"];
		}
	}
	return defaultSkin;
}

+(id)currentSkin {
	if (!currentSkin) {
		return [[self class] defaultSkin];
	}
	return currentSkin;
}

+(void)setCurrentSkin:(Skin *)skin {
	@synchronized(self) {
		if (currentSkin != skin) {
			[currentSkin release];
			currentSkin = [skin retain];
			[[NSNotificationCenter defaultCenter] postNotificationName:SkinDidChangeNotification object:currentSkin];
		}
	}
}

+(void)installFromFile:(NSString*)fileName {
	NSString* skinName = [[fileName lastPathComponent] stringByDeletingPathExtension];
	NSString* installPath = documentsFilePath([@"skins" stringByAppendingPathComponent:skinName]);
	NSString* tempPath = [installPath stringByAppendingPathComponent:@"temp"];
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:installPath]) {
		if (createDirectory(tempPath)) {
			ZKFileArchive* archive = [ZKFileArchive archiveWithArchivePath:fileName];
			
			[archive inflateToDirectory:tempPath usingResourceFork:NO];
		}	
	}
	
	
}



+(id)skinWithName:(NSString*)skinName {
	return [[[self alloc] initWithName:skinName] autorelease];
}


-(id)initWithName:(NSString*)skinName {
	if ((self = [super init])) {
		basicDirectory = [documentsFilePath([@"skins" stringByAppendingPathComponent:skinName]) retain];
	}
	return self;
}

-(NSString*)textureNameFor:(NSString*)skinnable {
	NSString* fullPath = [basicDirectory stringByAppendingPathComponent:skinnable];
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:fullPath] && self != [[self class] defaultSkin]) {
		fullPath = [[[self class] defaultSkin] textureNameFor:skinnable];
	}
	return fullPath;
}

-(CCTexture2D*)textureFor:(NSString*)skinnable {
	return [[CCTextureCache sharedTextureCache] addImage: [self textureNameFor:skinnable]];
}

-(void)dealloc {
	[basicDirectory release];
	[super dealloc];
}


@end
