/*
 *  FileUtils.h
 *  MagicRocketsRemake
 *
 *  Created by Inf on 01.11.10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */
#ifndef FILE_UTILS_H
#define FILE_UTILS_H



inline static NSString* documentsFilePath(NSString* fileName) {
	struct NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
}

inline static NSString* bundlePath(NSString* fileName) {
	return [[NSBundle mainBundle] pathForResource:[fileName stringByDeletingPathExtension] ofType:[fileName pathExtension]];
}

inline static BOOL createDirectory(NSString* dirName) {
	return [[NSFileManager defaultManager] createDirectoryAtPath:dirName withIntermediateDirectories:YES attributes:nil error:nil];
}

#endif
