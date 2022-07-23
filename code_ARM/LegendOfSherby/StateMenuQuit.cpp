#include "StateMenuQuit.h"
#include "Game.h"

StateMenuQuit::StateMenuQuit() {}
StateMenuQuit::~StateMenuQuit() {}

Game StateMenuQuit::buttonPress(Game g) { return g; };
Game StateMenuQuit::joystickButtonPress(Game g) { return g; };

//si on move le joystick on va vers MenuCalibrate
Game StateMenuQuit::joystickMove(Game g) {
	//MenuCalibrateState calibrate(game);
	//game.changeState(calibrate);
	return g;
};
