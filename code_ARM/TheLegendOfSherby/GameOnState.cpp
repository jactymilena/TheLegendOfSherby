#include "GameOnState.h"
#include "Game.h"

class GameOnState : public StateGame {
protected:
	Game game;

public:	
	GameOnState() {}
	GameOnState(Game g) { game = g; }
	~GameOnState() {}

	void buttonPress() {}
	void joystickButtonPress() {}
	void joystickMove() {}
};
