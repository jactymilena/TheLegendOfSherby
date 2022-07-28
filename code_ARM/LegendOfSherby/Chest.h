#pragma once
#include "Actor.h"

class Chest : public Actor {
public:
	Chest(int x, int y);
	~Chest();
	void openChest();
};

