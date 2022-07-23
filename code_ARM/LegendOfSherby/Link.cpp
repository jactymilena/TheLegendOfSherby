#include "Link.h"

#define TILEID_COEURROSE 1
#define TILEID_COEURROUGE 2

Link::Link() {
	/*for (int i = 0; i < sizeof(coeurs); i++) {
		HealtPoint hp;
		coeurs[i] = hp;
	}*/
}
Link::~Link() {}

// functions 
void Link::changeState(StateLink s) {}
void Link::attack() {}

// retourne 1 si game over
bool Link::loseHeart() {
	/*for (int i = sizeof(coeurs); i > 0; i--) {
		if (coeurs[i - 1].getTileId == TILEID_COEURROUGE) {
			coeurs[i - 1].setTileId(TILEID_COEURROSE);
			return false;
		}
	}*/
	// game over	
	return true;
}
void Link::gainHeart() {
	/*for (int i = 0; i < sizeof(coeurs); i++) {
		if (coeurs[i].getTileId == TILEID_COEURROUGE) {
			coeurs[i].setTileId(TILEID_COEURROSE);
		}
	}*/
}

