//
//  MagicRocketsRemakeAppDelegate.h
//  MagicRocketsRemake
//
//  Created by Troll ololo on 20.08.10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"RootViewController.h"

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	RootViewController* rootViewController;
}

+(BOOL)gameCenterAvaliable;

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) RootViewController* rootViewController;

@end
