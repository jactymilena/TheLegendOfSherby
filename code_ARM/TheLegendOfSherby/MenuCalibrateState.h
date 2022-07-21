#include "StateGame.h"

class MenuCalibrateState : public StateGame {
	MenuCalibrateState();
	~MenuCalibrateState();
	virtual void buttonPress();
	virtual void joystickButtonPress();
	virtual void joystickMove();
};



