#include "Game.h"
#include "Actor.h"
#include "Background.h"
#include "StateGame.h"
#include <cstdio>

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

	void changeState(StateGame s){}
	void recieveControllerInfo(){}
	void detectCollision(){}

	Actor getActor(int i) { return registreActor[i]; }
	Background getCurrentBackground() { return registreBackground[currentBackground]; }

	void setCurrentBackground(int i) { currentBackground = i; }
	void removeLife(){}

	static int main() {
		printf("allo");
	}
};
