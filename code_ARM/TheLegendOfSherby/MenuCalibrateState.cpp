#include "MenuCalibrateState.h"
#include "Game.h"
#include "MenuPlayState.h"
#include "GameOnState.h"

	MenuCalibrateState::MenuCalibrateState() {}
	MenuCalibrateState::MenuCalibrateState(Game g) { game = g; }
	MenuCalibrateState::~MenuCalibrateState() {}

	//pop the calibrate effect
	void MenuCalibrateState::buttonPress() {
	}

	void MenuCalibrateState::joystickButtonPress() {}

	void MenuCalibrateState::joystickMove() {
		GameOnState on(game);
		game.changeState(on);
	}
