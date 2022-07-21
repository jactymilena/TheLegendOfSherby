#include "StateGame.h"

class GameOnState : public StateGame {
	GameOnState();
	~GameOnState();
	virtual void buttonPress();
	virtual void joystickButtonPress();
	virtual void joystickMove();
};