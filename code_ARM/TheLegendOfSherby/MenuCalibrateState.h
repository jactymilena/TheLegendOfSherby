#include "StateGame.h"

class MenuCalibrateState : public StateGame {
private:
	Game game;
public:
	MenuCalibrateState();
	MenuCalibrateState(Game g);
	~MenuCalibrateState();

	void buttonPress();
	void joystickButtonPress();
	void joystickMove();
};



