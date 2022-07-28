#pragma once
#include "Actor.h"

class Sword : public Actor
{
public:
	Sword();
	Sword(int x, int y);
	~Sword();
	void attack();
};

