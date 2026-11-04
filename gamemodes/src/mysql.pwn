#include <YSI_Coding\y_hooks>

#define GAMEMODE_VERSION 		"2.5"
#define _query(%0,%1) mysql_format(SQL,gQuery,sizeof gQuery, %0, %1) && mysql_tquery(SQL, gQuery)

hook OnGameModeInit() {
	loadLogo();

	SQL = mysql_connect("127.0.0.1", "root", "", "b-hood");
	if mysql_errno(SQL) *then return print("Failed to connect to MySQL database.");


	mysql_tquery(SQL, "SELECT * FROM users", "TotalUsers", "");
	mysql_tquery(SQL, "SELECT * FROM `svehicles` ORDER BY `svehicles`.`vID` ASC", "LoadSVehicle", "");
	mysql_tquery(SQL, "SELECT * FROM `turfs`", "SQL_loadTurfs", "");
	mysql_tquery(SQL, "SELECT * FROM `safezones` ORDER BY `safezones`.`ID` ASC", "InsertSafeZone", "");
	mysql_tquery(SQL, "SELECT * FROM `houses` ORDER BY `houses`.`ID` ASC", "LoadProperty", ""); 
	mysql_tquery(SQL, "SELECT * FROM `bizz` ORDER BY `bizz`.`ID` ASC", "LoadBizz", "");
	mysql_tquery(SQL, "SELECT * FROM `clans` ORDER BY `clans`.`ID` ASC", "InsertClans", "");
	mysql_tquery(SQL, "SELECT * FROM `clanhq`", "LoadHQClans", "");
	mysql_tquery(SQL, "SELECT * FROM `graffiti`", "LoadGraffiti", "");
	mysql_tquery(SQL, "SELECT * FROM `factions`", "LoadFactions", "");
	mysql_tquery(SQL, "SELECT * FROM `garages`", "sql_load_garages");
	mysql_tquery(SQL, "SELECT * FROM `eat_stand`", "sql_load_eat_stand");
	mysql_tquery(SQL, "SELECT * FROM `jobs` ORDER BY `jobs`.`ID` ASC", "LoadJobs", "");
	mysql_tquery(SQL, "SELECT * FROM `dsveh` WHERE `Price` > '0' ORDER BY `dsveh`.`Price` ASC", "LoadDSVeh", ""); 
	mysql_tquery(SQL, "SELECT * FROM `seif`", "LoadSafes", "");
	mysql_tquery(SQL, "SELECT * FROM `atm`", "SQL_cache_atm");
	mysql_tquery(SQL, "SELECT * FROM `commands`", "SQL_blockcommands");
	mysql_tquery(SQL, "UPDATE `users` SET `Status` = '-1'");
	mysql_tquery(SQL, "SELECT * FROM `stuff` WHERE `ID` = '1'", "LoadStuffs", "");
	mysql_tquery(SQL, "SELECT * FROM `svf` WHERE `Rank` > '0' ORDER BY `svf`.`Rank` ASC", "SQL_Load_Svf");
	return true;
}
stock UpdateVar(playerid, const varname[], amount) 
	return _query("UPDATE `users` SET `%s`='%i' WHERE `id`='%i'", varname, amount, PlayerInfo[playerid][pSQLID]);

stock UpdateVarStr(playerid, const varname[], const amount[]) 
	return _query("UPDATE `users` SET `%s`='%e' WHERE `id`='%i'", varname, amount, PlayerInfo[playerid][pSQLID]);

loadLogo() {

	Logo = TextDrawCreate(638.000000, 434.075103, "rpg.pericsq.ro");
	TextDrawLetterSize(Logo, 0.349999, 1.293125);
	TextDrawAlignment(Logo, 3);
	TextDrawColor(Logo, -1);
	TextDrawSetShadow(Logo, 0);
	TextDrawSetOutline(Logo, 1);
	TextDrawBackgroundColor(Logo, 255);
	TextDrawFont(Logo, 3);
	TextDrawSetProportional(Logo, 1);
	TextDrawSetShadow(Logo, 0);

	LoginTD[0] = TextDrawCreate(317.000000, 107.000000, "pericsq");
	TextDrawLetterSize(LoginTD[0], 0.483831, 1.882915);
	TextDrawAlignment(LoginTD[0], 2);
	TextDrawColor(LoginTD[0], -1);
	TextDrawSetShadow(LoginTD[0], 0);
	TextDrawSetOutline(LoginTD[0], 1);
	TextDrawBackgroundColor(LoginTD[0], 159);
	TextDrawFont(LoginTD[0], 3);
	TextDrawSetProportional(LoginTD[0], 1);
	TextDrawSetShadow(LoginTD[0], 0);

	LoginTD[1] = TextDrawCreate(287.000000, 118.000000, "Community");
	TextDrawLetterSize(LoginTD[1], 0.492132, 1.276249);
	TextDrawAlignment(LoginTD[1], 1);
	TextDrawColor(LoginTD[1], -1);
	TextDrawSetShadow(LoginTD[1], 0);
	TextDrawSetOutline(LoginTD[1], 1);
	TextDrawBackgroundColor(LoginTD[1], 146);
	TextDrawFont(LoginTD[1], 0);
	TextDrawSetProportional(LoginTD[1], 1);
	TextDrawSetShadow(LoginTD[1], 0);
}