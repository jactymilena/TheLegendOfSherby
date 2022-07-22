#include "StateGame.h"

class MenuQuitState : public StateGame {
public:
	MenuQuitState();
	MenuQuitState(Game g);
	~MenuQuitState();

	void buttonPress();
	void joystickButtonPress();
	void joystickMove();
};

