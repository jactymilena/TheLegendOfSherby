#include "Link.h"
#include <ostream>

#define COEUR_ROSE 1
#define COEUR_ROUGE 2

Link::Link(int x, int y, Sword s) {
	setPosX(x);
	setPosY(y);
	sword = s;

	coeurs[0].setPosX(0);
	coeurs[0].setPosY(0);
	coeurs[1].setPosX(2);
	coeurs[1].setPosY(0);
	coeurs[2].setPosX(4);
	coeurs[2].setPosY(0);
}
Link::~Link() {}

// functions 
void Link::changeState(StateLink s) {}

// retourne 1 si game over
bool Link::loseHeart() {
	for (int i = sizeof(coeurs); i > 0; i--) {
		if (coeurs[i - 1].getTileId() == COEUR_ROUGE) {
			coeurs[i - 1].setTileId(COEUR_ROSE);
			
			if ((i - 1) == 0) {
				// game over
				return true; 
			} else { return false; }
		}
	}
	// game over	
	return true;
}
void Link::gainHeart() {
	for (int i = 0; i < sizeof(coeurs); i++) {
		if (coeurs[i].getTileId() == COEUR_ROSE) {
			coeurs[i].setTileId(COEUR_ROUGE);
			return;
		}
	}
}

HealtPoint* Link::getCoeurs() {
	return coeurs;
}

void Link::attack() {
	sword.attack();
}

void Link::setSwoard(Sword s) { sword = s; }
Sword Link::getSword() { return Sword(); }

void Link::deplacementGauche() {
	setPosX(getPosX() - 2);
	sword.setPosX(getPosX() - 1);
}
void Link::deplacementDroit() {
	setPosX(getPosX() + 2);
	sword.setPosX(getPosX() + 1);
}
void Link::deplacementHaut() {
	setPosY(getPosY() - 2);
	sword.setPosY(getPosY() - 1);
}
void Link::deplacementBas() {
	setPosY(getPosY() + 2);
	sword.setPosY(getPosY() + 1);
}