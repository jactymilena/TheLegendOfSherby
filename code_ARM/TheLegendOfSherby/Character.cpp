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
	void move() {}
	void die() {}

};

