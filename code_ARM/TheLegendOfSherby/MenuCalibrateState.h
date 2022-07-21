#include "StateGame.h"

class MenuCalibrateState : public StateGame {
public:
	MenuCalibrateState();
	~MenuCalibrateState();
	virtual void buttonPress();
	virtual void joystickButtonPress();
	virtual void joystickMove();
};



