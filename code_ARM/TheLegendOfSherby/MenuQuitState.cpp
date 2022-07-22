#include "MenuQuitState.h"
#include "Game.h"
#include "MenuCalibrateState.h"
#include "GameOnState.h"

	MenuQuitState::MenuQuitState() {}
	MenuQuitState::MenuQuitState(Game g) { game = g; }
	MenuQuitState::~MenuQuitState() {}

	void MenuQuitState::buttonPress() {
	}
	void MenuQuitState::joystickButtonPress() {}

	//si on move le joystick on va vers MenuCalibrate
	void MenuQuitState::joystickMove() {
		MenuCalibrateState calibrate(game);
		game.changeState(calibrate);
	}

