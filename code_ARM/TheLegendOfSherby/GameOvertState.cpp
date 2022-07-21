#include "GameOvertState.h"
#include "Game.h"

class GameOvertState : public StateGame {
protected:
	Game game;
	
public:
	GameOvertState(Game g) { game = g; }
	~GameOvertState() {}
	void buttonPress() {}
	void joystickButtonPress() {}
	void joystickMove() {}
};
