#include "GameOnState.h"
#include "Game.h"

class GameOnState : public StateGame {
protected:
	Game game;

public:	
	GameOnState() {}
	GameOnState(Game g) { game = g; }
	~GameOnState() {}

	//when u click on button
	void buttonPress() {}

	//when u click on joystick button
	void joystickButtonPress() {}

	//when u move the joystick
	void joystickMove() {}
};
