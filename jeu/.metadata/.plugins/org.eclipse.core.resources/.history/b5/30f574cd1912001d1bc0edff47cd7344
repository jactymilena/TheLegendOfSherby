#include "scaler.h"
#include "vdma.h"
#include "xil_printf.h"
#include "mycolorRegister.h"
#include "sleep.h"

int main() {
	configureScaler();
    configureVdma();

    int counter = 0;
    double time = 1.0/60.0;

    long tick = time * 667000000;

    int colorA = 0x00000000;
    int colorB = 0x0000FF00;
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_1_S00_AXI_BASEADDR, 4, colorB);

    while (1) {
    	if (counter == tick) {
			MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_1_S00_AXI_BASEADDR, 0, colorA);
			colorA = colorA + 0x200;
			counter = 0;
    	}
    	counter++;
    }

    return 0;
}
