#include "MenuQuitState.h"
#include "Game.h"

class MenuQuitState : public StateGame {
protected:
	Game game;

public:
	MenuQuitState(Game g) { game = g; }
	MenuQuitState() {}
	~MenuQuitState() {}

	void buttonPress() {}
	void joystickButtonPress() {}
	void joystickMove() {}
};
