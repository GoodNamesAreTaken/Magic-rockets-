//
//  Configuration.h
//  MagicRocketsRemake
//
//  Created by SwinX on 30.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

//#define DEBUG_GAME 1

#pragma mark Common
#define SCREEN_CENTER ccp([CCDirector sharedDirector].winSize.width/2, [CCDirector sharedDirector].winSize.height/2)
#define HURRY_UP_NOTIFICATION_TIME 15.0f
#define GAME_OVER_DELAY 5.0f
#define MATCHES_PER_LEVEL 10

#pragma mark Field dimensions
#define ROWS 9
#define COLS 6

#pragma mark Level parameters
#define TIME_PER_LEVEL 90.0f
#define ROCKETS_TO_LAUNCH_AT_FIRST_LEVEL 10

#pragma mark Brick 
#define ROTATION_SPEED 0.2f
#define ROTATION_ANGLE 90
#define MAX_ROTATIONS_AMOUNT 4
#define FALL_TIME 0.5f

#pragma mark Rockets parameters
#define MAX_ROCKET_LEVEL 10

#pragma mark Bonuses
#define BONUSES_AMOUNT 6
#define BONUS_LAYER 100
#define BONUS_FLY_TIME 0.7f
#define BONUS_LIFE_TIME 20.0f
#define BONUS_START_BLINK_TIME 10.0f
#define BONUS_BLINK_DURATION 0.5f

#pragma mark Bonuses avaliability

#ifndef DEBUG_GAME
#define GEM_AVALIABLE_LEVEL 3
#define BOMB_AVALIABLE_LEVEL 5
#define CLOCK_AVALIABLE_LEVEL 7
#define BONUS_CREATION_PROBABILITY 35 //Bonus creation probability. Formula is 1/probability, so the bigger value provides smaller probability
#else
#define GEM_AVALIABLE_LEVEL 1
#define BOMB_AVALIABLE_LEVEL 1
#define CLOCK_AVALIABLE_LEVEL 1
#define BONUS_CREATION_PROBABILITY 10
#endif


#pragma mark Bomb
#define BOMB_FALL_TIME 1.5f
#define BOMB_FALL_DISTANCE 2 //bricks amount bomb must fall

#pragma mark Gem
#define BLUE_GEM_POINTS	500
#define ORANGE_GEM_POINTS 1000
#define MAGENTA_GEM_POINTS 1500
#define YELLOW_GEM_POINTS 2000

#pragma mark Clock
#define CLOCK_TIME_BONUS 5

#pragma mark Double score 
#define DOUBLE_SCORE_TIME 10.0f

#pragma mark points
#define POINTS_PER_ROCKET 100
#define POINTS_PER_BRICK 5

#pragma mark upgrades
#define UPGRADE_COST 5
#define UPGRADE_COIN_FLY_TIME 0.3f

#pragma mark transitions 
#define SCENE_TRANSITION_TIME 0.5f

#pragma mark Fireworks
#define FIREWORKS_AMOUNT 5

#pragma mark Design
#define UI_OFFSET 15
#define FIRES_AMOUNT 4
#define REQUIRED_OFFSET 48
#define FIELD_BORDER_WIDTH 9

#pragma mark Labels
#define DEFAULT_INTERFACE_LABEL_FONT_SIZE 20 
#define LEVEL_SIZE 18
#define GROWING_NOTIFICATION_SIZE 24
#define RISING_NOTIFICATION_SIZE 20
#define GAME_NAME_SIZE 30

///NEW DEFINES

#define FADE_DURATION 0.5f


/*#define CCSpriteBatchNode CCSpriteSheet
#define CCParticleSystemQuad CCQuadParticleSystem
#define CCLabelTTF CCLabel
#define CCTransitionFade CCFadeTransition*/
