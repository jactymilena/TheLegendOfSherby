#include "StateGameOn.h"
#include "Game.h"

StateGameOn::StateGameOn() {}
StateGameOn::~StateGameOn() {}

Game StateGameOn::buttonPress(Game g) { return g; };
Game StateGameOn::joystickButtonPress(Game g) { return g; };
Game StateGameOn::joystickMove(Game g) { return g; };