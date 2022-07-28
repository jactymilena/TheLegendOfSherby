#pragma once
#include "StateGame.h"

class StateMenuQuit : public StateGame {
	StateMenuQuit();
	~StateMenuQuit();

	Game buttonPress(Game g);
	Game joystickButtonPress(Game g);
	Game joystickMove(Game g);
};

