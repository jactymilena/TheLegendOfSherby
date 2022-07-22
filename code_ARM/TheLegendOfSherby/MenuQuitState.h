#include "StateGame.h"

class MenuQuitState : public StateGame {
private:
	Game game;
public:
	MenuQuitState();
	MenuQuitState(Game g);
	~MenuQuitState();

	void buttonPress();
	void joystickButtonPress();
	void joystickMove();
};

