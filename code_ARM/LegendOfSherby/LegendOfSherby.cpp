#include "Sword.h"
#include <string>
#include <iostream>
#include <thread>
#include "Chest.h"
#include "Actor.h"
using namespace std;

void func(string txt)
{
    cout << " function func displays : " << txt;
}

int main()
{
    cout << "Start game!\n";

    Chest c(0, 0);
    cout << "TileId du chest fermee = " << c.getTileId() << "\n";
    
    

    Sword s(0, 0);

    int cx = c.getPosX();
    int cy = c.getPosY();
    int sx = s.getPosX();
    int sy = s.getPosY();
   
    
    
    s.attack();
    if ((sx == cx) && (sy == cy)) {
        c.openChest();
        cout << "TileId du chest ouvert = " << c.getTileId() << "\n";
    }

    

}

