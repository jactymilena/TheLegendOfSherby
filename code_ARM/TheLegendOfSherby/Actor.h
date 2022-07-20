class Actor {
public:
	// Constructers
	Actor();
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