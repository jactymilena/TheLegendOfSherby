#include "Game.h"
#include "Actor.h"
#include "Background.h"
#include "StateGame.h"

class Game
{
private:
	StateGame state;
	Actor registreActor[12];
	Background registreBackground[10];
	int currentBackground;

public:
	Game(){}
	~Game(){}

	void chageState(StateGame s){}
	void recieveControllerInfo(){}
	void detectCollision(){}

	Actor getActor(int i) { return registreActor[i]; }
	Background getCurrentBackground() { return registreBackground[currentBackground]; }

	void setCurrentBackground(int i) { currentBackground = i; }
	void removeLife(){}
};
