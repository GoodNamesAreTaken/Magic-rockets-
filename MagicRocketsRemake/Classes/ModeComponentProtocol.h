//
//  ComponentProtocol.h
//  MagicRocketsRemake
//
//  Created by SwinX on 13.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Rocket.h"
#import "Bonus.h"
#import "Spark.h"
#import "Brick.h"
#import "Firework.h"

#import "cocos2d.h"

/**
 Протокол содержит события, которые могут принимать компоненты
 */
@protocol ModeComponentProtocol

@optional

/**
 Общие события, относящиеся к игровому процессу в целом.
 */
#pragma mark Common game events
-(void)newGame;	//+
-(void)saveGame;	//+
-(void)loadGame;	//+
-(void)gameOver;	//+


/**
 События, связанные непосредственно с игровым уровнем
 */
#pragma mark Level events
-(void)levelStarted; //нужен ли? -
-(void)levelEnded;	//+
-(void)levelUp;	//+

/**
 События, относящиеся к смене числовых параметров
 */
#pragma mark Parameter changes
-(void)timeElapsed:(NSNumber*)dt;
-(void)timeChangedBy:(NSNumber*)dt; //+
-(void)pointsChangedBy:(NSNumber*)value;	//+
-(void)coinsChangedBy:(NSNumber*)value;	//+
-(void)doubleScore;
-(void)doubleScoreFinished;

#pragma mark Parameter update complete
/**
 События, связанные с изменением числовых параметров игры в модели
 */
-(void)pointsUpdated;
-(void)coinsUpdated;
-(void)timeUpdated;
-(void)matchesCountUpdated;
-(void)rocketsCountUpdated;
-(void)levelNumberUpdated;

/**
 События, связанные с событиями с игровыми объектами
 */
#pragma mark Events with game objects
-(void)brickRotated:(Brick*)brick;	//+
-(void)fuseBurned;
-(void)sparkMoved:(Spark*)spark;
-(void)rocketLaunched:(Rocket*)rocket;
-(void)bonusAppeared:(Bonus*)bonus;
-(void)bonusCollected:(Bonus*)bonus;
-(void)fireworkExploded:(Firework*)firework;

/**
 Сообытия, связанные с исчезновением объектов в игре
 */
#pragma mark Events related to objects disappeaing
-(void)sparksGone;
-(void)rocketsGone;
-(void)fireworksGone;

@end
