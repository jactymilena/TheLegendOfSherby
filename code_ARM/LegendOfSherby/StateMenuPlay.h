#pragma once
#include "StateGame.h"

class StateMenuPlay : public StateGame {
public:
	StateMenuPlay();
	~StateMenuPlay();

	Game buttonPress(Game g);
	Game joystickButtonPress(Game g);
	Game joystickMove(Game g);
};



