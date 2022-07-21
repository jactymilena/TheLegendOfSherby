#include "StateGame.h"
#include "Game.h"

class StateGame {
protected:
	Game game;

public:
	StateGame(){}
	~StateGame(){}
	virtual void buttonPress() = 0;
	virtual void joystickButtonPress() = 0;
	virtual void joystickMove() = 0;
};


