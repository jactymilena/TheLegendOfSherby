#include "StateGame.h"

class MenuPlayState : public StateGame {
public:
	MenuPlayState();
	MenuPlayState(Game g);
	~MenuPlayState();

	void buttonPress();
	void joystickButtonPress();
	void joystickMove();
};

