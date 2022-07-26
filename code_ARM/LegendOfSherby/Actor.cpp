#include "Actor.h"

// Constructers
Actor::Actor() {}
Actor::Actor(int x, int y) {
	posX = x;
	posY = y;
}
Actor::~Actor() {}

// get functions
int Actor::getActorId() { return actorId; }
bool Actor::getActif() { return actif; }
int Actor::getPosX() { return posX; }
int Actor::getPosY() { return posY; }
int Actor::getTileId() { return tileId; }

// set functions
void Actor::setActorId(int aId) { actorId = aId; }
void Actor::setActif(bool a) { actif = a; }
void Actor::setPosX(int x) { posX = x; }
void Actor::setPosY(int y) { posY = y; }
void Actor::setTileId(int tId) { tileId = tId; }
