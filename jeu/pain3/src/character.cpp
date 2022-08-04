#include "Character.h"

// constructers
Character::Character() { speed = 16; }
Character::~Character() {}

// get and set function
int Character::getSpeed() { return speed; }
void Character::setSpeed(int s) { speed = s; }

// other function
void Character::move(int direction) {
	switch (direction)
	{
	case 0:
		// aller vers la droite
		setPosX(getPosX() + 16);
	case 1:
		// aller vers la gauche
		setPosX(getPosX() - 16);
	case 2:
		// aller vers le haut
		setPosY(getPosY() + 16);

	case 3:
		// aller vers le bas
		setPosY(getPosY() - 16);
	default:
		break;
	}
}
