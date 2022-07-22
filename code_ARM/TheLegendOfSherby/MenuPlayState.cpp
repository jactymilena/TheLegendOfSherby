#include "MenuPlayState.h"
#include "Game.h"
#include "GameOnState.h"
#include "MenuQuitState.h"

class MenuPlayState : public StateGame {
protected:
	Game game;

public:
	MenuPlayState() {}
	MenuPlayState(Game g) { game = g; }
	~MenuPlayState() {}

	//when u click 
	void buttonPress() {
		GameOnState gameOn(game);
		game.changeState(gameOn);
	}
	
	void joystickButtonPress() {}
	
	//si on move le joystick on va vers element quit
	void joystickMove() {
		MenuQuitState quitButton(game);
		game.changeState(quitButton);
	}
};


