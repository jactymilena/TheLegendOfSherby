#include "Link.h"
#include "Character.h"

#define TILEID_COEURROSE 1
#define TILEID_COEURROUGE 2

class Link : public Character {
private:
	StateCharacter state;
	PointDeVie coeurs[3];

public:

	// constructers
	Link() {
		for (int i = 0; i < sizeof(coeurs); i++) {
			coeurs[i] = new PointDeVie();
		}
	}
	~Link() {}

	// functions 
	void changeState(StateCharacter s) {}
	void attack() {}

	// retourne 1 si game over
	bool loseHeart() {
		for (int i = sizeof(coeurs); i > 0; i--) {
			if (coeurs[i - 1].getTileId == TILEID_COEURROUGE) {
				coeurs[i - 1].setTileId(TILEID_COEURROSE);
				return false;
			}
		}
		// game over	
		return true;
	}

	void gainHeart() {
		for (int i = 0; i < sizeof(coeurs); i++) {
			if (coeurs[i].getTileId == TILEID_COEURROUGE) {
				coeurs[i].setTileId(TILEID_COEURROSE);
			}
		}
	}

};
