#pragma once
class Game;

class StateGame {
private:

public:
	StateGame();
	~StateGame();

	virtual Game buttonPress(Game g) = 0;
	virtual Game joystickButtonPress(Game g) = 0;
	virtual Game joystickMove(Game g) = 0;
};

