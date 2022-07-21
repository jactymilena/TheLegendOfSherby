#include "Actor.h"
#include "Background.h"

class Game
{
public:
	Game();
	~Game();
	void chageState(StateGame s);
	void recieveControllerInfo();
	void detectCollision();
	Actor getActor(int i);
	Background getCurrentBackground();
	void setCurrentBackground(Background b);
	void removeLife();
};

