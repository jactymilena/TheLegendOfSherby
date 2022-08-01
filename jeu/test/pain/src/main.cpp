#include "scaler.h"
#include "vdma.h"
#include "xil_printf.h"
#include "mycolorRegister.h"
#include "sleep.h"
#include "api.h"
#include "background.h"


void displayMap(Background* backgroundManager, int mapIndex) {
    backgroundManager->setMapIndex(mapIndex);
    while (backgroundManager->hasMoreTile())
    {
		Xil_Out32((XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR) + (0), (u32)(backgroundManager->getNextTile()));
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

    Background* backgroundManager = Background::getBackgroundManager();

    while (1) {
        displayMap(backgroundManager, 0);
    //if (counter == tick) {
   // 		Xil_Out32((XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR) + (0), (u32)(colorA));
//			colorA = colorA + 0x200;
	//		counter = 0;
  //  	}
   // 	counter++;
    }

    return 0;
}
