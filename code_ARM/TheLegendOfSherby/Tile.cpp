#include "Tile.h"

class Tile {
private:
	int tileId;

public:
	Tile(int t) {
		tileId = t;
	}
	~Tile();
	
	void setTileID(int t) {
		tileId = t;
	}

	int getTileId() {
		return tileId;
	}
};
