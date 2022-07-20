#include "Actor.h"

class Actor {
private:
	int actorID;
	bool actif;
	int posX;
	int posY;
	int tileID;

public:
	// Constructers
	Actor() {}
	~Actor() {}

	// get functions
	int getActorId() { return actorID; }
	bool getActif() { return actif; }
	int getPosX() { return posX; }
	int getPosY() { return posY; }
	int getTileId() { return tileID; }

	// set functions
	void setActorId(int aId) { actorID = aId; }
	void setActif(bool a) { actif = a; }
	void setPosX(int x) { posX = x; }
	void setPosY(int y) { posY = y; }
	void setTileId(int tId) { tileID = tId; }
};
