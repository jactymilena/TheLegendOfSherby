#include "Character.h"

class Link : public Character {
public:
	// constructers
	Link();
	~Link();

	// functions 
	void changeState();
	void attack();
	bool loseHeart();
	void gainHeart();
};