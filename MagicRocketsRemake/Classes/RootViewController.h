//
//  RootViewController.h
//  MagicRocketsRemake
//
//  Created by Inf on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>


@interface RootViewController : UIViewController<GKLeaderboardViewControllerDelegate> {

}

-(void)openLeaderboards;

@end
