#pragma once
#include "Actor.h"

class Character : public Actor {
private:
	int speed;

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
