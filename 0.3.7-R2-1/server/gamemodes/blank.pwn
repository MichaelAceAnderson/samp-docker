native printf(const format[], {Float, _}:...);
native SendRconCommand(const cmd[]);

main()
{
	printf("   _____ ___    __  _______       _____ __________ _    ____________  ");
	printf("  / ___//   |  /  |/  / __ \\     / ___// ____/ __ \\ |  / / ____/ __ \\ ");
	printf("  \\__ \\/ /| | / /|_/ / /_/ /_____\\__ \\/ __/ / /_/ / | / / __/ / /_/ / ");
	printf(" ___/ / ___ |/ /  / / ____/_____/__/ / /___/ _, _/| |/ / /___/ _, _/  ");
	printf("/____/_/  |_/_/  /_/_/         /____/_____/_/ |_| |___/_____/_/ |_|   ");
	printf("                                                                      ");
	printf("ERROR: gamemode not found. Please check the server.cfg file and make sure the gamemode is set correctly.");
	printf("Remember to change the rcon_password in the server.cfg file to prevent unauthorized access and allow the gamemode to load.");

	SendRconCommand("exit");

	return 1;
}