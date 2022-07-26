#include "HealtPoint.h"

#define COEUR_ROSE 1
#define COEUR_ROUGE 2

HealtPoint::HealtPoint() {
	setPosX(0);
	setPosY(0);
	setTileId(COEUR_ROUGE);
}

HealtPoint::HealtPoint(int x, int y) {
	setPosX(x);
	setPosY(y);
	setTileId(COEUR_ROUGE);
}
HealtPoint::~HealtPoint() {}