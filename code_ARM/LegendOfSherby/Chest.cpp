#include<thread>
#include "Chest.h"
#include <iostream>

#define CHEST_CLOSE 5
#define CHEST_OPEN 6

Chest::Chest(int x, int y) {
    setPosX(x);
    setPosY(y);
    setTileId(CHEST_CLOSE);
}
Chest::~Chest() {}


void Chest::openChest() {
    setTileId(CHEST_OPEN);
}