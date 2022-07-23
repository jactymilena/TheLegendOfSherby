#include "Actor.h"

class Actor {
private:
	int actorId;
	bool actif;
	int posX;
	int posY;
	int tileId;

public:
	// Constructers
	Actor() {}
	~Actor() {}

	// get functions
	int getActorId() { return actorId; }
	bool getActif() { return actif; }
	int getPosX() { return posX; }
	int getPosY() { return posY; }
	int getTileId() { return tileId; }

	// set functions
	void setActorId(int aId) { actorId = aId; }
	void setActif(bool a) { actif = a; }
	void setPosX(int x) { posX = x; }
	void setPosY(int y) { posY = y; }
	void setTileId(int tId) { tileId = tId; }
};
