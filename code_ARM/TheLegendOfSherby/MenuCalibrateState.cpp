#include "MenuCalibrateState.h"
#include "Game.h"

class MenuCalibrateState : public StateGame {
protected:
	Game game;

public:
	MenuCalibrateState() {}
	MenuCalibrateState(Game g) { game = g; }
	~MenuCalibrateState() {}

	void buttonPress() {}
	void joystickButtonPress() {}
	void joystickMove() {}
};