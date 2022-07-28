#pragma once
class Actor {
private:
	int actorId;
	bool actif;
	int posX;
	int posY;
	int tileId;

public:
	// Constructers
	Actor();
	Actor(int x, int y);
	~Actor();

	// get functions
	int getActorId();
	bool getActif();
	int getPosX();
	int getPosY();
	int getTileId();

	// set functions
	void setActorId(int aId);
	void setActif(bool a);
	void setPosX(int x);
	void setPosY(int y);
	void setTileId(int tId);
};