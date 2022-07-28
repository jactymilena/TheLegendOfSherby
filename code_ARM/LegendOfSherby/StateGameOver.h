#pragma once
#include "StateGame.h"

class StateGameOver : public StateGame {
public:
	StateGameOver();
	~StateGameOver();

	Game buttonPress(Game g);
	Game joystickButtonPress(Game g);
	Game joystickMove(Game g);
};



