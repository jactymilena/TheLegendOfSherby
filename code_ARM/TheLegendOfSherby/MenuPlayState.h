#include "StateGame.h"

class MenuPlayState : public StateGame {
public:
	MenuPlayState();
	~MenuPlayState();
	virtual void buttonPress();
	virtual void joystickButtonPress();
	virtual void joystickMove();
};

