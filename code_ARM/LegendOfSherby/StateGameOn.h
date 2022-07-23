#pragma once
#include "StateGame.h"

class StateGameOn : public StateGame {
public:
	StateGameOn();
	~StateGameOn();

	Game buttonPress(Game g);
	Game joystickButtonPress(Game g);
	Game joystickMove(Game g);
};

