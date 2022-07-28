#include "Sword.h"
#include <thread>
#include <iostream>

#define SWORD 7 

Sword::Sword() {
    setPosX(0);
    setPosY(0);
    setTileId(SWORD);
}
Sword::Sword(int x, int y) {
    setPosX(x);
    setPosY(y);
    setTileId(SWORD);
}
Sword::~Sword() {}

void Sword::attack() {
    setActif(true);
    std::cout << "Actif = " << getActif() << "\n";

    std::cout << "wait for 2 seconds...";
    std::this_thread::sleep_for(std::chrono::milliseconds(2000));

    setActif(false);
    std::cout << "Actif = " << getActif() << "\n";
}

