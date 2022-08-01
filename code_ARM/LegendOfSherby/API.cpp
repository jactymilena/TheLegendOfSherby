#include "API.h"

const int API::SET_POST_BACKGROUND = 1;
const int API::SET_ACTOR_ACTIVE = 6;
const int API::CHANGE_TILE_FOR_ACTOR = 8;
const int API::SET_POS_X_ACTOR = 9;
const int API::SET_POS_Y_ACTOR = 10;
const int API::SET_POS_XY_ACTOR = 11;

void API::sendBackgroundGlobalOpcode(int opcode, int tile_id, int global_x, int global_y)
{
	int opcode_ = opcode << 27;
	int tile_id_ = tile_id << 18;
	int global_x_ = global_x << 9;
	//Xil_Out32((XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR)+(0), (u32)(opcode_ + tile_id_ + global_x_ + global_y));
}

void API::sendActorRelativeOpcode(int opcode, int actor_id, int tile_id, int relative_x, int relative_y)
{
	int opcode_ = opcode << 27;
	int actor_id_ = actor_id << 23;
	int tile_id_ = tile_id << 15;
	int relative_x_ = relative_x << 7;
	//Xil_Out32((XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR)+(0), (u32)(opcode_ + actor_id_ + tile_id_ + relative_x_ + relative_y));
}


static void sendActorGlobalOpCode(int opcode, int actor_id, bool active, int global_x, int global_y)
{
	int active_int = active ? 1 : 0;
	int opcode_ = opcode << 27;
	int actor_id_ = actor_id << 23;
	int active_ = active_int << 22;
	int global_x_ = global_x << 9;
	//Xil_Out32((XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR)+(0), (u32)(opcode_ + actor_id_ + active_ + global_x_ + global_y));
}
