#include "MenuPlayState.h"
#include "Game.h"
#include "GameOnState.h"

class MenuPlayState : public StateGame {
protected:
	Game game;

public:
	MenuPlayState(Game g) { game = g; }
	~MenuPlayState() {}

	void buttonPress() {
		GameOnState gamon(game);
		game.chageState(gameon);
	}
	
	void joystickButtonPress() {}
	
	void joystickMove() {}
};


