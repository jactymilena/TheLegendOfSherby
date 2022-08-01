#pragma once
#include <bitset> 
#include <string>  

class API
{
public:
	static const int SET_POST_BACKGROUND;
	static const int SET_ACTOR_ACTIVE;
	static const int CHANGE_TILE_FOR_ACTOR;
	static const int SET_POS_X_ACTOR;
	static const int SET_POS_Y_ACTOR;
	static const int SET_POS_XY_ACTOR;
	static void sendBackgroundGlobalOpcode(int opcode, int tilId, int global_x, int global_y);
	static void sendActorGlobalOpCode(int opcode, int actor_id, bool active, int global_x, int global_y);
	static void sendActorRelativeOpcode(int opcode, int actor_id, int tile_id, int relative_x, int relative_y);
};

