#pragma once
#include "StateLink.h"

class IdleState : public StateLink {
	IdleState();
	~IdleState();

	void animation();
};

