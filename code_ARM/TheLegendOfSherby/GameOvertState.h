#include "StateGame.h"

class GameOvertState : public StateGame {
	GameOvertState();
	~GameOvertState();
	virtual void buttonPress();
	virtual void joystickButtonPress();
	virtual void joystickMove();
};

