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

	virtual void buttonPress() = 0;
	virtual void joystickButtonPress() = 0;
	virtual void joystickMove() = 0;
};


