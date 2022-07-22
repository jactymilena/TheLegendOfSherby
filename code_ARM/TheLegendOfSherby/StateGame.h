class StateGame {
public:
	StateGame();
	StateGame(Game g);
	~StateGame();

	void setGame(Game g);
	Game getGame();
	
	void buttonPress();
	void joystickButtonPress();
	void joystickMove();
};

