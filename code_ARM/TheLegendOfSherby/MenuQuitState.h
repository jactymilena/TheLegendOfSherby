#include "StateGame.h"

class MenuQuitState : public StateGame {
public:
	MenuQuitState();
	~MenuQuitState();
	virtual void buttonPress();
	virtual void joystickButtonPress();
	virtual void joystickMove();
};

