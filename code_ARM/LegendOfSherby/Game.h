#pragma once
#include "Actor.h"
#include "Background.h"
#include "StateGame.h"

class Game {
private:
	StateGame* ptr_state;
	Actor registreActor[12];
	Background registreBackground[10];
	int currentBackground;

public:
	Game();
	~Game();

	Actor getActor(int i);
	Background getCurrentBackground();
	void setCurrentBackground(int i);

	void changeState(StateGame* ptr_s);
	void recieveControllerInfo();
	void detectCollision();
	void removeLife();
};

	