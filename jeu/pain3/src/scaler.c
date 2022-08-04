#include "scaler.h"

XVprocSs VprocInst;

void configureScaler()
{
	XVprocSs_Config *VprocSsConfigPtr;
	XVprocSs* vpssPtr = &VprocInst;

	//Configure the VPSS
	VprocSsConfigPtr = XVprocSs_LookupConfig(XPAR_XVPROCSS_0_DEVICE_ID);
	if(VprocSsConfigPtr == NULL)
	{
		xil_printf("ERR:: VprocSs device not found\r\n");
	}

	XVprocSs_LogReset(vpssPtr);
	XVprocSs_CfgInitialize(vpssPtr, VprocSsConfigPtr,VprocSsConfigPtr->BaseAddress);
	setScalerInputRes(vpssPtr);
	setScalerOutputRes(vpssPtr);
	XVprocSs_SetSubsystemConfig(vpssPtr);
}


void setScalerInputRes(XVprocSs* vpssPtr)
{
		XVidC_VideoStream Stream;

		// Setup Video Processing Subsystem
		Stream.VmId           = XVIDC_VM_CUSTOM;
		Stream.Timing.HActive = 256;
		Stream.Timing.VActive = 224;
		Stream.ColorFormatId  = XVIDC_CSF_RGB;
		Stream.ColorDepth = static_cast<XVidC_ColorDepth>(vpssPtr->Config.ColorDepth);
		Stream.PixPerClk = static_cast<XVidC_PixelsPerClock>(vpssPtr->Config.PixPerClock);
		//Stream.ColorDepth     = vpssPtr->Config.ColorDepth;
		//Stream.PixPerClk      = vpssPtr->Config.PixPerClock;

		Stream.FrameRate      = XVIDC_FR_60HZ;
		Stream.IsInterlaced   = 0;

		XVprocSs_SetVidStreamIn(vpssPtr, &Stream);

}



void setScalerOutputRes(XVprocSs* vpssPtr)
{
		XVidC_VideoStream Stream;

		// Setup Video Processing Subsystem
		Stream.VmId           = XVIDC_VM_720_60_P;
		Stream.Timing.HActive = 1280;
		Stream.Timing.VActive = 720;
		Stream.ColorFormatId  = XVIDC_CSF_RGB;
		Stream.ColorDepth = static_cast<XVidC_ColorDepth>(vpssPtr->Config.ColorDepth);
		Stream.PixPerClk = static_cast<XVidC_PixelsPerClock>(vpssPtr->Config.PixPerClock);
		//Stream.ColorDepth     = vpssPtr->Config.ColorDepth;
		//Stream.PixPerClk      = vpssPtr->Config.PixPerClock;

		Stream.FrameRate      = XVIDC_FR_60HZ;
		Stream.IsInterlaced   = 0;

		XVprocSs_SetVidStreamOut(vpssPtr, &Stream);
}
