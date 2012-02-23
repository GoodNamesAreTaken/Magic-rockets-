//
//  Types.h
//  MagicRocketsRemake
//
//  Created by SwinX on 17.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

typedef enum _Difficulty {
	DEasy = 1,
	DNormal = 2,
	DHard = 3
}Difficulty;

typedef enum _GameState {
	GSNotPlaying = 0,
	GSPlayingClassic,
	GSPlayingTimeAttack,
	GSPlayingMatchBox
}GameState;

typedef enum _BrickType {
	BTTwoCorner = 0,
	BTTwoStraight,
	BTThree,
	BTFour,
	BTTypesAmount
}BrickType;

typedef enum _BrickState {
	BSNone = 0,
	BSConnectedToFire,
	BSConnectedToRocket,
	BSDead,
	BSDebug
}BrickState;

typedef enum _BrickOutlet {
	BOTopOutlet = 0,
	BORightOutlet,
	BOBottomOutlet,
	BOLeftOutlet,
	BOOutletsCount
}BrickOutlet;

typedef struct _PositionAtField {
	int row;
	int col;
}PositionAtField;

static inline PositionAtField posAtField(const int row, const int col) {
	PositionAtField p = {row, col};
	return p;
}