#include "Enemy.h"
#define ENEMY 8

Enemy::Enemy() {
	setPosX(0);
	setPosY(0);
	setTileId(ENEMY);
}
Enemy::Enemy(int x, int y) {
	setPosX(x);
	setPosY(y);
	setTileId(ENEMY);
}
Enemy::~Enemy() {}
