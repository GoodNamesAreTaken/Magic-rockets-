//
//  MagicRocketsRemakeAppDelegate.m
//  MagicRocketsRemake
//
//  Created by Troll ololo on 20.08.10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import <GameKit/GameKit.h>
#import "SimpleAudioEngine.h"
#import "AppDelegate.h"
#import "cocos2d.h"
#import "GameScene.h"
#import "MainMenu.h"
#import "Game.h"
#import "FileUtils.h"
#import "Skin.h"

#import "ModeSelection.h"

@interface AppDelegate()

-(void)postOfflineScore:(NSString*)leaderboardCategory;
-(void)postOfflineScores;

@end


@implementation AppDelegate

@synthesize window, rootViewController;

+(BOOL)gameCenterAvaliable {
	Class gcClass = NSClassFromString(@"GKLocalPlayer");
	
	NSString* requeriedVersion = @"4.1";
	NSString* systemVersion = [[UIDevice currentDevice] systemVersion];
	
	return gcClass && ([systemVersion compare:requeriedVersion options:NSNumericSearch] != NSOrderedAscending);
}

- (void) applicationDidFinishLaunching:(UIApplication*)application 
{
	
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	
	[CCDirector setDirectorType:kCCDirectorTypeDisplayLink];
	
	CCDirector *director = [CCDirector sharedDirector];
	
	rootViewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	rootViewController.wantsFullScreenLayout = YES;

	// Sets landscape mode
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
	
	// Turn on display FPS
	[director setDisplayFPS:YES];
	
	// Turn on multiple touches
	EAGLView *view = [EAGLView viewWithFrame:window.bounds pixelFormat:kEAGLColorFormatRGBA8//565 
								 depthFormat:0 
						  preserveBackbuffer:0 
								  sharegroup:nil 
							   multiSampling:NO
							 numberOfSamples:0];

	
	[view setMultipleTouchEnabled:YES];
	
	rootViewController.view = view;
	[director setOpenGLView:view];
	director.openGLView = view;
	
	[director setAnimationInterval:1.0f / 60.0f];
	
	[window addSubview:rootViewController.view];
	[window makeKeyAndVisible];
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	//initialisation
	
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Bomb.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Bonus.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Brick.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Coin.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Firework.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Fuse.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"HurryUp.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Launch.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"LevelUp.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Ready.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"TimeOver.caf"];
    
	//Uncomment this to play BGM.
	/*[[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"musicName"];
	[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"musicName" loop:YES];*/
	
	[Skin installFromFile:bundlePath(@"Default.skn")];
	
	[GameScene scene];
	[[GameScene scene] createFires]; //лучшего места для них не нашел :/
	[[Game sharedGame] loadGame];
	[[Game sharedGame] prepareGame];
	
	if ([[self class] gameCenterAvaliable]) {
		
		[[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError* error) {
			if (error) {
				UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Unable to login into gamecenter" message:[error localizedDescription] 
															   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				[alert release];
			} else {
				[self postOfflineScores];
			}

			[[CCDirector sharedDirector] runWithScene: [MainMenu scene]];
			//[[CCDirector sharedDirector] runWithScene:[ModeSelection scene]];
		}];
	} else {
		[[CCDirector sharedDirector] runWithScene: [MainMenu scene]];
		//[[CCDirector sharedDirector] runWithScene:[ModeSelection scene]];
	}
	
}


- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
	
	if (/*[[NSUserDefaults standardUserDefaults] boolForKey:@"Playing"]*/[Game sharedGame].state != GSNotPlaying) {
		[[Game sharedGame] saveGame];
	}
}

-(void)applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[[CCDirector sharedDirector] end];
	if (/*[[NSUserDefaults standardUserDefaults] boolForKey:@"Playing"]*/ [Game sharedGame].state != GSNotPlaying) {
		[[Game sharedGame] saveGame];
	}
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

#pragma mark Offline scores posting
-(void)postOfflineScores {
	[self postOfflineScore:@"uk.co.soulteam.magicRockets2.classic"];
	[self postOfflineScore:@"uk.co.soulteam.magicRockets2.timeattack"];
	[self postOfflineScore:@"uk.co.soulteam.magicRockets2.matchbox"];

}

-(void)postOfflineScore:(NSString *)leaderboardCategory {
	NSString* file = documentsFilePath(leaderboardCategory);
	GKScore* savedScore = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
	
	[savedScore reportScoreWithCompletionHandler:^(NSError* error) {
		if (!error) {
			[[NSFileManager defaultManager] removeItemAtPath:file error:nil];
		}
	}];
}

- (void)dealloc {
	[[CCDirector sharedDirector] release];
	[window release];
	[super dealloc];
}

@end
