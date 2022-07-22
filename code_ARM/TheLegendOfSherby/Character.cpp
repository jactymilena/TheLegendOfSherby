#include "Character.h"
#include "Actor.h"

class Character : public Actor {
private:
	int speed;

public:
	// constructers
	Character() { speed = 16; }
	~Character() {}

	// get and set function
	int getSpeed() { return speed; }
	void setSpeed(int s) { speed = s; }

	// other function
	void move(int direction) {
		switch (direction)
		{
		case 0:
			// aller vers la droite
			setPosX(getPosX() + 16);

		case 1:
			// aller vers la gauche
			setPosX(getPosX() - 16);

		case 2 :
			// aller vers le haut
			setPosY(getPosY() + 16);

		case 3:
			// aller vers le bas
			setPosY(getPosY() - 16);

		default:
			break;
		}
	}
};

