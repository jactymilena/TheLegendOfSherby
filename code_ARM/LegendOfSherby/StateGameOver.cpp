#include "StateGameOver.h"
#include "Game.h"

StateGameOver::StateGameOver() {}
StateGameOver::~StateGameOver() {}

Game StateGameOver::buttonPress(Game g) { return g; };
Game StateGameOver::joystickButtonPress(Game g) { return g; };
Game StateGameOver::joystickMove(Game g) { return g; };

