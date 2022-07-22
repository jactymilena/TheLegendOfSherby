#include "StateGame.h"
#include "Game.h"

class StateGame {
protected:
	Game game;

public:
	StateGame() {}
	StateGame(Game g) {}
	~StateGame() {}

	void setGame(Game g) { game = g; }
	Game getGame() { return game; }

	void buttonPress() {};
	void joystickButtonPress() {};
	void joystickMove() {};
};


