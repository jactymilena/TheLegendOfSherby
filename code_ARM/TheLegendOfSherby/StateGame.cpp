#include "StateGame.h"
#include "Game.h"

	StateGame::StateGame() {}
	StateGame::StateGame(Game g) {}
	StateGame::~StateGame() {}

	void StateGame::setGame(Game g) { game = g; }
	Game StateGame::getGame() { return game; }

	void StateGame::buttonPress() {};
	void StateGame::joystickButtonPress() {};
	void StateGame::joystickMove() {};
