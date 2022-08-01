#include "Sword.h"
#include <string>
#include <iostream>
#include <thread>
#include "Chest.h"
#include "Link.h"
#include "Enemy.h"
#include "Game.h"
using namespace std;

// faire le scroll


bool collision(int x1, int y1, int x2, int y2) {
    bool condition1 = ((x1 - 16) <= x2) && (x2 <= (x1 + 16)); // x1-16 < x2 < x1+16
    bool condition2 = ((y1 - 16) <= y2) && (y2 <= (y1 + 16)); // y1-16 < y2 < y1+16

    if (condition1 && condition2) {
        return true;
    }
    else {
        return false;
    }
}

void LinkAttack(Link* l, Chest* c, Enemy* e) {
    cout << "Link Attack\n";

    l->attack();
    // detection collision avec chest
    //if ((c->getPosX() == l->getSword().getPosX()) && (c->getPosY() == l->getSword().getPosY())) {
    if (collision(c->getPosX(), c->getPosY(), l->getPosX(), l->getPosY())) {
        std::cout << "Sword and Chest in the same tile, so open chest\n";
        c->openChest();        
    }

    // detection collision avec enemy
    if (collision(e->getPosX(), e->getPosY(), l->getSword().getPosX(), l->getSword().getPosY())) {}
}

bool collisionLinkEnemy(Link* l , Enemy* e) {
    if ((l->getPosX() == e->getPosX()) && (l->getPosY() == e->getPosY())) {
        cout << "Collision between Link and Enemy detected\n";
        if (l->loseHeart()) {
            cout << "Link has no more hp\n";
            cout << "GAME OVER\n";
            return true;
        }
    }
    else {
        cout << "No collision between Link and Enemy detected\n";
    }
    
    return false;
}

void displayLink(Link* l) {
    std::cout << "============================================================\n";
    std::cout << "Link\n";
    std::cout << "============================================================\n";
    HealtPoint* hp_p = l->getCoeurs();

    for (int i = 0; i < 3; i++) {
        std::cout << "Tile coeur " << i << " : ";
        std::cout << (*(hp_p + i)).getTileId() << endl;
    }

    std::cout << "============================================================\n";
    std::cout << "Fin Link\n";
    std::cout << "============================================================\n\n";
}

void displayMap(Background* backgroundManager, int mapIndex) {
    backgroundManager->setMapIndex(mapIndex);
    int tile_32 = 0;
    while (backgroundManager->hasMoreTile())
    {
        tile_32++;
        if (tile_32 == 32) {
            tile_32 = 0;
            std::cout << "\n";
        }
        std::cout << backgroundManager->getNextTile();
    }
    std::cout << "\n";
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// MAIN
/////////////////////////////////////////////////////////////////////////////////////////////////

int main()
{
    cout << "Start game!\n\n";
    Game game();
    Background* backgroundManager = Background::getBackgroundManager();
    //displayMap(backgroundManager, 0);

    //cout << "Ajout d'un chest : ";

    Chest* chest = new Chest(0, 0);
    //cout << "Tile chest fermee = " << chest->getTileId() << "\n\n";
    
    cout << "Ajout de Link avec son epee\n";

    Sword s(0, 0);
    Link* link = new Link(0, 0, s);
    //displayLink(link);

    //LinkAttack(link, chest);
    //cout << "Tile chest apres attack = " << chest->getTileId() << "\n";


    cout << "\nAjout d'un enemy\n";
    Enemy* enemy = new Enemy(6, 6);
    collisionLinkEnemy(link, enemy);

    /* Collision Link&Enemy (Link meurt)
    cout << "\nDeplacement de Link\n";
    link->setPosX(8);
    link->setPosY(6);
    link->deplacementGauche();

    collisionLinkEnemy(link, enemy);
    displayLink(link);
    collisionLinkEnemy(link, enemy);
    displayLink(link);
    collisionLinkEnemy(link, enemy);
    displayLink(link);
    */

    // Collision Link&Enemy (Enemy meurt)
    cout << "\nDeplacement de Link\n";
    link->setPosX(9);
    link->setPosY(6);
    link->deplacementGauche();
    
    
    delete backgroundManager;
}



