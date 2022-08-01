#include "scaler.h"
#include "vdma.h"
#include "xil_printf.h"
#include "mycolorRegister.h"
#include "sleep.h"
#include "api.h"
#include "background.h"
#define INSTRUCTION_BASEADDR 0x43C00000


void displayMap(Background* backgroundManager, int mapIndex) {
    backgroundManager->setMapIndex(mapIndex);
    for(int y = 0; y < 32; y++) {
    	for(int x = 0; x < 32; x++) {
        	API::sendBackgroundGlobalOpcode(API::SET_POST_BACKGROUND, backgroundManager->getNextTile(), x * 16, y * 16);
    	}
    }
}

int main() {
	configureScaler();
    configureVdma();

    int counter = 0;
    double time = 1.0/60.0;

    long tick = time * 667000000;

    int colorA = 0x00000000;
    int colorB = 0x0000FF00;
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 4, colorB);

    // ajout du background
    Background* backgroundManager = Background::getBackgroundManager();
    displayMap(backgroundManager, 0);

    // ajout du personnage
    API::sendActorRelativeOpcode(API::CHANGE_TILE_FOR_ACTOR, 0, 2, 0, 0);
    API::sendActorGlobalOpCode(API::SET_POS_XY_ACTOR, 0, 1, 64, 64);
    return 0;
}
