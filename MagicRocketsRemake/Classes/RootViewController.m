    //
//  RootViewController.m
//  MagicRocketsRemake
//
//  Created by Inf on 01.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "RootViewController.h"


@implementation RootViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark Game Kit methods

-(void)openLeaderboards {
	GKLeaderboardViewController* leaderboards = [[GKLeaderboardViewController alloc] init];
	if (leaderboards != nil) {
		[[CCDirector sharedDirector] stopAnimation];
		leaderboards.leaderboardDelegate = self;
		[self presentModalViewController:leaderboards animated:YES];
	}
	
}

#pragma mark GKLeaderboardViewControllerDelegate

-(void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
	[[CCDirector sharedDirector] startAnimation];
	[self dismissModalViewControllerAnimated:YES];
	[viewController autorelease];
}


- (void)dealloc {
    [super dealloc];
}


@end
