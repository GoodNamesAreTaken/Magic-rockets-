//
//  Brick.m
//  MagicRocketsRemake
//
//  Created by SwinX on 02.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SimpleAudioEngine.h"
#import "Configuration.h"
#import "Brick.h"
#import "Game.h"
#import "Skin.h"

@interface Brick(Private)

-(void)setOutletsTop:(BOOL)top right:(BOOL)right bottom:(BOOL)bottom left:(BOOL)left;
-(void)setFutureOutletsTop:(BOOL)top right:(BOOL)right bottom:(BOOL)bottom left:(BOOL)left;
-(void)rotationFinished;
-(void)rotateOutlets:(int)rotationsAmount;
+(BrickType)getRandomBrickType;

@end


@implementation Brick
@synthesize type;
@synthesize state;


+(Brick*)newBrick {
	return [[[self alloc] initWithPositionAtField:posAtField(0, 0)] autorelease];
}

+(Brick*)newBrickAt:(PositionAtField)_positionAtField {
	return [[[self alloc] initWithPositionAtField:_positionAtField] autorelease];
}	


-(id)initWithPositionAtField:(PositionAtField)_positionAtField {
	
	type = [Brick getRandomBrickType];
	NSString* skinKey = [NSString stringWithFormat:@"Brick%d.png",type];
	if ((self = [super initWithTextureName:skinKey andPositionAtField:_positionAtField])) {
		switch (type) {
			case BTTwoCorner:
				[self setOutletsTop:YES right:YES bottom:NO left:NO];
				[self setFutureOutletsTop:YES right:YES bottom:NO left:NO];
				break;
			case BTTwoStraight:
				[self setOutletsTop:NO right:YES bottom:NO left:YES];
				[self setFutureOutletsTop:NO right:YES bottom:NO left:YES];
				break;
			case BTThree:
				[self setOutletsTop:NO right:YES bottom:YES left:YES];
				[self setFutureOutletsTop:NO right:YES bottom:YES left:YES];
				break;
			case BTFour:
				[self setOutletsTop:YES right:YES bottom:YES left:YES];
				[self setFutureOutletsTop:YES right:YES bottom:YES left:YES];
				break;
			default:
				NSLog(@"Unknown type");
				break;
		}
		
		rotationsCount = arc4random() % 4; //brick 4 sides;
		self.rotation = ROTATION_ANGLE * rotationsCount;  //resulting angle
		[self rotateOutlets:rotationsCount];
		
	}
	return self;
}

-(void)rotate {
	[[SimpleAudioEngine sharedEngine] playEffect:@"Brick.caf"];
	[self setFutureOutletsTop:futureOutlets[BOLeftOutlet] right:futureOutlets[BOTopOutlet] bottom:futureOutlets[BORightOutlet] left:futureOutlets[BOBottomOutlet]];
	
	rotationsCount++;
	if (rotationsCount == MAX_ROTATIONS_AMOUNT) {
		rotationsCount = 0;
	}
	
	[[CCActionManager sharedManager] removeAllActionsFromTarget:self];
	[self runAction:[CCSequence actions:[CCRotateTo actionWithDuration:ROTATION_SPEED angle:ROTATION_ANGLE * rotationsCount],
					   [CCCallFunc actionWithTarget:self selector:@selector(rotationFinished)],
					   nil]
	 ];

}

-(void)rotationFinished {
	for (int i=0; i<BOOutletsCount; i++) {
		outlets[i] = futureOutlets[i];
	}
	[[Game sharedGame].field updateBricks];
	[[Game sharedGame].mode handleEvent:@selector(brickRotated:) withObject:self];
}


-(void)fallFinished {
	[super fallFinished];
	[[Game sharedGame].field brickFinishedFalling:self];
}


-(BOOL)canConnectTo:(Brick*)other from:(BrickOutlet)outlet {
	BOOL hasOppositeOutlet;
	
	switch(outlet) {
		case BOLeftOutlet:
			hasOppositeOutlet = [other hasOutlet:BORightOutlet];
			break;
		case BORightOutlet:
			hasOppositeOutlet = [other hasOutlet:BOLeftOutlet];
			break;
		case BOTopOutlet:
			hasOppositeOutlet = [other hasOutlet:BOBottomOutlet];
			break;
		case BOBottomOutlet:
			hasOppositeOutlet = [other hasOutlet:BOTopOutlet];
			break;
		default:
			NSLog(@"Invalid exit");
			return NO;
	}
	return [self hasOutlet:outlet] && hasOppositeOutlet;
}

-(BOOL)hasOutlet:(BrickOutlet)outlet {
	return outlets[outlet];
}

-(void)setState:(BrickState)newState {
	state = newState;
	
	switch (state) {
		case BSNone:
			[self makeIndependant];
			break;
		case BSConnectedToFire:
			[self makeConnectedToFire];
			break;
		case BSConnectedToRocket:
			[self makeConnectedToRocket];
			break;
		case BSDead:
			[self makeConnectedToBoth];
			break;
		default:
			break;
	}
	
}

-(void)setOutletsTop:(BOOL)top right:(BOOL)right bottom:(BOOL)bottom left:(BOOL)left {
	outlets[BOTopOutlet] = top;
	outlets[BORightOutlet] = right;
	outlets[BOBottomOutlet] = bottom;
	outlets[BOLeftOutlet] = left;
}

-(void)setFutureOutletsTop:(BOOL)top right:(BOOL)right bottom:(BOOL)bottom left:(BOOL)left {
	futureOutlets[BOTopOutlet] = top;
	futureOutlets[BORightOutlet] = right;
	futureOutlets[BOBottomOutlet] = bottom;
	futureOutlets[BOLeftOutlet] = left;
}

//View part method realisations
-(void)makeConnectedToFire {
	[self setColor:ccc3(255, 0, 0)];
}

-(void)makeConnectedToRocket {	
	[self setColor:ccc3(255, 255, 0)];
}

-(void)makeConnectedToBoth {
	[self setColor:ccc3(0,255, 0)];
}

-(void)makeIndependant {
	[self setColor:ccc3(255, 255, 255)];
}

-(BOOL)pointInside:(CGPoint)point {
	CGRect rect = CGRectMake(self.position.x - self.contentSize.width*0.5, self.position.y - self.contentSize.height*0.5, self.contentSize.width, self.contentSize.height);
	return CGRectContainsPoint(rect, point);
}

-(float)width {
	return self.contentSize.width;
}

-(float)height {
	return self.contentSize.height;	
}

-(void)rotateOutlets:(int)rotationsAmount {
	for (int i=0; i<rotationsAmount; i++) {
		[self setOutletsTop:outlets[BOLeftOutlet] right:outlets[BOTopOutlet] bottom:outlets[BORightOutlet] left:outlets[BOBottomOutlet]];
	}
	[self setFutureOutletsTop:outlets[BOTopOutlet] right:outlets[BORightOutlet] bottom:outlets[BOBottomOutlet] left:outlets[BOLeftOutlet]];
}

+(BrickType)getRandomBrickType {
	
	BrickType type;
	
	int rand = arc4random()%30;
	
	if (rand < 15) {
		type = BTTwoStraight;
	} else if (rand < 25) {
		type = BTTwoCorner;
	} else if (rand < 28){
		type = BTThree;
	} else {
		type = BTFour;
	}
	
	return type; 
}


@end
