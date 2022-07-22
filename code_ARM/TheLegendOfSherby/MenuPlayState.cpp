#include "MenuPlayState.h"
#include "Game.h"
#include "GameOnState.h"

class MenuPlayState : public StateGame {
protected:
	Game game;

public:
	MenuPlayState() {}
	MenuPlayState(Game g) { game = g; }
	~MenuPlayState() {}


	void buttonPress() {
		GameOnState gameOn(game);
		//game.changeState(gameOn);
	}
	
	void joystickButtonPress() {}
	
	void joystickMove() {}
};


