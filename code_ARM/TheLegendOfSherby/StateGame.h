class StateGame {
public:
	StateGame();
	StateGame(Game g);
	~StateGame();

	void setGame(Game g);
	Game getGame();
	
	virtual void buttonPress() = 0;
	virtual void joystickButtonPress() = 0;
	virtual void joystickMove() = 0;
};

