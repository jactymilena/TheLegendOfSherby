#pragma once
#include "Character.h"
#include "HealtPoint.h"
#include "StateLink.h"

class Link : public Character {
private:
	HealtPoint coeurs[3];
public:
	// constructers
	Link();
	~Link();

	// functions 
	void changeState(StateLink s);
	void attack();
	bool loseHeart();
	void gainHeart();
};