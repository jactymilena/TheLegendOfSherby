#pragma once
#include "Character.h"
#include "HealtPoint.h"
#include "StateLink.h"
#include "Sword.h"

class Link : public Character {
private:
	HealtPoint coeurs[3];
	Sword sword;

public:
	int tileId = 10;

	// constructers
	Link(int x, int y, Sword s);
	~Link();

	// functions 
	void changeState(StateLink s);	
	bool loseHeart();
	void gainHeart();
	HealtPoint* getCoeurs();
	void attack();
	void setSwoard(Sword s);
	Sword getSword();
	void deplacementGauche();
	void deplacementDroit();
	void deplacementHaut();
	void deplacementBas();
};