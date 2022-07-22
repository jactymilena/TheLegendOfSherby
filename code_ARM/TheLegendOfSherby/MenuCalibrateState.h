#include "StateGame.h"

class MenuCalibrateState : public StateGame {
public:
	MenuCalibrateState();
	MenuCalibrateState(Game g);
	~MenuCalibrateState();

	void buttonPress();
	void joystickButtonPress();
	void joystickMove();
};



