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
	/*
		tileId définition
		link down		(attack):		tileId = 1
		link front		(idle):			tileId = 2
		link left:		(attack)		tileId = 3
		link right:		(attack)		tileId = 4
		link top:		(attack)		tileId = 5
	*/
	int tileId = 2;

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