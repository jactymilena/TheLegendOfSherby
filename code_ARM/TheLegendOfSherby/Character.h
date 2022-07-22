#include "Actor.h"

class Character : public Actor {
public:
	// constructers
	Character();
	~Character();

	// get and set function
	int getSpeed();
	void setSpeed(int s);

	// other function
	void move(int direction);
};