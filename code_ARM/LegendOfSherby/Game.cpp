#include "Game.h"

Game::Game() {}
Game::~Game() {}

void Game::changeState(StateGame s) {}
void Game::recieveControllerInfo() {}
void Game::detectCollision() {}

Actor Game::getActor(int i) { return registreActor[i]; }
Background Game::getCurrentBackground() { return registreBackground[currentBackground]; }

void Game::setCurrentBackground(int i) { currentBackground = i; }
void Game::removeLife() {}

