#pragma once

class Background {
private:
	static const int BRICK = 22;
	static const int DIRT = 25;
	static const int WATER = 28;
	static const int STONE_WALL = 27;
	static const int ROCKS = 26;
	static const int BUSH = 23;
	static const int ALPHA_E = 21;
	static const int ALPHA_A = 20;
	static const int ALPHA_L = 19;
	static const int ALPHA_P = 18;
	static const int ALPHA_Y = 17;
	static const int NOIR_CC = 1;
	static const int BLANC_CC = 2;
	static const int BLEU1_CC = 3;
	static const int ROUGE_CC = 4;
	static const int ROSE_CC = 5;
	static const int BEIGE_CC = 6;
	static const int LIME_CC = 7;
	static const int VERT1_CC = 8;
	static const int VERT2_CC = 9;
	static const int BRUN_CC = 10;
	static const int ORANGE_CC = 11;
	static const int JAUNE_CC = 12;
	static const int GRIS_CC = 13;
	static const int BLEU2_CC = 14;
	int mapIndex = 0;
	int tileIndex;
	static int backgrounds[1][1024];
public:
	Background();
	static Background* background;
	~Background();
	static Background* getBackgroundManager();
	void setMapIndex(int index);
	void resetMapTileIndex();
	int getNextTile();
	bool hasMoreTile();
	int nextMapTrigger(int x,int y);
};

//int array[1024] = {brick, }

