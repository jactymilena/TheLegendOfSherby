#include "Sword.h"
#include <string>
#include <iostream>
#include <thread>
#include "Chest.h"
#include "Link.h"
#include "Enemy.h"
#include "Game.h"
using namespace std;


Link Chest LinkAttack(Link l, Chest c) {
    cout << "Link Attack\n";

    l.attack();
    if ((c.getPosX() == l.getSword().getPosX()) && (c.getPosY() == l.getSword().getPosY())) {
        cout << "Sword and Chest in the same tile, so open chest\n";
        c.openChest();
        cout << "Tile chest ouvert = " << c.getTileId() << "\n";
    }

}

bool collisionLinkEnemy(Link l , Enemy e) {
    if ((l.getPosX() == e.getPosX()) && (l.getPosY() == e.getPosY())) {
        cout << "Collision between Link and Enemy detected\n";
        if (l.loseHeart()) {
            cout << "Link has no more hp\n";
            cout << "GAME OVER\n";
            return true;
        }
    }
    return false;
}

void displayLink(Link l) {
    cout << "============================================================\n";
    cout << "Link\n";
    cout << "============================================================\n";
    HealtPoint* hp_p = l.getCoeurs();

    for (int i = 0; i < 3; i++) {
        cout << "Tile coeur " << i << " : ";
        cout << (*(hp_p + i)).getTileId() << endl;
    }

    cout << "============================================================\n";
    cout << "Fin Link\n";
    cout << "============================================================\n\n";
}




/////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN
/////////////////////////////////////////////////////////////////////////////////////////////////

int main()
{
    cout << "Start game!\n\n";
    Game game();

    cout << "Ajout d'un chest : ";
    Chest chest(0, 0);
    cout << "Tile chest fermee = " << chest.getTileId() << "\n\n";
    
    cout << "Ajout de Link avec son epee\n";

    Sword s(0, 0);
    Link link(0, 0, s);
    displayLink(link);

    LinkAttack(link, chest);


    cout << "\nAjout d'un enemy\n";
    Enemy enemy(6, 6);
    collisionLinkEnemy(link, enemy);

    cout << "\nDeplacement de Link\n";
    link.setPosX(6);
    link.setPosY(6);
    collisionLinkEnemy(link, enemy);
    displayLink(link);
    collisionLinkEnemy(link, enemy);
    displayLink(link);
    collisionLinkEnemy(link, enemy);
    displayLink(link);
    

}



