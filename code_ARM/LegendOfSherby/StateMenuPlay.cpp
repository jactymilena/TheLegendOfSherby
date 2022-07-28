#include "StateMenuPlay.h"
#include "Game.h"
#include "StateGameOn.h"
#include "StateMenuQuit.h"

StateMenuPlay::StateMenuPlay() {}
StateMenuPlay::~StateMenuPlay() {}

//when u click on button
Game StateMenuPlay::buttonPress(Game g) {
	StateGameOn gameOn();
	//g.changeState(gameOn);
	return g;
};

Game StateMenuPlay::joystickButtonPress(Game g) { return g; };

//si on move le joystick on va vers element quit
Game StateMenuPlay::joystickMove(Game g) {
	StateMenuQuit quitButton();
	//g.changeState(quitButton);
	return g;
};

