#include "StateGame.h"

class GameOvertState : public StateGame {
public:
	GameOvertState();
	GameOvertState(Game g);
	~GameOvertState();
	
	void buttonPress();
	void joystickButtonPress();
	void joystickMove();
};

