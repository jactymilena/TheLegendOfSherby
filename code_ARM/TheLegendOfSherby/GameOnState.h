#include "StateGame.h"

class GameOnState : public StateGame {
public:
	GameOnState();
	GameOnState(Game g);
	~GameOnState();

	void buttonPress();
	void joystickButtonPress();
	void joystickMove();
};