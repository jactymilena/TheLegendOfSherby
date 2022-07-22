#include "StateGame.h"

class GameOvertState : public StateGame {
private:
	Game game;
public:
	GameOvertState();
	GameOvertState(Game g);
	~GameOvertState();
	
	void buttonPress();
	void joystickButtonPress();
	void joystickMove();
};

