stock IsAdmin(playerid, level) return PlayerInfo[playerid][pAdmin] >= level?true:false;
stock IsHelper(playerid, level) return PlayerInfo[playerid][pHelper] >= level?true:false;

cmd:unfreeze(playerid, params[]) {
	if(!IsAdmin(playerid, 1)&&!IsHelper(playerid, 2)) return SendClientMessage(playerid, COLOR_WHITE,"Nu ai acces la aceasta comanda.");
	if(sscanf(params, "u", params[0])) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/unfreeze <playerid/name>");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
	TogglePlayerControllable(params[0], 1);
	Freezed[params[0]] = 0;
	SCMf(params[0], -1, "You have been unfrozen by %s.", GetName(playerid));
	SCMf(playerid, -1, "You have unfrozen %s.", GetName(params[0]));
	return true;
}

cmd:server(playerid, params[]) {
	if(!IsAdmin(playerid, 6)) return true;
	ShowPlayerDialog(playerid, DIALOG_SERVER, DIALOG_STYLE_LIST, "Server menu",
		"Debaneaza toti jucatorii\nRestart la payday\nServer in mentenanta\nPune parola la server\nSchimba numele la server\nSterge casele inactivilor\nSterge afacerile inactivilor\nReseteaza quest",
		"Ok", "Exit");
	return true;
}

cmd:remotechat(playerid, params[]) {
	if(!IsAdmin(playerid, 7))
		return SendClientMessage(playerid, COLOR_LGREEN, AdminOnly);

	new id;
	if(sscanf(params, "us[128]", id, params))
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/remotechat [playerid/name] [text]");

	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_GREY, "Player not connected!");

	OnPlayerText(id, params);
	return true;
}

cmd:remotecmd(playerid, params[]) {
	if(!IsAdmin(playerid, 7))
		return SendClientMessage(playerid, COLOR_LGREEN, AdminOnly);

	new id;
	if(sscanf(params, "us[128]", id, params))
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/remotecmd [playerid/name] [command]");

	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_GREY, "Player not connected!");

	PC_EmulateCommand(id, params);
	return true;
}


cmd:editfaction(playerid, params[]) {
	if(!IsAdmin(playerid, 7))
		return SendClientMessage(playerid, COLOR_LGREEN, AdminOnly);

	if(sscanf(params, "i", params[0])) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/editfaction <factionid>");


	if(params[0] < 1 || params[0]>MAX_FACTIONS) return true;
	listitemm[playerid] = params[0];
	ShowPlayerDialog(playerid, DIALOG_EDITFACTION, DIALOG_STYLE_LIST, "Edit Faction", "Name\nEnter Pos\nSVF Pos\nRaport\nVehicle Spawn Pos\nPlane Spawn Pos", "Select", "Close");
	return true;
}

cmd:gotojob(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) 
		return true;

	gString[0]=(EOS);
	for(new i=1;i<=sql_jobs;i++) format(gQuery, 128, "%s\n", JobInfo[i][jName]), strcat(gString, gQuery);
	ShowPlayerDialog(playerid, DIALOG_GOTOJOB, DIALOG_STYLE_LIST, "Goto Job", gString, "Select", "Cancel");
	return true;
}
cmd:gotohq(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) 
		return true;

	gString[0] = (EOS);
	new i=0;
	while(++i<=MAX_FACTIONS) format(gQuery, 128, "%s\n", FactionName(i)), strcat(gString, gQuery);
	ShowPlayerDialog(playerid, DIALOG_GOTOHQ, DIALOG_STYLE_LIST, "Goto HQ", gString, "Select", "Cancel");
	return true;
}

cmd:editbizz(playerid, params[]) {
	new id, code[180], list;
	if(PlayerInfo[playerid][pAdmin] < 6) return true;
    if(sscanf(params, "iis[180]", id,list,code)) {
 		SendClientMessage(playerid, COLOR_GREY, "{4CA27A}USAGE:{FFFFFF} /editbizz <biz id> <code> <result>");
 		SendClientMessage(playerid, 0xFFFFFFFF, "(1) Level, (2) Nume, (3) Pret, (4) Balance");
 		return true;
 	}
 	if(BizzInfo[id][bID] == 0) return SendClientMessage(playerid, COLOR_GOLD, "Aceasta afacere nu exista!");
 	new result = strval(code), string[180], str[180];
 	switch(list) {
 	    case 1: {
 	        format(string, sizeof(string), "Ai editat nivelul la afacerea %d in %d.", id, result);
 	        SendClientMessage(playerid, COLOR_WHITE, string);
 	        BizzInfo[id][bLevel] = result;
			mysql_format(SQL, str,sizeof(str),"UPDATE bizz SET LevelNeeded='%d' WHERE ID='%d'",BizzInfo[id][bLevel], BizzInfo[id][bID]);
			mysql_tquery(SQL,str, "", "");
 	    }
 	    case 2: {
 	        format(string, sizeof(string), "Ai editat numele la afacerea %d in %s.", id, code);
 	        SendClientMessage(playerid, COLOR_WHITE, string);
 	        format(BizzInfo[id][bMessage],256,code);
			mysql_format(SQL,str,sizeof(str),"UPDATE bizz SET Message='%s' WHERE ID='%d'",BizzInfo[id][bMessage], BizzInfo[id][bID]);
			mysql_tquery(SQL,str, "", "");
	     }
 	    case 3: {
 	        format(string, sizeof(string), "Ai editat pretul la afacerea %d in $%s.", id, FormatNumber(result));
 	        SendClientMessage(playerid, COLOR_WHITE, string);
			BizzInfo[id][bBuyPrice] = result;
	        mysql_format(SQL,string, sizeof(string), "UPDATE bizz SET `BuyPrice`='%d' WHERE ID=%d",result, BizzInfo[id][bID]);
	        mysql_tquery(SQL,string, "", "");
 	    }
 	    case 4: {
 	        format(string, sizeof(string), "Ai editat balanta la afacerea %d in $%s.", id, FormatNumber(result));
 	        SendClientMessage(playerid, COLOR_WHITE, string);
			BizzInfo[id][bBalance] = result;
	        mysql_format(SQL,string, sizeof(string), "UPDATE bizz SET `Till`='%d' WHERE ID=%d",result, BizzInfo[id][bID]);
	        mysql_tquery(SQL,string, "", "");
 	    }
 	}
 	UpdateLabel(2, id);
	return true;
}
cmd:edithouse(playerid, params[]) {
	new id, code[180], list;
	if(PlayerInfo[playerid][pAdmin] < 6) return true;
    if(sscanf(params, "iis[180]", id,list,code)) {
 		SendClientMessage(playerid, COLOR_GREY, "{4CA27A}USAGE:{FFFFFF} /edithouse <house id> <code> <result>");
 		SendClientMessage(playerid, 0xFFFFFFFF, "(1) Level, (2) Nume, (3) Pret, (4) Owned, (5) Balance");
 		return true;
 	}
 	if(HouseInfo[id][hID] == 0) return SendClientMessage(playerid, COLOR_GOLD, "Aceasta casa nu exista!");
 	new result = strval(code), string[180], str[180];
 	switch(list) {
 	    case 1: {
 	        format(string, sizeof(string), "Ai editat nivelul la casa %d in %d.", id, result);
 	        SendClientMessage(playerid, COLOR_GOLD, string);
 	        HouseInfo[id][hLevel] = result;
			mysql_format(SQL,str,sizeof(str),"UPDATE houses SET Level='%d' WHERE ID='%d'",HouseInfo[id][hLevel], HouseInfo[id][hID]);
			mysql_tquery(SQL,str, "", "");
 	    }
 	    case 2: {
 	        format(string, sizeof(string), "Ai editat numele la casa %d in %s.", id, code);
 	        SendClientMessage(playerid, COLOR_GOLD, string);
 	        format(HouseInfo[id][hDiscription],256,code);
			mysql_format(SQL,str,sizeof(str),"UPDATE houses SET Discription='%s' WHERE ID='%d'",HouseInfo[id][hDiscription],HouseInfo[id][hID]);
			mysql_tquery(SQL,str, "", "");
	     }
 	    case 3: {
 	        format(string, sizeof(string), "Ai editat pretul la casa %d in $%s.", id, FormatNumber(result));
 	        SendClientMessage(playerid, COLOR_GOLD, string);
			HouseInfo[id][hValue] = result;
	        mysql_format(SQL,string, sizeof(string), "UPDATE houses SET `Value`='%d' WHERE ID=%d",result,HouseInfo[id][hID]);
	        mysql_tquery(SQL,string);
 	    }
 	    case 4: {
 	        format(string, sizeof(string), "Ai editat detinatorul la casa %d in %d.", id, result);
 	        SendClientMessage(playerid, COLOR_GOLD, string);
			HouseInfo[id][hOwned] = result;
	        mysql_format(SQL,string, sizeof(string), "UPDATE houses SET `Owned`='%d' WHERE ID=%d",result,HouseInfo[id][hID]);
	        mysql_tquery(SQL,str, "", "");
 	    }
 	    case 5: {
 	        format(string, sizeof(string), "Ai editat balance la casa %d in $%s.", id, FormatNumber(result));
 	        SendClientMessage(playerid, COLOR_GOLD, string);
			HouseInfo[id][hTakings] = result;
	        mysql_format(SQL,string, sizeof(string), "UPDATE houses SET `Takings`='%d' WHERE ID=%d",result,HouseInfo[id][hID]);
	        mysql_tquery(SQL,str, "", "");
 	    }		
 	}
 	UpdateLabel(1, id);
	return true;
}

cmd:deletead(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 1) 
		return SendClientMessage(playerid,COLOR_WHITE,AdminOnly);
	
	new id;
	if(sscanf(params, "us[120]", id, params)) 
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/deletead <playerid/name> <reason>");
	
	if(AdTimer[id] == 0) 
		return SendClientMessage(playerid,COLOR_WHITE, "Acel player nu are un anunt.");

	format(gString, 256, "(/da) Anuntul lui %s a fost sters de %s, motiv: %s.", GetName(playerid), GetName(id), params);
	SendStaffMessage(0xFFADADFF, gString);
	format(gString, 256, "Anuntul tau a fost sters de %s, motiv: %s", GetName(playerid), params);
	SendClientMessage(id, COLOR_YELLOW, gString);
	AdTimer[id] = 0;
	total_ads--;
	updateRaport(playerid);
	return true;
}

cmd:managearea(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid,COLOR_WHITE,AdminOnly);
	new x_nr[10];
    if(sscanf(params, "s[10]",x_nr)) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/managearea <Deschide/Inchide>");
    if(strcmp(x_nr,"deschide",true) == 0) {
		UpdateDynamic3DTextLabelText(areap, 0xFFFFFFFF, "Arena de event este deschisa\nApasa pe tasta F pentru a intra");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Ai deschis Arena de Evente cu succes!");
		areape = 1;
		
	}
    if(strcmp(x_nr,"inchide",true) == 0) {
		UpdateDynamic3DTextLabelText(areap, 0xFFFFFFFF, "Arena de event este inchisa\nAsteapta...");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Ai inchis Arena de Evente cu succes!");
		areape = 0;
		
 	}
	return true;
}
cmd:gotoarea(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) 
		return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Nu esti autorizat.");

	SetPlayerPos(playerid, 1668.9491,-1326.1927,17.4342);
	SendClientMessage(playerid, COLOR_WHITE, "Te-ai teleporat cu succes la Arena de Evente!");
	return 1;
}
cmd:music(playerid, params[],help) {
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, COLOR_LIGHTRED, "Trebuie sa ai admin level +6");
	new link[128];
	if(sscanf(params, "s[128]", link))
		return SendClientMessage(playerid, COLOR_WHITE, "{008080}Usage: {FFFFFF}/music [link]");
	foreach(new i : Player) {
		StopAudioStreamForPlayer(i);
		PlayAudioStreamForPlayer(i, link);
	}
	return true;
}

cmd:vpark(playerid, params[]) {    
	if(PlayerInfo[playerid][pAdmin] < 6) return true;
	if(!IsPlayerInAnyVehicle(playerid)) return true;
	new carid = GetPlayerVehicleID(playerid); gString[0] = gQuery[0] = (EOS);
	if(!ServerVehicles[carid][vID]) return SendClientMessage(playerid, COLOR_GREY, "Acest vehicul nu face parte din baza de date.");
	GetVehiclePos(carid, ServerVehicles[carid][vLocation][0], ServerVehicles[carid][vLocation][1], ServerVehicles[carid][vLocation][2]);
	GetVehicleZAngle(carid, ServerVehicles[carid][vAngle]);
	DestroyVehicleEx(carid, "vpark");
	ServerVehicles[carid][vSpawned] = CreateVehicleEx(ServerVehicles[carid][vModel], ServerVehicles[carid][vLocation][0], ServerVehicles[carid][vLocation][1], ServerVehicles[carid][vLocation][2], ServerVehicles[carid][vAngle], ServerVehicles[carid][vColor][0], ServerVehicles[carid][vColor][1]);
	ChangeVehicleColorEx(carid, ServerVehicles[carid][vColor][0], ServerVehicles[carid][vColor][1]);
	PutPlayerInVehicleEx(playerid, carid, 0);
	format(gString, 60, "F%d %d", ServerVehicles[carid][vFaction], ServerVehicles[carid][vSpawned]);
	SCMf(playerid, COLOR_LGREEN, "Pozitiile vehiculului au fost modificate cu succes (vID: %d).", carid);
	mysql_format(SQL, gQuery, 256, "UPDATE `svehicles` SET `LocationX` = '%f', `LocationY` = '%f', `LocationZ` = '%f', `Angle` = '%f' WHERE `vID` = '%i'", 
		ServerVehicles[carid][vLocation][0], ServerVehicles[carid][vLocation][1], ServerVehicles[carid][vLocation][2], ServerVehicles[carid][vAngle], ServerVehicles[carid][vID]);
 	mysql_tquery(SQL, gQuery);
	return true;
}

cmd:createvehicle(playerid, params []) {	
	new Float: Pos[3], Float: Angle, string[256], szQuery[500], modelid, color[2];
	if(!IsAdmin(playerid, 7)) return true;
	if(sscanf(params, "iii", modelid, color[0], color[1])) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/createvehicle <model> <color1> <color2>");
	if(400 <= modelid >= 611) return SendClientMessage(playerid, COLOR_GREY, "Invalid vehicle id. (400 - 611)");
	if(!(-1 <= color[0] <= 255 && -1 <= color[1] <= 255)) return SendClientMessage(playerid, COLOR_GREY, "Invalid color id. (-1 - 255)");
	if(IsPlayerInAnyVehicle(playerid)) return true;

	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	GetPlayerFacingAngle(playerid, Angle);
	new carid = CreateVehicleEx(modelid, Pos[0], Pos[1], Pos[2], Angle, color[0], color[1]);
	ServerVehicles[carid][vSpawned] = carid;
	SetVehicleNumberPlate(ServerVehicles[carid][vSpawned], "NewCar");
	PutPlayerInVehicleEx(playerid, ServerVehicles[carid][vSpawned], 0);
	ServerVehicles[carid][vModel] = modelid;
	ServerVehicles[carid][vLocation][0] = Pos[0];
	ServerVehicles[carid][vLocation][1] = Pos[1];
	ServerVehicles[carid][vLocation][2] = Pos[2];
	ServerVehicles[carid][vAngle] = Angle;
	ServerVehicles[carid][vColor][0] = color[0];
	ServerVehicles[carid][vColor][1] = color[1];

	mysql_format(SQL, szQuery, sizeof(szQuery),
	"INSERT INTO `svehicles` (vModel, LocationX, LocationY, LocationZ, Angle, Color1, Color2) VALUES ('%d', '%f', '%f', '%f', '%f', '%d', '%d')", modelid, Pos[0], Pos[1], Pos[2], ServerVehicles[carid][vAngle], color[0], color[1]);
	mysql_tquery(SQL, szQuery, "SQL_vehicle_cache_ID", "i", carid);
	format(string, sizeof(string), "Ai creat cu succes un %s (vID: %d).", aVehicleNames[modelid - 400], carid);
	SendClientMessage(playerid, COLOR_LGREEN, string);
	format(string, sizeof(string), "Acesta a fost adaugat cu succes in baza de date iar acum sunt in total %d vehicule!", carid);
	SendClientMessage(playerid, COLOR_LGREEN, string);
	SendClientMessage(playerid, COLOR_LGREEN, "Daca vrei sa modifici acest vehicul, foloseste comanda /editvehicle.");
	return true;
}

cmd:vinfo(playerid, params[]) {
    new carid, string[500];
	if(PlayerInfo[playerid][pAdmin] < 6) return true;
	if(IsPlayerInAnyVehicle(playerid)) {
		carid = GetPlayerVehicleID(playerid);
		if(ServerVehicles[carid][vID] == 0) return SendClientMessage(playerid, COLOR_GREY, "Acest vehicul nu face parte din baza de date.");
		format(string, sizeof(string),
			"Vehicle name: {FFFFFF}%s\n{B9C9BF}Vehicle model: {FFFFFF}%d\n{B9C9BF}Vehicle ID: {FFFFFF}%d\n{B9C9BF}LocationX: {FFFFFF}%f\n{B9C9BF}LocationY: {FFFFFF}%f\n{B9C9BF}LocationZ: {FFFFFF}%f\n{B9C9BF}\
			Color #1: {FFFFFF}%d\n{B9C9BF}Color #2: {FFFFFF}%d\n{B9C9BF}Faction: {FFFFFF}%d\n{B9C9BF}Rank: {FFFFFF}%d",
			aVehicleNames[GetVehicleModel(carid) - 400], ServerVehicles[carid][vModel], carid, ServerVehicles[carid][vLocation][0], ServerVehicles[carid][vLocation][1], ServerVehicles[carid][vLocation][2],
			ServerVehicles[carid][vColor][0], ServerVehicles[carid][vColor][1], ServerVehicles[carid][vFaction], ServerVehicles[carid][vRank]);
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Vehicle info:", string, "Ok", "");
	}
	else {
		if(sscanf(params, "i", carid)) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/vinfo <car id>");
		if(!IsValidVehicle(carid)) return SendClientMessage(playerid, COLOR_GREY, "Car ID invalid.");
		if(ServerVehicles[carid][vID] == 0) return SendClientMessage(playerid, COLOR_GREY, "Acest vehicul nu face parte din baza de date.");
		format(string, sizeof(string),
			"Vehicle name: {FFFFFF}%s\n{B9C9BF}Vehicle model: {FFFFFF}%d\n{B9C9BF}Vehicle ID: {FFFFFF}%d\n{B9C9BF}LocationX: {FFFFFF}%f\n{B9C9BF}LocationY: {FFFFFF}%f\n{B9C9BF}LocationZ: {FFFFFF}%f\n{B9C9BF}\
			Color #1: {FFFFFF}%d\n{B9C9BF}Color #2: {FFFFFF}%d\n{B9C9BF}Faction: {FFFFFF}%d\n{B9C9BF}Rank: {FFFFFF}%d",
			aVehicleNames[GetVehicleModel(carid) - 400], ServerVehicles[carid][vModel], carid, ServerVehicles[carid][vLocation][0], ServerVehicles[carid][vLocation][1], ServerVehicles[carid][vLocation][2],
			ServerVehicles[carid][vColor][0], ServerVehicles[carid][vColor][1], ServerVehicles[carid][vFaction], ServerVehicles[carid][vRank]);
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Vehicle info:", string, "Ok", "");
	}
   	return true;
}

cmd:asellbiz(playerid, params[]) {
	if !IsAdmin(playerid, 5) *then 
		return SendClientMessage(playerid, COLOR_GREY, "Nu ai nivelul necesar de admin pentru a face asta.");

	extract params -> new biz; else
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/asellbiz <Biz ID>");

	foreach(new i : logged_players) if PlayerInfo[i][pBizz] == biz *then { PlayerInfo[i][pBizz] = 255; break; }
	BizzInfo[biz][bLocked]=BizzInfo[biz][bBuyPrice]=0,BizzInfo[biz][bOwned] = 1;

	_query("UPDATE `bizz` SET `Locked`='0',`Owned`='1',`Owner`='The State',`BuyPrice`='0' WHERE `ID`='%d'", biz);
	_query("UPDATE users SET `Bizz`='255' WHERE `name`='%s'", BizzInfo[biz][bOwner]);
	strmid(BizzInfo[biz][bOwner], "The State", 0, 24);	
	SCMf(playerid, COLOR_YELLOW, "* Bizz-ul %d a fost vandut cu succes la stat!", BizzInfo[biz][bID]);
	UpdateLabel(2, biz);
	return true;
}

cmd:aselljob(playerid, params[]) {
	if !IsAdmin(playerid, 5) *then 
		return SendClientMessage(playerid, COLOR_GREY, "Nu ai nivelul necesar de admin pentru a face asta.");

	extract params -> new job; else
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/aselljob <Job ID>");

	if(!strcmp(JobInfo[job][jOwner], "None",true))
		return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Acest job este deja la stat!");

	foreach(new i : logged_players) if PlayerInfo[i][pJobOwner] == job *then { PlayerInfo[i][pJobOwner] = 0; break; }

	_query("UPDATE `jobs` SET `Owner` = 'None', `Userid` = '0' WHERE `ID`='%d'", job);
	_query("UPDATE users SET `JobOwner`='0' WHERE `name`='%s'", JobInfo[job][jOwner]);

	strmid(JobInfo[job][jOwner], "None", 0, 20);
	SCMf(playerid, COLOR_YELLOW, "* Job-ul %d a fost vandut cu succes la stat!", JobInfo[job][jID]);
	UpdateLabel(5, job);
	return true;
}


cmd:givehouse(playerid, params[]) {
	if !IsAdmin(playerid, 6) *then
		return true;

	extract params -> new player:id, houseid; else
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/givehouse <playerid/name> <house id>");
	
	if !IsPlayerConnected(id) *then return SendClientMessage(playerid, COLOR_GREY, "Player not connected!");
	if !IsPlayerLogged(id) *then return SendClientMessage(playerid, COLOR_GREY, "Player not logged!");
	if houseid < 1 || houseid > sql_houses *then return SendClientMessage(playerid, COLOR_GREY, "Invalid house ID!");
	if !HouseInfo[houseid][hID] *then return SendClientMessage(playerid, COLOR_GREY, "Invalid house ID!");

	SendAdminMessage(COLOR_YELLOW, 1, "* Admin %s i-a dat lui %s(%d) casa %d.", GetName(playerid), GetName(id), id, houseid);
	va_SendClientMessage(id, COLOR_YELLOW,  "* Admin %s ti-a dat casa %d.", GetName(playerid), houseid);

    PlayerInfo[id][pHouse] = houseid;
	HouseInfo[houseid][hOwned] = 1;
	HouseInfo[houseid][hValue] = 0;

	UpdateLabel(1, houseid);
	strmid(HouseInfo[houseid][hOwner], PlayerInfo[id][pUsername], 0, 24);

	_query("UPDATE `users` SET `House`='999' WHERE `House`='%d'", HouseInfo[houseid][hID]);
	_query("UPDATE `users` SET `House`='%d' WHERE `ID`='%d'", houseid, PlayerInfo[id][pSQLID]);
	_query("UPDATE `houses` SET `Owned`='1', `Owner`='%s', `Value`='0' WHERE `ID`='%d'", HouseInfo[houseid][hOwner], HouseInfo[houseid][hID]);
	return true;
}
cmd:givejob(playerid, params[]) {
	if !IsAdmin(playerid, 6) *then
		return true;

	extract params -> new player:id, jobid; else
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/givejob <playerid/name> <job id>");
	
	if !IsPlayerConnected(id) *then return SendClientMessage(playerid, COLOR_GREY, "Player not connected!");
	if !IsPlayerLogged(id) *then return SendClientMessage(playerid, COLOR_GREY, "Player not logged!");
	if jobid < 1 || jobid > sql_jobs *then return SendClientMessage(playerid, COLOR_GREY, "Invalid job ID!");
	if !JobInfo[jobid][jID] *then return SendClientMessage(playerid, COLOR_GREY, "Invalid job ID!");

	_query("UPDATE `users` SET `JobOwner`='16' WHERE `JobOwner`='%d'", JobInfo[jobid][jID]);
	PlayerInfo[id][pJobOwner] = jobid;
	_query("UPDATE `users` SET `JobOwner`='%d' WHERE `ID`='%d'", jobid, PlayerInfo[id][pSQLID]);
	format(gString, 128, "* Admin %s i-a dat lui %s(%d) job-ul %d.", GetName(playerid), GetName(id), id, jobid);
	SendAdminMessage(COLOR_YELLOW, 1, gString);
	SCMf(id, COLOR_YELLOW,  "* Admin %s ti-a dat job-ul %d.", GetName(playerid), jobid);
	JobInfo[jobid][jOwner] = 1;
	strmid(JobInfo[jobid][jOwner], PlayerInfo[id][pUsername], 0, 24);
	UpdateLabel(5, jobid);
	_query("UPDATE `jobs` SET `Owner`='%s' WHERE `ID`='%d'", JobInfo[jobid][jOwner], JobInfo[jobid][jID]);
	return true;
}	

cmd:givebiz(playerid, params[]) {
	if !IsAdmin(playerid, 6) *then
		return true;

	extract params -> new player:id, biz; else
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/givehouse <playerid/name> <biz id>");
	
	if !IsPlayerConnected(id) *then return SendClientMessage(playerid, COLOR_GREY, "Player not connected!");
	if !IsPlayerLogged(id) *then return SendClientMessage(playerid, COLOR_GREY, "Player not logged!");
	if biz < 1 || biz > bussines *then return SendClientMessage(playerid, COLOR_GREY, "Invalid business ID!");
	if !BizzInfo[biz][bID] *then return SendClientMessage(playerid, COLOR_GREY, "Invalid business ID!");

	_query("UPDATE `users` SET `Bizz`='255' WHERE `Bizz`='%d'", BizzInfo[biz][bID]);
	PlayerInfo[id][pBizz] = biz;
	_query("UPDATE `users` SET `Bizz`='%d' WHERE `ID`='%d'", biz, PlayerInfo[id][pSQLID]);
	format(gString, 128, "* Admin %s i-a dat lui %s(%d) afacerea %d.", GetName(playerid), GetName(id), id, biz);
	SendAdminMessage(COLOR_WHITE, 1, gString);
	SCMf(id, COLOR_YELLOW, "* Admin %s ti-a dat afacerea %d.", GetName(playerid), biz);
	BizzInfo[biz][bOwned] = 1;
	strmid(BizzInfo[biz][bOwner], PlayerInfo[id][pUsername], 0, 24);
	BizzInfo[biz][bBuyPrice] = 0;
	UpdateLabel(2, biz);
	_query("UPDATE `bizz` SET `Owned`='1', `Owner`='%s', `BuyPrice`='0' WHERE `ID`='%d'", PlayerInfo[id][pUsername], BizzInfo[biz][bID]);
	return true;
}	
	
cmd:asellhouse(playerid, params[]) {
	if !IsAdmin(playerid, 5) *then 
		return SendClientMessage(playerid, COLOR_GREY, "Nu ai nivelul necesar de admin pentru a face asta.");
	
	extract params -> new house; else
	 	return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/asellhouse <House ID>");

	foreach(new i : logged_players) if PlayerInfo[i][pHouse] == house *then { PlayerInfo[i][pHouse] = 999, PlayerInfo[i][pRented]=-1; break; }
	HouseInfo[house][hHel]=HouseInfo[house][hArm]=HouseInfo[house][hLock]=HouseInfo[house][hValue]=0,HouseInfo[house][hOwned] = 1;
	_query("UPDATE `houses` SET `Hel`='0',`Arm`='0',`Lockk`='0',`Owned`='1',`Owner`='The State',`Value`='0' WHERE `ID`='%d'",house);
	_query("UPDATE `users` SET `House`='999' WHERE `name`='%s'",HouseInfo[house][hOwner]);
	strmid(HouseInfo[house][hOwner], "The State", 0, 24);
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	SCMf(playerid, COLOR_YELLOW, "* Casa %d a fost vandut cu succes la stat!", house);
	UpdateLabel(1, house);
	return true;
}

cmd:fpk(playerid, params[]) {
	if !IsAdmin(playerid, 4) *then 
		return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);

	extract params -> new player:id, fp, string:reson[32]; else
		return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/auninvite <playerid/name> <faction punish> <reason>");

	if(0 < fp > 100) 
		return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Poit da intre 0 si 100 Faction Punish");

	if !IsPlayerConnected(id) *then
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");

	if !IsPlayerLogged(id) *then
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este logat!");

	if(PlayerInfo[id][pMember] == 0) return SendClientMessage(playerid, -1, "Acel player nu este intr-o factiune!");
	format(gString, 128, "Admin-ul %s l-a scos pe %s din factiunea %s (rank %d) si %d zile, %d FP, motiv: %s.", GetName(playerid), GetName(id), FactionName(PlayerInfo[id][pMember]), PlayerInfo[id][pRank], PlayerInfo[id][pDays], fp, reson);
	SendAdminMessage(COLOR_LIGHTRED, 4, gString);
	
	format(gString, 128, "* Ai fost scos din factiunea %s (rank %d) dupa %d zile de admin-ul %s cu %d FP, motiv: %s.",FactionName(PlayerInfo[id][pMember]), PlayerInfo[id][pRank], PlayerInfo[id][pDays], GetName(playerid), fp, reson);
	SendClientMessage(id, COLOR_LIGHTBLUE, gString);
	format(gString, 128, "%s was uninvited by %s from faction %s (rank %d) after %d days with %d FP, reason: %s.", PlayerInfo[id][pUsername],PlayerInfo[playerid][pUsername],FactionName(PlayerInfo[id][pMember]),PlayerInfo[id][pRank],PlayerInfo[id][pDays], fp, reson);
	new hour,minute,seconds, days, mounth, year; gettime(hour,minute,seconds),getdate(days, mounth, year);
	insertFactionLogs(playerid, id, gString);
	Iter_Remove(faction_players<PlayerInfo[id][pMember]>, id);
	if(PlayerInfo[id][pMember]&&PlayerInfo[id][pRank]==7) Iter_Remove(faction_leaders, id);

	if(fp==0) format(gString, sizeof gString, "%s, %s was uninvited by %s from faction %s (rank %d) after %d days, without FP. Reason: %s.", PlayerInfo[id][pUsername], PlayerInfo[id][pUsername], PlayerInfo[playerid][pUsername], FactionName(PlayerInfo[id][pMember]), PlayerInfo[id][pRank], PlayerInfo[id][pDays], reson);
	else format(gString, sizeof gString, "%s, %s was uninvited by %s from faction %s (rank %d) after %d days, with %d FP. Reason: %s.", PlayerInfo[id][pUsername], PlayerInfo[id][pUsername], PlayerInfo[playerid][pUsername], FactionName(PlayerInfo[id][pMember]), PlayerInfo[id][pRank], PlayerInfo[id][pDays], fp, reson);
	factionLog(PlayerInfo[id][pMember], gString);

	if(svfCar[id]) destroySVF(id);
	FactionMembers[PlayerInfo[id][pMember]] --;
	new faction = PlayerInfo[id][pMember];
	PlayerInfo[id][pMember]=PlayerInfo[id][pLeader]=PlayerInfo[id][pTester]=false;
	StopReportLession(id);
	format(gString, 128, "Admin-ul %s l-a scos pe %s din factiunea %s (rank %d) si %d zile, %d FP, motiv: %s.", GetName(playerid), GetName(id), FactionName(faction), PlayerInfo[id][pRank], PlayerInfo[id][pDays], fp, reson);
	SendFactionMessage(faction, COLOR_CLIENT, gString);
	PlayerInfo[id][pRank] = 0;
	PlayerInfo[id][pFACWarns] = 0;
	PlayerInfo[id][pFpunish] += fp;
	PlayerInfo[id][pDays] = 0;
	PlayerInfo[id][pLW] = 0;
	UpdateVar(id, "LW", 0);		
	PlayerInfo[id][pExpLW] = -1;
	UpdateVar(id, "ExpLW", PlayerInfo[id][pExpLW]);		
	OnDuty[id] = 0;
	SetPlayerSkin(id, 60);
	PlayerTextDrawHide(id, dutyTD);
	tazer[id] = 0;
	SetPlayerArmourEx(id, 0);
	SetPlayerToTeamColor(id);
	_query("UPDATE users SET `Member`='0',`Leader`='0',`Rank`='0',`FWarn`='0',`FPunish`='%d',`Days`='0',`Tester`='0' WHERE `ID`='%d'", PlayerInfo[id][pFpunish], PlayerInfo[id][pSQLID]);
	ResetWeapons(id);
	PlayerTextDrawHide(playerid, JobTD);
	return true;
}

cmd:specme(playerid) {
	if(!IsAdmin(playerid, 4))
		return SendClientMessage(playerid, COLOR_GREY, AdminOnly);
	
	SendClientMessage(playerid, COLOR_WHITE, (DontSpec[playerid]=!DontSpec[playerid])?"Incepand de acum nu o sa mai fi deranjat.":"Ai dezactivat aceasta optiune!");
	return true;
}

cmd:spec(playerid, params[]) {
	if !IsAdmin(playerid, 1) && !IsHelper(playerid, 2) *then 
		return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);

	extract params -> new player:id; else
		return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/spec <playerid/name>");


	if !IsPlayerConnected(id) *then 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");

	if id == playerid *then 
		return SendClientMessage(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda asupra ta!");

	if(DontSpec[id]) return SendClientMessage(playerid, COLOR_GREY, "Acel player este ocupat!");

	if !IsAdmin(playerid, PlayerInfo[playerid][pAdmin]) *then 
		return SendClientMessage(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda pe acel player.");

	if !IsPlayerLogged(id) *then 
		return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Acel player se loghiaza!");

	if Spectate[id]!=-1 *then 
		return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Acel player este ocupat!");

	Unspec[playerid][sInInterior]=InInterior[playerid];
	Unspec[playerid][sInInteriorID]=InInteriorID[playerid];
	GetPlayerPos(playerid, Unspec[playerid][sPx], Unspec[playerid][sPy], Unspec[playerid][sPz]);
 	pInteriorID[playerid] = GetPlayerInterior(playerid);
	pVirtual[playerid] = GetPlayerVirtualWorld(playerid);

	if(Iter_Contains(report_players, id) && report_type[id] != 4 && PlayerInfo[playerid][pAdmin] >= 1) {
		switch(report_type[id]) {
			case 1: {
				_query("UPDATE `users` SET `A_DM`=`A_DM`+'1' WHERE `id` = '%i'", PlayerInfo[playerid][pSQLID]);
				format(gString, 180, "%s %s is now spectating %s. (reported for dm, score: %d)", !IsAdmin(playerid, 1)?("Helper"):("Admin"), GetName(playerid),GetName(id), value_report[id]); 
			}
			case 2: {
				_query("UPDATE `users` SET `Cheaters`=`Cheaters`+'1' WHERE `id` = '%i'", PlayerInfo[playerid][pSQLID]);
				format(gString, 180, "%s %s is now spectating %s. (reported for cheats, score: %d)", !IsAdmin(playerid, 1)?("Helper"):("Admin"), GetName(playerid),GetName(id), value_report[id]);  
			}
			case 3: {
				_query("UPDATE `users` SET `Stucks`=`Stucks`+'1' WHERE `id` = '%i'", PlayerInfo[playerid][pSQLID]);
				format(gString, 180, "%s %s is now spectating %s. (stuck)", !IsAdmin(playerid, 1)?("Helper"):("Admin"), GetName(playerid),GetName(id));
			}
		}
		Iter_Remove(report_players, id);
		show_admin_report();
		report_type[id] = 0;
		HelpText[id][0] = (EOS);
		if(Iter_Contains(newbie_players, id)) Iter_Remove(newbie_players, id);
		updateRaport(playerid);
		SendAdminMessage(COLOR_YELLOW, 1, gString);		
	} 
	setPlayerSpec(playerid,id);
	return true;
}

stock setPlayerSpec(playerid, forplayerid) {
	if Spectate[playerid]!=-1 *then 
		Iter_Remove(MySpec<Spectate[playerid]>, playerid),
		Iter_Remove(StreamedPlayer[Spectate[playerid]], playerid);

	Spectate[playerid] = forplayerid;
	PlayerInfo[playerid][pChatCMD]=11;

	new Float:HP;GetPlayerHealthEx(forplayerid,HP);
	SCMf(playerid, 0xFFADADFF, "[SPEC] (%d) %s | Level: %d | Health: %.2f | AFK Time: %d | Seconds: %.0f | Duty: %d | Ping: %d",forplayerid,GetName(forplayerid),PlayerInfo[forplayerid][pLevel], HP, AFKSeconds[forplayerid], PlayerInfo[forplayerid][pSeconds], OnDuty[forplayerid], GetPlayerPing(forplayerid));

	new weapon, ammo, i=-1, guns; gString = "Weapons:";
	while(++i<13) {
		GetPlayerWeaponData(forplayerid,i,weapon,ammo);
		if !weapon *then continue;
		format(gQuery, 60, " %s(%d)", GunNames[weapon], ammo),strcat(gString,gQuery),guns ++;
	}
	if guns *then SendClientMessage(playerid, -1, gString);
	Iter_Add(MySpec<forplayerid>, playerid);
	Iter_Add(StreamedPlayer[forplayerid], playerid);

	TogglePlayerSpectating(playerid, 1);
	SetPlayerInterior(playerid, GetPlayerInterior(forplayerid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(forplayerid));
	
	if(IsPlayerInAnyVehicle(Spectate[playerid])) PlayerSpectateVehicle(playerid, GetPlayerVehicleID(Spectate[playerid]));
	else PlayerSpectatePlayer(playerid, Spectate[playerid]);
	
	PlayerTextDrawSetString(playerid, SpectatorTD, "Loading...");
	PlayerTextDrawShow(playerid, SpectatorTD);	
	return true;
}

cmd:specoff(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 2) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	if(Spectate[playerid] == -1) return true;
	TogglePlayerSpectating(playerid, false);
	return true;
}

cmd:skick(playerid, params[]) {
	new id,string[100];
	if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pHelper] < 2) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	if(sscanf(params, "u", id)) return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/skick <playerid/name>");
	if(id == playerid) return SendClientMessage(playerid, COLOR_GREY, "Nu iti poti da kick singur.");
	if(!IsPlayerConnected(id) || !IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
	if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, -1, "Nu poti folosi comanda aceasta pe acel player.");
	if(PlayerInfo[id][pAdmin] != 0 && PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, -1, "Nu poti da kick unui admin!");
	format(string, sizeof(string), "SKick: %s a primit kick de la %s.",GetName(id),GetName(playerid));
	if(GetPVarInt(playerid, "Cover") == 0) SendStaffMessage(COLOR_RED, string);
	KickEx(id);
	return true;
}

cmd:givepp(playerid, params[]) {
	if(!IsAdmin(playerid, 6)) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	new money,id,string[180],reason[64];
	if(sscanf(params, "uis[64]",id,money,reason)) return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/givepp <playerid/name> <points> <reason>");
	if(!IsPlayerConnected(id) || !IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");	
	PlayerInfo[id][pPremiumPoints] += money;
	format(string, sizeof(string), "%s i-a dat %s Premium Points lui %s, motiv: %s.", GetName(playerid),FormatNumber(money),GetName(id), reason);
	if(GetPVarInt(playerid, "Cover") == 0) SendAdminMessage(COLOR_YELLOW, 5, string);
	format(string, sizeof(string), "* Ai primit %s Premium Points de la administratorul %s, motiv: %s.", FormatNumber(money), GetName(playerid), reason);
	SendClientMessage(id, COLOR_YELLOW, string);
	UpdateVar(id, "GoldPoints", PlayerInfo[id][pPremiumPoints]);
	return true;
}
cmd:giveep(playerid, params[]) {
	if(!IsAdmin(playerid, 6)) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	new money,id,string[180],reason[64];
	if(sscanf(params, "uis[64]",id,money,reason)) return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/giveep <playerid/name> <points> <reason>");
	if(!IsPlayerConnected(id) || !IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");	
	PlayerInfo[id][pBPoints] += money;
	format(string, sizeof(string), "%s i-a dat %s b-points lui %s, motiv: %s.", GetName(playerid),FormatNumber(money),GetName(id), reason);
	if(GetPVarInt(playerid, "Cover") == 0) SendAdminMessage(COLOR_YELLOW, 5, string);
	format(string, sizeof(string), "* Ai primit %s b-points de la administratorul %s, motiv: %s.", FormatNumber(money), GetName(playerid), reason);
	SendClientMessage(id, COLOR_YELLOW, string);
	UpdateVar(id, "BPoints", PlayerInfo[id][pBPoints]);
	return true;
}
cmd:giverp(playerid, params[]) {
	if(!IsAdmin(playerid, 6)) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	new money,id,string[180],reason[64];
	if(sscanf(params, "uis[64]",id,money,reason)) return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/giverp <playerid/name> <points> <reason>");
	if(!IsPlayerConnected(id) || !IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");	
	PlayerInfo[id][pExp] += money;
	format(string, sizeof(string), "%s i-a dat %s Respect Points lui %s, motiv: %s.", GetName(playerid),FormatNumber(money),GetName(id), reason);
	if(GetPVarInt(playerid, "Cover") == 0) SendAdminMessage(COLOR_YELLOW, 5, string);
	format(string, sizeof(string), "* Ai primit %s Respect Points de la administratorul %s, motiv: %s.", FormatNumber(money), GetName(playerid), reason);
	SendClientMessage(id, COLOR_YELLOW, string);
	UpdateVar(id, "Respect", PlayerInfo[id][pExp]);
	return true;
}
cmd:givegf(playerid, params[]) {
	if(!IsAdmin(playerid, 6)) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	new money,id,string[180],reason[64];
	if(sscanf(params, "uis[64]",id,money,reason)) return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/giverp <playerid/name> <points> <reason>");
	if(!IsPlayerConnected(id) || !IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");	
	PlayerInfo[id][pGiftPoints] += money;
	format(string, sizeof(string), "%s i-a dat %s Gift Points lui %s, motiv: %s.", GetName(playerid),FormatNumber(money),GetName(id), reason);
	if(GetPVarInt(playerid, "Cover") == 0) SendAdminMessage(COLOR_YELLOW, 5, string);
	format(string, sizeof(string), "* Ai primit %s Gift Points de la administratorul %s, motiv: %s.", FormatNumber(money), GetName(playerid), reason);
	SendClientMessage(id, COLOR_YELLOW, string);
	UpdateVar(id, "GiftPoints", PlayerInfo[id][pGiftPoints]);
	return true;
}
cmd:kick(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 3) 
		return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);

	if(DeelayCommand[playerid][2]>gettime()) 
		return DeelayTime(playerid, 2);

	new id;
	if(sscanf(params, "us[128]", id, params)) 
		return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/kick <playerid/name> <reason>");

	if(playerid == id)
		return SendClientMessage(playerid, COLOR_GREY, "Nu iti poti da kick singur!");

	if(!IsPlayerConnected(id)) 
		return SendClientMessage(playerid, COLOR_GREY, "Player not connected.");

	if(!IsPlayerLogged(id)) 
		return SendClientMessage(playerid, COLOR_GREY, "Player not logged.");

	if(FaceReclama(params)) 
		return RemoveFunction(playerid, params);

	if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda pe acel player.");

	DeelayCommand[playerid][2] = gettime()+10; gString[0] = gQuery[0] = (EOS);
	format(gString, 128, "Kick: %s was kicked by %s, reason: %s", GetName(id), GetName(playerid), params);
	MesajLung2(COLOR_LIGHTRED, gString);

	InsereazaSanctiune(id, playerid, KICK, params);	
	_query("UPDATE `users` SET `Kicks` = `Kicks` + '1' WHERE `id` = '%i'", PlayerInfo[id][pSQLID]);
	KickEx(id);		
	return true;
}
cmd:rac(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	for(new car=1;car<=GetVehiclePoolSize();car++) if(!IsVehicleOccupied(car)) SetVehicleToRespawn(car); 

	gString[0] = (EOS);
    format(gString, 128, "Admin %s a respawnat toate vehiculele nefolosite!", GetName(playerid));
	SendAdminMessage(0xFFADADFF, 3, gString);
	return true;
}
cmd:warn(playerid, params[]) {
	if !IsAdmin(playerid, 1) *then
		return SendClientMessage(playerid, COLOR_WHITE,  AdminOnly);
	
	if DeelayCommand[playerid][1]>gettime() *then 
		return DeelayTime(playerid, 1);


	extract params -> new player:id, string:reason[32]; else
		return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/warn <playerid/name> <reason>");

	if id == playerid *then 
		return SendClientMessage(playerid, COLOR_GREY, "Nu iti poti da warn singur.");

	if !IsPlayerConnected(id) *then 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");

	if FaceReclama(reason) *then
		return RemoveFunction(playerid, reason);

	if PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] *then 
		return SendClientMessage(playerid, -1, "Nu poti folosi comanda aceasta pe acel player.");

	format(gString, 128, "AdmBot: %s a primit o avertizare de la %s, motiv: %s", GetName(id), GetName(playerid), reason);
	SCMTA(COLOR_LIGHTRED, gString);
	InsereazaSanctiune(id, playerid, WARN, reason);
	UpdateVar(id, "Warnings", ++PlayerInfo[id][pWarns]);

	if PlayerInfo[id][pWarns] >= 3 *then {
		new day, mounth, year, hour, minute, seconds;
		gettime(hour, minute, seconds), getdate(year, mounth, day);
		gString[0] = (EOS);
		format(gString, 128, "Ban: %s was banned by %s for 3 days, reason: 3/3 warns", GetName(id), GetName(playerid));
		MesajLung2(COLOR_LIGHTRED, gString);		
		format(gString, 60, "%02d-%02d-%02d %02d:%02d:%02d", day, mounth, year, hour, minute, seconds);
		mysql_format(SQL, gQuery, 256, "INSERT INTO `bans` (`PlayerName`, `AdminName`, `Reason`, `Date`, `Userid`, `ByUserid`, `Days`, `Time`) VALUES ('%e', '%e', '3/3 warns', '%e', '%i', '%i', '3', '%i')",
			GetName(id), GetName(playerid), gString, PlayerInfo[id][pSQLID], PlayerInfo[playerid][pSQLID], gettime()+(3*86400));
		mysql_tquery(SQL, gQuery);

		DeelayCommand[playerid][1] = gettime()+10;
		PlayerInfo[id][pWarns] = 0;
		_query("UPDATE `users` SET `Warns` = `Warns` + '1' WHERE `id` = '%i'", PlayerInfo[playerid][pSQLID]);
		UpdateVar(id, "Warnings", PlayerInfo[id][pWarns]);
		InsereazaSanctiune(id, playerid, BAN, "3/3 warns");
		Banlog(playerIP[id],PlayerInfo[id][pUsername], PlayerInfo[playerid][pUsername],"3 Warnings",2);
		KickEx(id);
	}				
	return true;
}
cmd:warno(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_WHITE,  AdminOnly);
	if(DeelayCommand[playerid][1]>gettime()) return DeelayTime(playerid, 1);
	new id[25],reason[128],cont;
	if(sscanf(params, "s[25]s[128]", id, reason)) return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/warno <name> <reason>");
	cont = MySQLCheckAccount(id);
	if(cont == -2) return SendClientMessage(playerid,COLOR_ERROR,"error:{FFFFFF} Acest cont nu a fost gasit in baza de date!");
	gQuery[0] = EOS;
	mysql_format(SQL, gQuery, sizeof(gQuery), "SELECT * FROM `users` WHERE `name`='%s'",id);
	mysql_tquery(SQL, gQuery, "CheckWarns", "iss", playerid, id, reason);		
	return true;
}
redist::CheckWarns(playerid, id[], reason[]) {
	new intid;
	gString[0] = EOS;
	if(cache_num_rows() > 0) cache_get_value_name_int(0, "Warns", intid);
	if(intid >= 3) {
		new day, mounth, year, hour, minute, seconds;
		gettime(hour, minute, seconds), getdate(year, mounth, day);
		gString[0] = (EOS);
		format(gString, 128, "Ban: %s was banned by %s for 3 days, reason: 3/3 warns", id, GetName(playerid));
		SendAdminMessage(COLOR_LIGHTRED, 1, gString);		
		format(gString, 60, "%02d-%02d-%02d %02d:%02d:%02d", day, mounth, year, hour, minute, seconds);
		mysql_format(SQL, gQuery, 256, "INSERT INTO `bans` (`PlayerName`, `AdminName`, `Reason`, `Date`, `Userid`, `ByUserid`, `Days`, `Time`) VALUES ('%e', '%e', '3/3 warns', '%e', '-2', '%i', '3', '%i')",
			id, GetName(playerid), gString, PlayerInfo[playerid][pSQLID], gettime()+(3*86400));
		mysql_tquery(SQL, gQuery);

		DeelayCommand[playerid][1] = gettime()+10;
		Banlog("Offline", id, PlayerInfo[playerid][pUsername], "3 Warnings", 2);
		intid = 0;
	}
	intid++;
	format(gString, 128, "Offline: %s a primit o avertizare de la %s, motiv: %s",id, GetName(playerid), reason);
	SendAdminMessage(COLOR_LIGHTRED, 1, gString);
	gQuery[0] = EOS;
	mysql_format(SQL, gQuery, sizeof(gQuery),"UPDATE users SET `Warnings`='%d' WHERE `name`='%s'",intid,id);
	mysql_tquery(SQL, gQuery, "", "");
	format(gString, 128, "Ai primit un warn de la %s, motiv %s.", GetName(playerid), reason);
	InsertEmail(id, GetName(playerid), gString);	
	return true;
}
cmd:unwarn(playerid, params[]) {
	if !IsAdmin(playerid, 4) *then 
		return SendClientMessage(playerid, COLOR_WHITE,  AdminOnly);

	extract params -> new player:id; else
		return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/unwarn <playerid/name>");

	if !IsPlayerConnected(id) *then 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");

	if !PlayerInfo[id][pWarns] *then 
		return SendClientMessage(playerid, COLOR_LGREEN, "* Acel player nu are avertizari!");

	UpdateVar(id, "Warnings", --PlayerInfo[id][pWarns]);
	format(gString, 128, "AdmBot: %s i-a sters un warn lui %s.", GetName(playerid), GetName(id));
	SendAdminMessage(COLOR_LIGHTRED, 1, gString);
	SCMf(id, COLOR_YELLOW, "* %s ti-a sters un warn!", GetName(playerid));
	return true;
}
cmd:bano(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) 
		return SendClientMessage(playerid,COLOR_WHITE,AdminOnly);

	if(DeelayCommand[playerid][0]>gettime()) 
		return DeelayTime(playerid, 0);

	new giveplayerid[MAX_PLAYER_NAME], days;
	if(sscanf(params, "s[25]ds[128]", giveplayerid, days, params)) 
		return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/bano <name> <0 = permanent/days> <reason>");

	if(FaceReclama(params)) return RemoveFunction(playerid, params);
	mysql_format(SQL, gQuery, 128, "SELECT * FROM `users` WHERE `name` = '%s' LIMIT 1", giveplayerid);
	mysql_tquery(SQL, gQuery, "sql_cache_player_ban", "isis", playerid, giveplayerid, days, params);	
	return true;
}

redist::sql_cache_player_ban(playerid, giveplayerid[], days, params[]) {
	if(!cache_num_rows()) return SendClientMessage(playerid, COLOR_GREY, "Acest cont nu exista!");

	new userID, admin;
	cache_get_value_name_int(0, "Status", userID);
	if(userID != -1) return SendClientMessage(playerid, COLOR_GREY, "Acel jucator este deja conectat!");
	cache_get_value_name_int(0, "Admin", admin);

	if(admin>=7) return true;

	if(admin>=PlayerInfo[playerid][pAdmin])
		return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Nu poti bana un admin de acelasi admin level ca si tine.");

	new day, mounth, year, hour, minute, seconds;
	gettime(hour, minute, seconds), getdate(year, mounth, day);
	gString[0] = (EOS);
	if(!days) {
		format(gString, 128, "Ban: %s (offline) has been permanent banned by %s, reason: %s", giveplayerid, GetName(playerid), params);
		SendAdminMessage(COLOR_LIGHTRED, 1, gString);	
		format(gString, 60, "%02d-%02d-%02d %02d:%02d:%02d", day, mounth, year, hour, minute, seconds);
		mysql_format(SQL, gQuery, 256, "INSERT INTO `bans` (`PlayerName`, `AdminName`, `Reason`, `Date`, `Userid`, `ByUserid`) VALUES ('%e', '%e', '%e', '%e', '-2', '%i')",
			giveplayerid, GetName(playerid), params, gString, PlayerInfo[playerid][pSQLID]);
		mysql_tquery(SQL, gQuery);
	}
	else {
		format(gString, 128, "Ban: %s (offline) was banned by %s for %d days, reason: %s", giveplayerid, GetName(playerid), days, params);
		SendAdminMessage(COLOR_LIGHTRED, 1, gString);	
		format(gString, 60, "%02d-%02d-%02d %02d:%02d:%02d", day, mounth, year, hour, minute, seconds);
		mysql_format(SQL, gQuery, 256, "INSERT INTO `bans` (`PlayerName`, `AdminName`, `Reason`, `Date`, `Userid`, `ByUserid`, `Days`, `Time`) VALUES ('%e', '%e', '%e', '%e', '-2', '%i', '%i', '%i')",
			giveplayerid, GetName(playerid), params, gString, PlayerInfo[playerid][pSQLID], days, gettime()+(days*86400));
		mysql_tquery(SQL, gQuery);
	}
	DeelayCommand[playerid][0] = gettime()+10;
	Banlog("Offline",giveplayerid,PlayerInfo[playerid][pUsername],params,days);	
	return true;
}

cmd:healme(playerid, params[]) {
	if(!IsAdmin(playerid, 1))
		return true;

	SetPlayerHealth(playerid, 100.0);
	SendClientMessage(playerid, 0xFFADADFF, "Ti-ai incarcat viata!");
	return true;
}


cmd:respawn(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) 
		return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);

	if(sscanf(params, "u", params[0])) 
		return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/respawn <playerid/name>");

	if(!IsPlayerConnected(params[0]))
		return SendClientMessage(playerid, COLOR_GREY, "Player not connected.");

	if(!IsPlayerLogged(params[0]))
		return SendClientMessage(playerid, COLOR_GREY, "Player not logged.");

	if(PlayerInfo[params[0]][pAdmin] > PlayerInfo[playerid][pAdmin]) 
		return SendClientMessage(playerid, -1, "Nu poti folosi comanda aceasta pe acel player.");

	gString[0] = (EOS);
	SCMf(params[0], 0xFFADADFF, "You have been spawned by %s.", GetName(playerid));
	format(gString, 128, "Admin %s used /spawn on %s.", GetName(playerid), GetName(params[0]));
	if(GetPVarInt(playerid, "Cover") == 0) SendAdminMessage(0xFFADADFF, 4, gString);
	SpawnPlayer(params[0]);
	return true;
}
cmd:l(playerid, params[]) {
	if(PlayerInfo[playerid][pLeader] == 0 && PlayerInfo[playerid][pAdmin] == 0) return true;
	new text[250],string[250];
	if(sscanf(params, "s[250]",text)) return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/l <text>");
	if(PlayerInfo[playerid][pAdmin] >= 1) format(string, sizeof(string), "* Admin %s: %s",GetName(playerid), text);
	else format(string, sizeof(string), "Leader %s %s: %s",FactionName(PlayerInfo[playerid][pLeader]),GetName(playerid), text);
	LeaderChat(0xA2C791FF, string);
	return true;
}

cmd:e(playerid, params[]) {
	if(PlayerInfo[playerid][pHelper]== 0 && PlayerInfo[playerid][pAdmin] == 0) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu esti helper.");

	if(sscanf(params, "s[144]", params)) 
		return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/e <text>");
	
	if(IsAdmin(playerid, 1)) format(gString, 180, "* (%d) Admin %s: %s", PlayerInfo[playerid][pAdmin], GetName(playerid), params);
	else format(gString, 180, "* (%d) Helper %s: %s", PlayerInfo[playerid][pHelper], GetName(playerid), params);
	SendStaffMessage(0xff8C1AFF, gString);
	return true;
}

cmd:ban(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	if(DeelayCommand[playerid][0]>gettime()) return DeelayTime(playerid, 0);
	new id, type;
	if(sscanf(params, "uds[128]", id,type,params)) return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/ban <playerid/name> <days | 0 = permanent> <reason>");
	if(!IsPlayerConnected(id) || !IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_GREY, "Nu iti poti da ban singur.");
	if(FaceReclama(params)) return RemoveFunction(playerid, params);
	if(PlayerInfo[id][pAdmin] >= 7) return true;
	if(PlayerInfo[id][pAdmin] >= PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, -1, "Acel player are adminul mai mare ca tine!");
	InsereazaSanctiune(id, playerid, BAN, params);		
	
	new day, mounth, year, hour, minute, seconds;
	gettime(hour, minute, seconds), getdate(year, mounth, day);
	gString[0] = (EOS);
	if(!type) {
		if(strcmp(params, "silent", true)) {
			format(gString, 128, "Ban: %s has been permanent banned by %s, reason: %s", GetName(id), GetName(playerid), params);
			MesajLung2(COLOR_LIGHTRED, gString);		
		} else {
			format(gString, 128, "Silent: %s has been permanent banned by %s.", GetName(id), GetName(playerid), params);
			SendAdminMessage(COLOR_LIGHTRED, 1, gString);
		}
		Banlog(GetIPP(id),PlayerInfo[id][pUsername],PlayerInfo[playerid][pUsername],params,0);
		format(gString, 60, "%02d-%02d-%02d %02d:%02d:%02d", day, mounth, year, hour, minute, seconds);
		mysql_format(SQL, gQuery, 256, "INSERT INTO `bans` (`PlayerName`, `AdminName`, `Reason`, `Date`, `Userid`, `ByUserid`) VALUES ('%e', '%e', '%e', '%e', '%i', '%i')",
			PlayerInfo[id][pUsername], PlayerInfo[playerid][pUsername], params, gString, PlayerInfo[id][pSQLID], PlayerInfo[playerid][pSQLID]);
		mysql_tquery(SQL, gQuery);
		KickEx(id);
	}
	else {
		if(strcmp(params, "silent", true)) {
			format(gString, 128, "Ban: %s was banned by %s for %d days, reason: %s", GetName(id), GetName(playerid), type, params);
			MesajLung2(COLOR_LIGHTRED, gString);		
		} else {
			format(gString, 128, "Silent: %s was banned by %s for %d days.", GetName(id), GetName(playerid), type, params);
			SendAdminMessage(COLOR_LIGHTRED, 1, gString);
		}
		Banlog(GetIPP(id),PlayerInfo[id][pUsername],PlayerInfo[playerid][pUsername],params,type);
		KickEx(id);
		format(gString, 60, "%02d-%02d-%02d %02d:%02d:%02d", day, mounth, year, hour, minute, seconds);
		mysql_format(SQL, gQuery, 256, "INSERT INTO `bans` (`PlayerName`, `AdminName`, `Reason`, `Date`, `Userid`, `ByUserid`, `Days`, `Time`) VALUES ('%e', '%e', '%e', '%e', '%i', '%i', '%i', '%i')",
			PlayerInfo[id][pUsername], PlayerInfo[playerid][pUsername], params, gString, PlayerInfo[id][pSQLID], PlayerInfo[playerid][pSQLID], type, gettime()+(type*86400));
		mysql_tquery(SQL, gQuery);
	}
	SendClientMessage(id,COLOR_WARNING,"Ai fost banat! Daca consideri ca ai luat ban degeaba, poti face o cerere pe (panel.e-times.ro).");
	DeelayCommand[playerid][0] = gettime()+10;			
	return true;
}

cmd:myraport(playerid) {
	if(!IsAdmin(playerid, 1)&&!IsHelper(playerid, 1))
		return SendClientMessage(playerid, COLOR_GREY, AdminOnly);

	mysql_format(SQL, gQuery, sizeof gQuery, "SELECT * FROM `users` WHERE `id` = '%i'",  PlayerInfo[playerid][pSQLID]);
	mysql_tquery(SQL, gQuery, #SQL_cache_raport, #i, playerid);
	return true;
}

redist::SQL_cache_raport(playerid) {
	new Float:week;
	SCMf(playerid, 0xFA6F42FF, "[%s RAPORT]", IsAdmin(playerid, 1) ? "ADMIN" : "HELPER");
	cache_get_value_name_float(0, "ConnectedMonth", week);
	if(IsAdmin(playerid, 1)) {
		new stucks,cheaters,complaints,dm;

		cache_get_value_name_int(0, "Stucks", stucks);
		cache_get_value_name_int(0, "Cheaters", cheaters);
		cache_get_value_name_int(0, "A_DM", dm);
		cache_get_value_name_int(0, "Complaints", complaints);

		SCMf(playerid, -1, "{FF0000}>> {FFFFFF}Stucks: %d {FF0000}<<", stucks);
		SCMf(playerid, -1, "{FF0000}>> {FFFFFF}Cheaters: %d {FF0000}<<", cheaters);
		SCMf(playerid, -1, "{FF0000}>> {FFFFFF}DM: %d {FF0000}<<", dm);
		SCMf(playerid, -1, "{FF0000}>> {FFFFFF}Complaints: %d {FF0000}<<", complaints);
		SCMf(playerid, -1, "{FF0000}>> {FFFFFF}Total progress: %d/%d {FF0000}<<", stucks+cheaters+dm+complaints, admin_raport);
		SCMf(playerid, -1, "{FF0000}>> {FFFFFF}Last 7 days: %.02f hours {FF0000}<<", week);
		SCMf(playerid, -1, "{FF0000}>> {FFFFFF}Total complaints: %d {FF0000}<<", complaints);
	} else {
		new helped;

		cache_get_value_name_int(0, "HelpedPlayersToday", helped);

		SCMf(playerid, -1, "{FF0000}>> {FFFFFF}Raport progress: %d/%d {FF0000}<<", helped, helper_raport);
		SCMf(playerid, -1, "{FF0000}>> {FFFFFF}Last 7 days: %.02f hours {FF0000}<<", week);
	}
	return true;
}

cmd:unbanip(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 2) 
		return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);

	new ip[16];
	if(sscanf(params, "s[16]", ip)) 
		return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/unbanip <ip>");

	mysql_format(SQL, gQuery, 128, "SELECT * FROM `bans` WHERE `IP` = '%e' LIMIT 1", ip);
	mysql_tquery(SQL, gQuery, "SQL_CHECK_BAN_IP", "is", playerid, ip);	
	return true;
}

redist::SQL_CHECK_BAN_IP(playerid, ip[]) {
	if(!cache_num_rows()) return SendClientMessage(playerid, COLOR_GREY, "Acest IP nu a fost banat.");

	gString[0] = gQuery[0] = (EOS);
	mysql_format(SQL, gQuery, 128, "DELETE FROM `bans` WHERE `IP` = '%e' LIMIT 1", ip);
	mysql_tquery(SQL, gQuery);
	format(gString, 128, "Warning: %s a debanat IP-ul %s", GetName(playerid), ip);
	SendAdminMessage(0xFFADADFF, 3, gString);	
	return true;
}
cmd:banip(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	
	new id = INVALID_PLAYER_ID;

	extract params -> new string:ip[32], string:reason[64]; else
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/banip <playerid/username/IP> <reason>");

	sscanf(ip, "u", id);

	new day, mounth, year, hour, minute, seconds;
	gettime(hour, minute, seconds), getdate(year, mounth, day);

	if(id==INVALID_PLAYER_ID) {
		new i=-1,_ip;
		while(++i<strlen(ip)) if(ip[i] == '.') ++_ip;
		if(_ip!=3) return SendClientMessage(playerid, COLOR_GREY, "Invalid IP");
		format(gString, 128, "Ban: IP %s has been permanent banned by %s, reason: %s", ip, GetName(playerid), reason);
		SendAdminMessage(COLOR_LIGHTRED, 6, gString);		
		format(gString, 60, "%02d-%02d-%02d %02d:%02d:%02d", day, mounth, year, hour, minute, seconds);
		mysql_format(SQL, gQuery, 256, "INSERT INTO `bans` (`AdminName`, `Reason`, `Date`, `ByUserid`, `IP`) VALUES ('%e', '%e', '%e', '%i', '%s')",
			GetName(playerid), reason, gString, PlayerInfo[playerid][pSQLID], ip);
		mysql_tquery(SQL, gQuery, "SQL_Check_IP_BAN", "is", playerid, ip);
	} else {
		format(gString, 128, "Ban: %s has been permanent banned by %s, reason: %s", GetName(id), GetName(playerid), reason);
		SendClientMessageToAll(COLOR_LIGHTRED, gString);
		format(gString, 60, "%02d-%02d-%02d %02d:%02d:%02d", day, mounth, year, hour, minute, seconds);
		mysql_format(SQL, gQuery, 256, "INSERT INTO `bans` (`AdminName`, `Reason`, `Date`, `ByUserid`, `IP`) VALUES ('%e', '%e', '%e', '%i', '%s')",
			GetName(playerid), reason, gString, PlayerInfo[playerid][pSQLID], GetIPP(id));
		mysql_tquery(SQL, gQuery, "SQL_Check_IP_BAN", "is", playerid, GetIPP(id));
	}
	return true;
}
redist::SQL_Check_IP_BAN(playerid, ip[]) {
	foreach(new i : Player) {
		if(strcmp(GetIPP(i), ip, true)) continue;
		SCMf(i, COLOR_WARNING, "Admin %s ti-a banat IP-ul cu care ai fost conectat!", GetName(playerid));
		KickEx(i);
	}
	return true;
}

cmd:unban(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	new id[25];
	if(sscanf(params, "s[25]", id)) 
		return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/unban <account name>");

	mysql_format(SQL, gQuery, 128, "SELECT * FROM `bans` WHERE `PlayerName` = '%s' LIMIT 1", id);
	mysql_tquery(SQL, gQuery, "sql_cache_bans", "is", playerid, id);	
	return true;
}

redist::sql_cache_bans(playerid, const playername[]) {
	if(!cache_num_rows())
		return SendClientMessage(playerid, COLOR_GREY, "Acest cont nu este banat!");

	mysql_format(SQL, gQuery, 128, "DELETE FROM `bans` WHERE `PlayerName` = '%e' LIMIT 1", playername);
	mysql_tquery(SQL, gQuery);
	format(gString, 128, "Warning: %s i-a dat unban lui %s", GetName(playerid), playername);
	SendAdminMessage(0xFFADADFF, 3, gString);	
	return true;
}

cmd:sethraport(playerid, params[]) {
	if(!IsAdmin(playerid, 5))
		return SendClientMessage(playerid, COLOR_GREY, AdminOnly);

	new raport;
	if(sscanf(params, "i", raport))
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/sethraport <raport>");

	_query("UPDATE `stuff` SET `HelperRaport` = '%i'", raport);

	helper_raport=raport;
	format(gString, sizeof gString, "* Admin %s a schimbat raport-ul la helpers la %d.", GetName(playerid), raport);
	SendStaffMessage(COLOR_YELLOW, gString);
	return true;
}

cmd:setaraport(playerid, params[]) {
	if(!IsAdmin(playerid, 5))
		return SendClientMessage(playerid, COLOR_GREY, AdminOnly);

	new raport;
	if(sscanf(params, "i", raport))
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/setaraport <raport>");

	_query("UPDATE `stuff` SET `AdminRaport` = '%i'", raport);

	admin_raport=raport;
	format(gString, sizeof gString, "* Admin %s a schimbat raport-ul la admini la %d.", GetName(playerid), raport);
	SendStaffMessage(COLOR_YELLOW, gString);
	return true;
}

cmd:fpkoff(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	new id[25], msg[80];
	if(sscanf(params, "s[25]s[80]", id,msg)) return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/fpkoff <name> <reason>");
	
	mysql_format(SQL, gQuery, sizeof gQuery, "SELECT * FROM `users` WHERE `name` = '%s' LIMIT 1", id);
	mysql_tquery(SQL, gQuery, #SQL_fpk_off, #iss, playerid, id, msg);
	return true;
}

redist::SQL_fpk_off(playerid, const name[], const reason[]) {
	if(!cache_num_rows()) return SendClientMessage(playerid, COLOR_GREY, "Acest cont nu exista in baza de date!");

	new id=-1,member,sqlid;
	cache_get_value_name_int(0, "Status", id);
	cache_get_value_name_int(0, "Member", member);
	cache_get_value_name_int(0, "id", sqlid);
	if(id!=-1) return SendClientMessage(playerid, COLOR_GREY, "Acel player este deja online! (foloseste /fpk!)");
	if(!member) return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este in factiune!");

	_query("UPDATE users SET `Member`='0', `Leader`='0', `Rank`='0', `Days`='0'  WHERE `id`='%i'", sqlid);
	SCMf(playerid, COLOR_YELLOW, "%s a fost scos din factiune.", name);
	return true;
}

cmd:muteo(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	new id[25],cont,msg[80],time,string[184];
	if(sscanf(params, "s[25]is[80]", id,time,msg)) return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/muteo <name> <Time(minutes)> <reason>");
	if(FaceReclama(msg)) return RemoveFunction(playerid, msg);
	cont = MySQLCheckAccount(id);
	if(cont == -2) return SendClientMessage(playerid,COLOR_ERROR,"error:{FFFFFF} Acest cont nu a fost gasit in baza de date!");
	if(time <= 0) return SendClientMessage(playerid,-1, "Invalid mute time.");
	
	new szQuery[256];
	mysql_format(SQL, szQuery,sizeof(szQuery),"UPDATE users SET `Muted`='1',`MuteTime`='%d' WHERE `name`='%s'",time*60,id);
	mysql_tquery(SQL,szQuery, "", "");
	
	format(string, sizeof(string), "Ai primit mute de la %s pentru %d minute, motiv %s.", GetName(playerid), time, msg);
	InsertEmail(id, GetName(playerid), string);
	format(string, sizeof(string), "Offline: %s a primit mute de la %s pentru %d minute, motiv: %s", id, GetName(playerid),time,msg);
	SCMTA(COLOR_LIGHTRED, string);
	return true;
}
cmd:gmx(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	new string[100];
	format(string, sizeof(string), "AdmBot: Adminul %s a dat restart la server.", GetName(playerid));
	if(GetPVarInt(playerid, "Cover") == 0) SendAdminMessage(COLOR_LOGS, 6, string);
	GameModeExit();
	return true;
}
cmd:restart(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 6) 
		return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	
	new time;
	if(sscanf(params, "is[45]", time, params)) 
		return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/restart <timp in minute> <reason>");
	
	format(gString, 180, "(( AdmBot: Urmeaza un restart in %d minute, motiv: %s. ))", time, params);
	SCMTA(COLOR_CLIENT, gString);
	RestartTime = time*60;
	return true;
}
cmd:cancelrestart(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	new string[180];
	format(string, sizeof(string), "(( Admin %s: {FF9696}Restart-ul a fost anulat. {A9C4E4}))", GetName(playerid));
	SCMTA(COLOR_CLIENT, string);
	RestartTime = 0;
	return true;
}
cmd:sethp(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	new id,hp;
	if(sscanf(params, "ui", id, hp)) return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/sethp <playerid/name> <hp>");
	if(!IsPlayerConnected(id) || !IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
	if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, COLOR_GREY, "Nu poti executa aceasta comanda pe acel player!");
	SetPlayerHealthEx(id, hp);

	gString[0] = (EOS);
	format(gString, 128, "(/sethp): {FFFFFF}%s has set %s heal to %d.", GetName(playerid),GetName(id),hp);
	SendAdminMessage(COLOR_LIGHTRED, 2, gString);
	return true;
}
cmd:setarmor(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	new id,armor,string[100];
	if(sscanf(params, "ui", id, armor)) return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/setarmor <playerid/name> <armor>");
	if(!IsPlayerConnected(id) || !IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
	SetPlayerArmourEx(id, armor);
	
	format(string, sizeof(string), "AdmBot: Adminul %s i-a setat lui %s armura la %d.",  GetName(playerid),GetName(id),armor);
	if(GetPVarInt(playerid, "Cover") == 0) SendAdminMessage(COLOR_WHITE, 2, string);
	return true;
}

cmd:nmute(playerid, params[]) {
	new userID, time, result[180];
	if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 1) return SendClientMessage(playerid, COLOR_GREY, "Nu ai acces!");
	if(sscanf(params, "uis[180]", userID, time, result)) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/nmute <playerid/name> <time> <reason>");
	if(!IsPlayerConnected(userID) && !IsPlayerConnected(userID)) return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
	if(PlayerInfo[userID][pAdmin] > PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda asupra unui administrator!");
	if(userID == playerid) return SendClientMessage(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda asupra ta!");
	PlayerInfo[userID][pNewbieMute] = gettime()+(time*60);
	
	new string[180];
	format(string, sizeof(string), "AdmBot: %s a primit mute %d minute pe /newbie de la %s, motiv: %s", GetName(userID), time, GetName(playerid), result);
	SCMTA(COLOR_LIGHTRED, string);
	format(string, sizeof(string), "Ai primit mute pe /newbie pentru %d minute! Motiv: %s", time, result);
	SendClientMessage(userID, COLOR_WARNING, string);
	return true;
}

stock SendStaffMessage(const color, const string:str[]) {
	foreach(new i: All(Staff<>)) SendClientMessage(i,color,str);
	return true;
}
cmd:gotoi(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 4) 
		return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Nu esti autorizat.");

	SetPlayerPos(playerid, 837.8620,-2127.8665,13.1456);
	SendClientMessage(playerid, COLOR_WHITE, "Te-ai teleporat cu succes la insula.");
	return 1;
}
cmd:sethw(playerid, params[]) {
	if(!IsAdmin(playerid, 5)) 
		return SendClientMessage(playerid, COLOR_LGREEN, "Nu ai permisiunea de a folosi aceasta comanda!");

	extract params -> new player:id, amount, string:reason[32]; else
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/sethw <playerid/name> <amount/3> <reason>");

	if(!IsPlayerConnected(id)) 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat!");

	if(PlayerInfo[id][pHelper] == 0) 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este helper!");
	
	if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu poti executa aceasta comanda pe acel player!");
	
	if(amount > 3) 
		return SendClientMessage(playerid, COLOR_GREY, "Invalid amount! (0-3)");
	
	if(strlen(reason) < 5)
		return SendClientMessage(playerid, COLOR_GREY, "Motiv prea mic!");
	
	if(id == playerid) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda asupra ta!");

	PlayerInfo[id][pHW] = amount;
	PlayerInfo[id][pExpHW] = gettime() + (7 * 86400);
	UpdateVar(id, "ExpHW", PlayerInfo[id][pExpHW]);
	UpdateVar(id, "HW", amount);
	format(gString, sizeof gString, "AdmCmd: %s i-a setat lui %s %d/3 helper warns, motiv: %s.", GetName(playerid), GetName(id), amount, reason);
	SendAdminMessage(COLOR_WHITE, 1, gString);
	format(gString, sizeof gString, "Administratorul %s ti-a setat %d/3 helper warns, motiv: %s.", GetName(playerid), amount, reason);
	SendClientMessage(id, COLOR_LIGHTBLUE, gString);
	if(amount == 3) {
		PlayerInfo[id][pHelper] = 0;
		PlayerInfo[id][pHW] = 0;
		PlayerInfo[id][pExpHW] = -1;
		UpdateVar(id, "ExpHW", PlayerInfo[id][pExpHW]);
		UpdateVar(id, "HW", 0);
		UpdateVar(id, "Helper", 0);
		Iter_Remove(Staff<HELPER>, id);
		if(HaveHelp[playerid] != -1) {
			OnHelper[HaveHelp[playerid]] = 0;
			SendClientMessage(HaveHelp[playerid], COLOR_YELLOW, "Helper-ul care ti-a acceptat intrebarea nu mai poate raspunde! Asteapta pana cand iti va raspunde altcineva..");
		}
		HaveHelp[playerid] = -1;
		SendClientMessage(id, COLOR_YELLOW, "Ti-ai pierdut functia deoarece ai acumulat 3/3 warns.");
	}
	return true;
}
cmd:setlw(playerid, params[]) {
	if(!IsAdmin(playerid, 5)) 
		return SendClientMessage(playerid, COLOR_LGREEN, "Nu ai permisiunea de a folosi aceasta comanda!");

	extract params -> new player:id, amount, string:reason[32]; else
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/setlw <playerid/name> <amount/3> <reason>");

	if(!IsPlayerConnected(id))
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat!");

	if(PlayerInfo[id][pLeader] == 0) 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este lider!");

	if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu poti executa aceasta comanda pe acel player!");

	if(amount > 3) 
		return SendClientMessage(playerid, COLOR_GREY, "Invalid amount! (0-3)");

	if(strlen(reason) < 5) 
		return SendClientMessage(playerid, COLOR_GREY, "Motiv prea mic!");

	if(id == playerid) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda asupra ta!");

	PlayerInfo[id][pLW] = amount;
	PlayerInfo[id][pExpLW] = gettime() + (7 * 86400);
	UpdateVar(id, "ExpLW", PlayerInfo[id][pExpLW]);
	UpdateVar(id, "LW", amount);
	format(gString, sizeof gString, "AdmCmd: %s i-a setat lui %s %d/3 leader warns, motiv: %s.", GetName(playerid), GetName(id), amount, reason);
	SendAdminMessage(COLOR_WHITE, 1, gString);
	format(gString, sizeof gString, "Administratorul %s ti-a setat %d/3 leader warns, motiv: %s.", GetName(playerid), amount, reason);
	SendClientMessage(id, COLOR_LIGHTBLUE, gString);
	if(amount == 3) {
		Iter_Remove(faction_leaders, id);
		Iter_Remove(faction_players<PlayerInfo[id][pMember]>, id);
		PlayerInfo[id][pMember]=0;
		PlayerInfo[id][pLeader]=0;
		PlayerInfo[id][pRank] = 0;
		PlayerInfo[id][pFACWarns] = 0;
		PlayerInfo[id][pFpunish] = 0;
		PlayerInfo[id][pDays] = 0;
		PlayerInfo[id][pLW] = 0;
		UpdateVar(id, "LW", 0);	
		PlayerInfo[id][pExpLW] = -1;
		UpdateVar(id, "ExpLW", PlayerInfo[id][pExpLW]);			
		OnDuty[id] = 0;
		PlayerTextDrawHide(id, dutyTD);
		tazer[id] = 0;
		SetPlayerArmourEx(id, 0);
		SetPlayerToTeamColor(id);
		_query("UPDATE users SET `Member`='0',`Leader`='0',`Rank`='0',`FWarn`='0',`FPunish`='0',`Days`='0' WHERE `ID`='%d'",PlayerInfo[id][pSQLID]);
		SpawnPlayer(id);
		SendClientMessage(id, COLOR_YELLOW, "Ti-ai pierdut functia deoarece ai acumulat 3/3 warns.");			
	}
	return true;
}
cmd:setaw(playerid, params[]) {
	if(!IsAdmin(playerid, 6)) 
		return SendClientMessage(playerid, COLOR_LGREEN, "Nu ai permisiunea de a folosi aceasta comanda!");

	extract params -> new player:id, amount, string:reason[32]; else
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/setaw <playerid/name> <amount/3> <reason>");

	if(!IsPlayerConnected(id)) 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat!");

	if(!IsPlayerLogged(id))
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este logat!");

	if(PlayerInfo[id][pAdmin] == 0) 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este admin!");

	if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu poti executa aceasta comanda pe acel player!");

	if(amount > 3) 
		return SendClientMessage(playerid, COLOR_GREY, "Invalid amount! (0-3)");

	if(strlen(reason) < 5) 
		return SendClientMessage(playerid, COLOR_GREY, "Motiv prea mic!");

	if(id == playerid) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda asupra ta!");

	PlayerInfo[id][pAW] = amount;
	PlayerInfo[id][pExpAW] = gettime() + (7 * 86400);
	UpdateVar(id, "ExpAW", PlayerInfo[id][pExpAW]);
	UpdateVar(id, "AW", amount);
	format(gString, sizeof gString, "AdmCmd: %s i-a setat lui %s %d/3 admin warns, motiv: %s.", GetName(playerid), GetName(id), amount, reason);
	SendAdminMessage(COLOR_WHITE, 1, gString);
	format(gString, sizeof gString, "Administratorul %s ti-a setat %d/3 admin warns, motiv: %s.", GetName(playerid), amount, reason);
	SendClientMessage(id, COLOR_LIGHTBLUE, gString);
	if(amount == 3) {
		PlayerInfo[id][pAW] = 0;
		UpdateVar(id, "AW", 0);	
		PlayerInfo[id][pExpAW] = -1;
		UpdateVar(id, "ExpAW", PlayerInfo[id][pExpAW]);
		PlayerInfo[id][pAdmin] = 0;
		UpdateVar(id, "Admin", 0);
		Iter_Remove(Staff<ADMIN>, id);
		SendClientMessage(id, COLOR_YELLOW, "Ti-ai pierdut functia deoarece ai acumulat 3/3 warns.");
	}
	return true;
}
cmd:hh(playerid, params[]) {
	if(PlayerInfo[playerid][pHelper] == 0) return true;
	new szDialog[500];
	if(PlayerInfo[playerid][pHelper] >= 1) {
		strcat(szDialog, "{5F9CC9}Helper 1:{FFFFFF}\n");
		strcat(szDialog, "/nnext, /slap, /cc, /hduty, /nre, /nskip, /ndelete, /checkhelp, /pm, /deletead, /nreport, /helps.\n");
	}
	if(PlayerInfo[playerid][pHelper] >= 2) {
		strcat(szDialog, "{5F9CC9}Helper 2:{FFFFFF}\n");
		strcat(szDialog, "/skick /kick /freeze /unfreeze /spec /specoff /mute");
	}
    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{FFFFFF}Comenzi:", szDialog, "Close", "");
	return true;
}
cmd:closereport(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu ai acces!");

	new userID;
	if(sscanf(params, "us[180]", userID, params)) 
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/closereport <playerid/name> <reason>");
	
	if(!IsPlayerConnected(userID)) 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat!");
	
	if(!Iter_Contains(report_players, userID)) 
		return SendClientMessage(playerid, COLOR_WHITE, "Acel player nu a dat report.");

	if(report_type[userID]==2) return true;

	format(gString, 180, "* Admin %s: %s", GetName(playerid), params);
	SendClientMessage(userID, COLOR_LIGHTGOLD, gString);
	format(gString, 180, "(/cr) %s a inchis report-ul lui %s, motiv: %s.", GetName(playerid), GetName(userID), params);
	SendAdminMessage(0xFFADADFF, 1, gString);
	
	
	updateRaport(playerid, value_report[userID]);

	Iter_Remove(report_players, userID);
	show_admin_report();
	report_type[userID] = 
	value_report[userID] = 0; 
	HelpText[userID][0] = (EOS);	
	return true;
}
cmd:rmute(playerid, params[]) {
	new userID, time;
	if(PlayerInfo[playerid][pAdmin] < 1) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu ai acces!");

	if(sscanf(params, "uis[180]", userID, time, params)) 
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/rmute <playerid/name> <time> <reason>");
	
	if(!IsPlayerConnected(userID)) 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat!");
	
	if(PlayerInfo[userID][pAdmin] > PlayerInfo[playerid][pAdmin]) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda asupra unui administrator!");
	
	if(userID == playerid) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda asupra ta!");

	PlayerInfo[userID][pReportTime] = gettime()+(time*60);
	UpdateVar(userID, "ReportTime", PlayerInfo[userID][pReportTime]);

	format(gString, 180, "Ai primit mute pe /report pentru %d minute! Motiv: %s", time, params);
	SendClientMessage(userID, -1, gString);
	format(gString, 180, "AdmBot: %s a primit mute %d minute pe /report de la %s, motiv: %s", GetName(userID), time, GetName(playerid), params);
	SCMTA(COLOR_LIGHTRED, gString);
	return true;
}

stock get_report_time(userID) {
	gQuery[0] = (EOS);
	if(gettime()-report_ago[userID]<60) format(gQuery, 60, "[%d sec ago]", gettime()-report_ago[userID]);
	else format(gQuery, 60, "[%d min and %d sec ago]", (gettime() - report_ago[userID]) / 60, (gettime() - report_ago[userID]) % 60);
	return gQuery;
}

stock show_admin_report() {
	if(Iter_Count(report_players)) {
		new _r,_c;
		foreach(new i : report_players) if report_type[i]!=2 *then _r++; else _c++;
		format(gQuery, 60, "R: ~r~%d ~w~~h~C: ~r~%d", _r, _c);
		TextDrawSetString(ReportTD, gString);
		if(Iter_Count(report_players)==1) foreach(new i : Staff<ADMIN>) TextDrawShowForPlayer(i, ReportTD);
	} else {
		foreach(new i : Staff<ADMIN>) TextDrawHideForPlayer(i, ReportTD);
	}
	return true;
}

cmd:reports(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) 
		return true;

	SendClientMessage(playerid, COLOR_WHITE, "--------- Reports --------");

	new cheat=0;
	foreach(new i : report_players) {
		switch(report_type[i]) {
			case 1: {
				format(gString, 180, "DM: %s (%d) reported by %s. Score: %d", GetName(i), i, value_report[i]);
				MesajLung(playerid, COLOR_DBLUE, gString);
			}
			case 2: cheat++;
			case 3: {
				format(gString, 180, "Stuck: %s (%d) %s", GetName(i), i, get_report_time(i));
				MesajLung(playerid, COLOR_WARNING, gString);
			}
			case 4: {
				format(gString, 180, "Another: %s (%d): %s %s", GetName(i), i, HelpText[i], get_report_time(i));
				MesajLung(playerid, COLOR_LGREEN, gString);
			}
			case 5: {
				format(gString, 180, "Custom: %s (%d): %s %s", GetName(i), i, HelpText[i], get_report_time(i));
				MesajLung(playerid, COLOR_LGREEN, gString);
			}
		}
	}
	SCMf(playerid, COLOR_LGREEN, "(/cheaters): %d found.", cheat);
	return true;
}

cmd:cheaters(playerid, params[]) {
	if(!IsAdmin(playerid, 1))
		return true;

	new x=0;
	SendClientMessage(playerid, COLOR_WHITE, "--------- Cheaters --------");
	foreach(new i : report_players) {
		if(report_type[i]!=2) continue;
		format(gString, 180, "Cheats: %s (%d) reported by %s. %s", GetName(i), i, HelpText[i], report_by[i], get_report_time(i));
		MesajLung(playerid, COLOR_LGREEN, gString);
		x++;
	}
	SCMf(playerid, COLOR_LGREEN, ">> %d cheaters <<", x);
	return true;
}

cmd:cheats(playerid, params[]) {
	if(IsAdmin(playerid, 1)) 
		return true;

	new userID;
	if(sscanf(params, "is[128]", userID, params))
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/cheats <playerid/name> <reason>");

	if(!IsPlayerConnected(userID))
		return SendClientMessage(playerid, COLOR_GREY, "Player not connected.");

	if(!IsPlayerLogged(userID))
		return SendClientMessage(playerid, COLOR_GREY, "Player not logged.");

	if(PlayerInfo[userID][pAdmin] || PlayerInfo[userID][pHelper])
		return SendClientMessage(playerid, COLOR_GREY, "Nu poti raporta un admin!");

	Iter_Add(report_players, userID);
	show_admin_report();
	report_type[userID] = 2;
	value_report[userID] ++;
	strmid(report_by[userID], PlayerInfo[playerid][pUsername], 0, MAX_PLAYER_NAME);
	strmid(HelpText[userID], params, 0, 128);
	SendClientMessage(playerid, COLOR_YELLOW, "Report trimis!");
	return true;
}

cmd:dm(playerid, params[]) {
	if(!IsAdmin(playerid, 1)) {
		extract params -> new player:id; else
			return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/dm <playerid/name>");

		if !IsPlayerConnected(id) *then 
			return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");

		if !IsPlayerLogged(id) *then
			return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este logat!");

		if(playerid == id)
			return SendClientMessage(playerid, COLOR_GREY, "Nu iti poti da singur report");

		format(gString, 180, "%s (%d) l-a raportat pe %s (%d) pentru DM.", GetName(playerid), playerid, GetName(id), id);
		SendAdminMessage(0xC9161FFF, 1, gString);
		report_type[id] = 1;
		value_report[id] ++;
		report_ago[id] = gettime();
		strmid(report_by[id], PlayerInfo[playerid][pUsername], 0, MAX_PLAYER_NAME);
		Iter_Add(report_players, id);
		show_admin_report();
		SendClientMessage(playerid, COLOR_YELLOW, "Report trimis!");
		return true;
	}

	extract params -> new player:id; else
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/dm <playerid/name>");

	if !IsPlayerConnected(id) *then 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");

	if !IsPlayerLogged(id) *then
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este logat!");

	if id == playerid && PlayerInfo[playerid][pAdmin] < 7 *then 
		return SendClientMessage(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda asupra ta!");

	if PlayerInfo[id][pJailTime] *then 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player este deja in jail!");
	
	_query("UPDATE `users` SET `WantedLevel` = '0', `AJail` = '1', `Jails` = `Jails`+'1', `GunLic`='0', `GunLicT`='-1', `GunLicS`='3', `A_DM`=`A_DM`+'1 WHERE `id`='%i'", PlayerInfo[id][pSQLID]);
	ResetWeapons(id),SetPlayerWantedLevel(id, 6);

	InsereazaSanctiune(id, playerid, JAIL, "DM");	
	updateRaport(playerid);

	PlayerInfo[id][pWantedLevel] = 0;
	PlayerTextDrawHide(id, WantedTD);
	Iter_Remove(servicePlayers<8>, id);
	PlayerInfo[id][pJailed] = 2;
	PlayerInfo[id][pDM]++;
	PlayerInfo[id][pJailTime] = PlayerInfo[id][pDM] * 15 * 60;
	PlayerInfo[id][pAJail] = 1;
	PlayerInfo[id][pGunLicS] = 3;
	PlayerInfo[id][pGunLic] = 0;
	PlayerInfo[id][pGunLicT] = -1;

	UpdateVar(id, "DM", PlayerInfo[id][pDM]);
	format(gString, 128, "AdmBot: %s a fost bagat in inchisoare de %s pentru %d minute, motiv: DM #%d", GetName(id), GetName(playerid), PlayerInfo[id][pDM] * 15, PlayerInfo[id][pDM]);
	MesajLung2(COLOR_LIGHTRED, gString);			
	SendClientMessage(id, COLOR_WARNING, "Licenta ta de arme a fost confiscata timp de 3 ore deoarece ai primit jail pentru DM!");
	SpawnPlayer(id);
	return true;
}
cmd:report(playerid, params[]) {
	if(PlayerInfo[playerid][pReportTime] > gettime()) 
		return SCMf(playerid, COLOR_GRAD4, "Vei putea da un report peste %d minute (%d secunde).", (PlayerInfo[playerid][pReportTime]-gettime())/60, PlayerInfo[playerid][pReportTime]-gettime());
	
	if(PlayerInfo[playerid][pAdmin] >= 1 && GetPVarInt(playerid, "Cover") == 0) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu poti da un report deoarece esti admin!");
	
	if(PlayerInfo[playerid][pLevel] < 5) SendClientMessage(playerid, COLOR_LGREEN, "Nu da report pentru motive inutile deoarece vei fi sanctionat!");
	ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_LIST, "Report", "Raporteaza DM\nRaporteaza un codat\nIntrebari despre donatii\nSunt blocat\nAlta problema", "Select", "Close");
	return true;
}
		
redist::CheckReport(playerid) {
	if(!Iter_Contains(report_players, playerid))
		return true;

	SendClientMessage(playerid, COLOR_YELLOW, "Report-ul tau a fost inchis automat deoarece nu ai primit un raspuns.");
	Iter_Remove(report_players, playerid);
	show_admin_report();
	report_type[playerid] = 0;
	HelpText[playerid][0] = (EOS);
	value_report[playerid] = 0;	
	ReportTimer[playerid] = 0;
	return true;
}
cmd:helps(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 1) 
		return true;
	
	new userID, x;
	SendClientMessage(playerid, COLOR_LGREEN, ">> helps <<");
	foreach(new i : Staff<HELPER>) {
		if((userID=HaveHelp[i])==-1||!HelperDuty[i]) continue;
		SCMf(playerid, COLOR_LGREEN, "* %s (%d) to %s: %s", GetName(userID), userID, GetName(i), HelpText[userID]);
		x++;
	}
	foreach(new i : newbie_players) SCMf(playerid, COLOR_LGREEN, "* %s (%d) to Server: %s", GetName(i), i, HelpText[i]), x++;
	SCMf(playerid, COLOR_LGREEN, ">> Questions found: %d <<", x);
	return true;
}

cmd:newbie(playerid, params[]) {
	if(Iter_Contains(newbie_players, playerid)) 
		return SendClientMessage(playerid, -1, "Ai pus recent o intrebare. Asteapta un raspuns!");
	
	if(!NewbieChat[playerid])
		return SendClientMessage(playerid, COLOR_GREY, "Pentru a pune o intrebare activeaza chat-ul newbie (/togn)!");

	if(sscanf(params, "s[128]", params)) 
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/newbie <text>");

	if(PlayerInfo[playerid][pNewbieMute] > gettime()) 
		return SCMf(playerid, COLOR_LGREEN, "* Ai pus deja o intrebare recenta, mai poti pune o intrebare in %d secunde!", PlayerInfo[playerid][pNewbieMute]-gettime());

	if(PlayerInfo[playerid][pHelper] >= 1 || PlayerInfo[playerid][pAdmin] >= 1) 
		return SendClientMessage(playerid, COLOR_WHITE, "Faci parte din staff, nu poti folosi aceasta comanda!");
	
	SCMf(playerid, COLOR_LGREEN, "* Newbie %s: %s", GetName(playerid), params);
	strmid(HelpText[playerid], params, 0, 128);
	PlayerInfo[playerid][pNewbieMute] = gettime()+120;
	Iter_Add(newbie_players, playerid);
	checkBP(playerid, 17, 700);
	return true;
}
cmd:hduty(playerid, params[]) {
	if(PlayerInfo[playerid][pHelper] == 0) return SendClientMessage(playerid, COLOR_LGREEN, "* Nu ai acces la aceasta comanda!");
	switch(HelperDuty[playerid]) {
	    case 0: HelperDuty[playerid] = 1, SendClientMessage(playerid, -1, "Incepand de acum, vei primi intrebari.");
	    case 1: {
			if(HaveHelp[playerid] != -1) return SendClientMessage(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda atata timp cat ai o intrebare activa.");
			HelperDuty[playerid] = 0, SendClientMessage(playerid, -1, "Incepand de acum, nu mai vei primi intrebari.");
		}
	}
	return true;
}

cmd:nnext(playerid, params[]) {
	if(!PlayerInfo[playerid][pHelper])
		return true;

	if(HelperDuty[playerid] == 0) 
    	return SendClientMessage(playerid, COLOR_GREY, "Nu esti la datorie ca helper.");

    if(DeelayCommand[playerid][27]>gettime())
    	return true;
	
    if(!Iter_Count(newbie_players))
    	return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Nu sunt intrebari momentan!");

	if(HaveHelp[playerid] != -1) 
		return SendClientMessage(playerid, COLOR_GREY, "Ai primit deja o intrebare!");

	new userID=Iter_Random(newbie_players); Iter_Remove(newbie_players, userID);
	HaveHelper[HaveHelp[playerid]=userID]=playerid;
	PlayerPlaySound(userID, 1056, 0.0, 0.0, 0.0);
	SendClientMessage(playerid, COLOR_NEWS, "New question:");
	SCMf(playerid, COLOR_YELLOW, "* %s: %s", GetName(userID), HelpText[userID]);
	DeelayCommand[playerid][27] = gettime()+20;
	return true;
}

cmd:nreport(playerid, params[]) {
	if(PlayerInfo[playerid][pHelper] == 0) 
		return SendClientMessage(playerid, COLOR_GREY, "* Nu ai acces la aceasta comanda!");

    if(HelperDuty[playerid] == 0) 
    	return SendClientMessage(playerid, COLOR_GREY, "Nu esti la datorie ca helper.");
	
	if(HaveHelp[playerid] == -1) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu ai primit o intrebare.");

	new userID = HaveHelp[playerid];
	format(gString, 128, "(/nreport) %s a trimis intrebarea lui %s (%d) adminilor.", GetName(playerid), GetName(userID), userID);
	SendStaffMessage(0x4FB021FF, gString);

	SendClientMessage(userID, COLOR_GOLD, "Intrebarea ta a fost trimisa adminilor!");
	format(gString, 128, "Report de la %s (%d): %s.", GetName(userID), userID, HelpText[userID]);
	SendAdminMessage(0xC9161FFF, 1, gString);
	ReportTimer[userID] = 300;

	Iter_Add(report_players, HaveHelp[playerid]); Iter_Remove(newbie_players, userID);
	show_admin_report();
	report_type[userID] = 4;

	PlayerInfo[userID][pReportTime] = gettime()+120;
	HaveHelp[playerid] = -1;
	return true;
}
cmd:nskip(playerid, params[]) {
    if(PlayerInfo[playerid][pHelper] == 0) 
    	return SendClientMessage(playerid, COLOR_GREY, "* Nu ai acces la aceasta comanda!");
    
    if(HelperDuty[playerid] == 0) 
    	return SendClientMessage(playerid, COLOR_GREY, "Nu esti la datorie ca helper.");
	
	if(HaveHelp[playerid] == -1) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu ai primit o intrebare.");

	if(Iter_Count(Staff<HELPER>)==1)
		return SendClientMessage(playerid, -1, "Doar tu esti la datorie.");

    new userID = HaveHelp[playerid];
    PlayerPlaySound(userID, 1056, 0.0, 0.0, 0.0);
	format(gString, 128, "(/nskip) %s a sarit peste intrebarea lui %s.", GetName(playerid), GetName(userID));
	SendAdminMessage(0xFFADADFF, 1, gString);

	SendClientMessage(userID, COLOR_LGREEN, "Helperul anterior a sarit peste intrebarea ta. Asteapta pana cand cineva iti va raspunde!");
	Iter_Add(newbie_players, userID);
	HaveHelp[playerid] = HaveHelper[userID] = -1;
	SendClientMessage(playerid, COLOR_YELLOW, "Ai sarit peste aceasta intrebare.");
	return true;
}
	
cmd:rnewbie(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) 
		return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Nu ai acces la aceasta comanda!");
	
	new id;
	if(sscanf(params, "u", id)) 
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/rnewbie <playerid/name>");
	
	if(!IsPlayerConnected(id)) 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat!");
	
	if(PlayerInfo[id][pHelper] != 0) 
		return SendClientMessage(playerid, COLOR_WHITE, "Acel player este helper!");

	if(!Iter_Contains(report_players, id)) 
		return SendClientMessage(playerid, COLOR_WHITE, "Acel player nu a dat report.");
	
	if(report_type[id] != 4) 
		return SendClientMessage(playerid, COLOR_WHITE, "Nu poti muta acest report.");
	
	format(gString, 180, "AdmCmd: %s a trimis report-ul lui %s (%d) helperilor.", GetName(playerid), GetName(id), id);
	SendStaffMessage(COLOR_WHITE, gString);
	SendClientMessage(id, COLOR_YELLOW, "Report-ul tau a fost trimis helperilor! Asteapta un raspuns..");
	PlayerInfo[id][pNewbieMute] = gettime()+120;
	report_type[id] = 0;
	value_report[id] = 0;	
	Iter_Remove(report_players, id); Iter_Add(newbie_players, id);		
	show_admin_report();
	return true;
}
cmd:nre(playerid, params[]) {
	if(PlayerInfo[playerid][pHelper] == 0) 
		return SendClientMessage(playerid, COLOR_GREY, "* Nu ai acces la aceasta comanda!");

    if(HelperDuty[playerid] == 0) 
    	return SendClientMessage(playerid, COLOR_GREY, "Nu esti la datorie ca helper.");

	if(HaveHelp[playerid] == -1) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu ai primit o intrebare.");

	if(sscanf(params, "s[250]", params)) 
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/nr <text>");

	new userID = HaveHelp[playerid];
	format(gString, 180, "* Newbie %s: %s", GetName(userID), HelpText[userID]);
	SendNewbieMessage(COLOR_LGREEN, gString);	
	format(gString, 256, "* Helper %s: %s", GetName(playerid), params);
	MesajLung(userID, COLOR_YELLOW, gString);
	Iter_Remove(Player, userID);
	SendNewbieMessage(COLOR_LGREEN, gString);
	Iter_Add(Player, userID);	
	HaveHelp[playerid] = -1;
	updateRaport(playerid);
	return true;
}

updateRaport(playerid, add=1) {

	PlayerInfo[playerid][pHelpedPlayers] += add; PlayerInfo[playerid][pHelpedPlayersToday] += add;
	if(PlayerInfo[playerid][pHelpedPlayers]%10 == 0 && PlayerInfo[playerid][pHelpedPlayers]!=0) {
		SCMf(playerid, COLOR_YELLOW, "Ai primit 1 punct premium deoarece ai acumulat 10 intrebari rezolvate (total: %d)!", PlayerInfo[playerid][pHelpedPlayers]);
		PlayerInfo[playerid][pPremiumPoints] ++;
		UpdateVar(playerid, "GoldPoints", PlayerInfo[playerid][pPremiumPoints]);
	}
	mysql_format(SQL, gQuery, 144, "UPDATE `users` SET `HelpedPlayers` = '%i', `HelpedPlayersToday`='%i' WHERE `id` = '%i'", 
		PlayerInfo[playerid][pHelpedPlayers], 
		PlayerInfo[playerid][pHelpedPlayersToday], 
		PlayerInfo[playerid][pSQLID]
	);
	mysql_tquery(SQL, gQuery);
	return true;
}

cmd:checkhelp(playerid, params[]) {
    if(PlayerInfo[playerid][pHelper] == 0) 
    	return SendClientMessage(playerid, COLOR_GREY, "* Nu ai acces la aceasta comanda!");
   
    if(HelperDuty[playerid] == 0) 
    	return SendClientMessage(playerid, COLOR_GREY, "Nu esti la datorie ca helper.");
	
	if(HaveHelp[playerid] == -1) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu ai primit o intrebare.");
	
	new userID = HaveHelp[playerid];
	SCMf(playerid, COLOR_LGREEN, "* Newbie %s: %s", GetName(userID), HelpText[userID]);
	return true;
}
cmd:ndelete(playerid, params[]) {
    if(PlayerInfo[playerid][pHelper] == 0) 
    	return SendClientMessage(playerid, COLOR_GREY, "* Nu ai acces la aceasta comanda!");

    if(HelperDuty[playerid] == 0) 
    	return SendClientMessage(playerid, COLOR_GREY, "Nu esti la datorie ca helper.");

	if(HaveHelp[playerid] == -1) 
		return SendClientMessage(playerid, COLOR_GREY, "Nu ai primit o intrebare.");

	if(sscanf(params, "s[64]", params)) 
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/ndelete <reason>");

	new userID = HaveHelp[playerid];
	SCMf(userID, COLOR_LIGHTGOLD, "(/n) Intrebarea ta a fost stearsa de %s, motiv: %s", GetName(playerid), params);
	format(gString, 180, "(/nd) intrebarea lui %s a fost stearsa de %s, motiv: %s.", GetName(HaveHelp[playerid]), GetName(playerid), params);
	SendStaffMessage(0xFFADADFF, gString);
	format(gString, 180, "(/nd) %s > %s: %s", GetName(HaveHelp[playerid]), GetName(playerid), HelpText[HaveHelp[playerid]]);
	SendStaffMessage(0xFFADADFF, gString);
	HaveHelp[playerid] = -1;
	updateRaport(playerid);
	return true;
}

cmd:crateforall(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 6)
		return SendClientMessage(playerid, COLOR_LGREEN, AdminOnly);

	new type, value;
	if(sscanf(params, "ii", type, value)) {
        SendClientMessage(playerid, COLOR_WHITE, "Rare (0) | Epic (1) | Legendary (2) | Mythic (3) | Transcendent (4) | Vehicle (5) | Emotes (6) | Frozen (7) | Premium (8) | LIMITED EDITION(9)");
		SendClientMessage(playerid, COLOR_WHITE, "PREMIUM V2(10) ");
		return true;
	}

	if(type<0||type>10) return SendClientMessage(playerid, COLOR_GREY, "Invalid crates.");

	foreach(new i : Player) PlayerInfo[i][pCrates][type] += value, save_crates(i);

	gString[0] = EOS;
	format(gString, 75, "Admin %s a dat %d crate %s.", GetName(playerid), value, CrateName[type]);
	SCMTA(COLOR_YELLOW, gString);
	return true;
}

cmd:aduty(playerid, params[]) {
	new string[120];
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, -1, AdminOnly);
	if(Aduty[playerid] == 0) {
		Aduty[playerid] = 1;
		format(string, sizeof(string), "[INFO]: {FFFFFF}Admin %s is now on administrative duty", GetName(playerid));
	    SendAdminMessage(COLOR_LIGHTRED, 1, string);
		SetPlayerArmourEx(playerid, 1000);
		SetPlayerHealthEx(playerid, 1000);
	}	
	else if(Aduty[playerid] == 1) {
		Aduty[playerid] = 0;
		format(string, sizeof(string), "[INFO]: {FFFFFF}Admin %s is now off administrative duty", GetName(playerid));
	    SendAdminMessage(COLOR_LIGHTRED, 1, string);

		SetPlayerArmourEx(playerid, 0);
		SetPlayerHealthEx(playerid, 100);
	}
	return true;	
}

cmd:alock(playerid, params[]) {
	new 
		vehicle = GetPlayerVehicleID(playerid),
		engine,lights,alarm,doors,bonnet,boot,objective
	;
	gString[0] = (EOS);

	
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_RED, "Nu esti admin");
	if(sscanf(params, "i", vehicle)) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/alock <vehicleid>");

	GetVehicleParamsEx(vehicle,engine,lights,alarm,doors,bonnet,boot,objective);
	SetVehicleParamsEx(vehicle,engine,lights,alarm,doors!=VEHICLE_PARAMS_OFF?VEHICLE_PARAMS_OFF:VEHICLE_PARAMS_ON,bonnet,boot,objective);
	format(gString, 84, "~w~%s~n~%s",aVehicleNames[GetVehicleModel(vehicle)-400], doors!=VEHICLE_PARAMS_OFF?("~g~deschis"):("~r~inchis"));
	GameTextForPlayer(playerid, gString, 3000, 4);
	return true;
}

cmd:respawnthiscar(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return true;
	new vehicleid;
	if(!IsPlayerInAnyVehicle(playerid)) {
		if(sscanf(params, "i", vehicleid)) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/vre <vehicleid>");
	} else vehicleid = GetPlayerVehicleID(playerid);
   	SetVehicleToRespawn(vehicleid);
	gString[0] = (EOS);
	if(Carspawn[vehicleid]) {
		DestroyVehicleEx(vehicleid, "respawnthiscar");
		Carspawn[vehicleid] = false;
	}
	return true;
}

cmd:nearplayers(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return true;
	new range, Float:rPos[4], x, string[180];
	if(sscanf(params, "ii", range)) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/nearplayers <range>");
    GetPlayerPos(playerid, rPos[0], rPos[1], rPos[2]);
	foreach(new i : Player) {
		if(IsPlayerInRangeOfPoint(i, range, rPos[0], rPos[1], rPos[2])) x ++;
	}
	format(string, sizeof(string), "Au fost gasiti %d jucatori in raza de %dm.", x, range);
	SendClientMessage(playerid, COLOR_LGREEN, string);
	return true;
}
cmd:nearskin(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 3) return true;
	
	new total,skin,range;
	if(sscanf(params, "ii", skin,range))
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/nearskin <skin> <range>");

	new Float:x,Float:y,Float:z;
    GetPlayerPos(playerid, x,y,z);
	foreach(new i : Player) {
		if(!IsPlayerInRangeOfPoint(i, range, x,y,z))
			continue;

		SetPlayerSkin(i, skin);
		++total;
	}
	format(gString, 128, "Admin %s a dat skinul %d la %d jucatori pe o raza de %dm.", GetName(playerid), skin, total, range);
	SendAdminMessage(0xFFADADFF, 1, gString);
	return true;
}
cmd:neargun(playerid, params[]) {
	new range, gun, ammo, Float:rPos[4], x, string[180];
	if(PlayerInfo[playerid][pAdmin] < 3) return true;
	if(sscanf(params, "iii", gun, ammo, range)) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/neargun <gun> <ammo> <range>");
    GetPlayerPos(playerid, rPos[0], rPos[1], rPos[2]);
	foreach(new i : Player) {
		if(IsPlayerInRangeOfPoint(i, range, rPos[0], rPos[1], rPos[2])) {
			ServerWeapon(i, gun, ammo);
			x++;
		}
	}
	new wname[32];
	GetWeaponName(gun, wname, 32);
	format(string, sizeof(string), "(/areagun) {FFFFFF}%s a dat arma %s la %d playeri pe o raza de %dm.", GetName(playerid), wname, x, range);
	SendAdminMessage(COLOR_DARKNICERED, 1, string);
	return true;
}
cmd:setrankname(playerid, params[]) {
	new string[180], name[180], fid, rank;
	if(PlayerInfo[playerid][pAdmin] < 5) return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Nu ai acces la aceasta comanda!");
	if(sscanf(params, "iis[180]", fid, rank, name)) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/setrankname <faction> <rank (1-7)> <name>");
	if(rank < 1 || rank > 7) return SendClientMessage(playerid, -1, "Rank invalid! (1-7)");
	if(fid < 1 || fid > MAX_FACTIONS) return SCMf(playerid, COLOR_GREY, "Invalid faction! (1-%d)", MAX_FACTIONS);
	format(fRankNames[fid][rank-1], 256, name); 
	format(string, sizeof(string), "* Ai setat numele la rankul %d pentru factiunea %s in %s.", rank, FactionName(fid), name);
	SendClientMessage(playerid, COLOR_LGREEN, string);
	SaveRankNames(fid);
	return true;
}	
redist::SaveRankNames(fid) {
	new query[2048];
	mysql_format(SQL, query, sizeof(query), "UPDATE `factions` SET `Name1`='%s', `Name2`='%s', `Name3`='%s', `Name4`='%s', `Name5`='%s', `Name6`='%s', `Name7`='%s' WHERE `ID`='%d'",
	fRankNames[fid][0], fRankNames[fid][1], fRankNames[fid][2], fRankNames[fid][3], fRankNames[fid][4], fRankNames[fid][5],
	fRankNames[fid][6], fid);
	mysql_tquery(SQL, query, "", "");
	return true;
}	
stock GetRankName(playerid) {
	new name[180];
	format(name, 256, fRankNames[PlayerInfo[playerid][pMember]][PlayerInfo[playerid][pRank]-1]);
	return name;
}
new Countnr;
cmd:count(playerid, params[]) {
	if(sscanf(params, "i", Countnr))
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/count <nr>");

	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
	if(Countnr < 2 && Countnr >= 360) return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Numar invalid. (1-360)");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x, y, z);
	++Countnr;
	foreach(new p: Player) {
		if(!IsPlayerInRangeOfPoint(p, 150.0, x, y, z)) continue;

		TextDrawShowForPlayer(p,CountTD);
	}
	Count();
	return true;
}
redist::Count() {
	switch(--Countnr) {
		case 0: TextDrawSetString(CountTD, "~r~GO! ~y~GO! ~b~GO!");
		case -1: {
			foreach(new p: Player) TextDrawHideForPlayer(p, CountTD);
			return true;
		}
		default: {
			format(gString,sizeof gString, "~w~Countdown: ~y~%d", Countnr);
			TextDrawSetString(CountTD, gString);
		}
	}
	SetTimer("Count", 1000, false);	
	return true;
}

cmd:fnc(playerid,params[]) return callcmd::forcenamechange(playerid,params);

CMD:forcenamechange(playerid, params[]) {
	if(!IsAdmin(playerid, 3)) 
		return SendClientMessage(playerid, -1, AdminOnly);

	new id;
	if(sscanf(params, "u", id)) 
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/forcenamechange <username/playerid>");
	
	if(!IsPlayerConnected(id)) 
		return SendClientMessage(playerid, -1, "Invalid id.");

	if(!IsPlayerLogged(id))
		return SendClientMessage(playerid, -1, "Acel player nu este logat!");

	format(gString, sizeof gString, "%s used command /fnc on %s.", GetName(playerid), GetName(id));
	SendAdminMessage(0xFFADADFF, 1, gString);
	forcenamechange[id] = true;
	SCMf(id, COLOR_YELLOW, "Admin %s forces you to change your name.", GetName(playerid));
	ShowPlayerDialog(id, DIALOG_CHANGENAME, DIALOG_STYLE_INPUT, "Force change name:", "Please enter your desired name below:", "Ok", "Cancel");	
	return true; 
}

cmd:area(playerid, params[]) {
	new range, Float:rPos[4], string[180], item[50], players = 0;
	if(PlayerInfo[playerid][pAdmin] < 1) return true;
	if(sscanf(params, "s[50]i", item, range)) {
		SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/area <name> <range>");
		SendClientMessage(playerid, COLOR_WHITE, "freeze, unfreeze, disarm, respawn, despawn (personal cars).");
  		SendClientMessage(playerid, COLOR_WHITE, "heal, armor, repair.");
		return true;
	}
	gString[0] = EOS;
	GetPlayerPos(playerid, rPos[0], rPos[1], rPos[2]);
	switch(YHash(item)) {
		case _H<freeze>: {
			foreach(new i : Player) {
		 		if(IsPlayerInRangeOfPoint(i, range, rPos[0], rPos[1], rPos[2]) && i != playerid && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid)) {
			  		TogglePlayerControllable(i, 0);
			  		Freezed[i] = 1;
					players++;
					PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
					SCMf(i, COLOR_YELLOW, "* %s ti-a dat freeze.", GetName(playerid));
				}
			}
		}
		case _H<unfreeze>: {
			foreach(new i : Player) {
		 		if(IsPlayerInRangeOfPoint(i, range, rPos[0], rPos[1], rPos[2]) && i != playerid && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid)) {
		 		    Freezed[playerid] = 0;
				  	TogglePlayerControllable(i, 1);
					players++;
					PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
					SCMf(i, COLOR_YELLOW, "* %s ti-a dat unfreeze.", GetName(playerid));
				}
			}
		}
		case _H<heal>: {
			foreach(new i : Player) {
		 		if(IsPlayerInRangeOfPoint(i, range, rPos[0], rPos[1], rPos[2]) && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid)) {
					SetPlayerHealthEx(i, 99);
					players++;
					PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
					SCMf(i, COLOR_YELLOW, "* %s ti-a dat viata.", GetName(playerid));
				}
			}
		}
		case _H<armour>: {
			foreach(new i : Player) {
		 		if(IsPlayerInRangeOfPoint(i, range, rPos[0], rPos[1], rPos[2]) && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid)) {
					SetPlayerArmourEx(i, 99);
					players++;
					PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
					SCMf(i, COLOR_YELLOW, "* %s ti-a dat armura.", GetName(playerid));
				}
			}
		}
		case _H<repair>: {
			foreach(new i : Player) {
				if(IsPlayerInRangeOfPoint(i, range, rPos[0], rPos[1], rPos[2]) && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid)) {
					if(IsPlayerInVehicle(i, GetPlayerVehicleID(i))) {
						RepairVehicle(GetPlayerVehicleID(i));
						SetVehicleHealth(GetPlayerVehicleID(i), 999.0);
						SendClientMessage(i, COLOR_YELLOW, string);
						players++;
						PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
						SCMf(i, COLOR_YELLOW, "* %s ti-a reparat masina.", GetName(playerid));
					}
				}
			}
		}
		case _H<disarm>: {
	 		foreach(new i : Player) {
		 		if(IsPlayerInRangeOfPoint(i, range, rPos[0], rPos[1], rPos[2]) && i != playerid && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid)) {
		 			ResetWeapons(i);
					SCMf(i, COLOR_YELLOW, "* %s ti-a confiscat armele.", GetName(playerid));
					players++;
					PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
				}
			}
		}
		case _H<respawn>: {
	 		foreach(new i : Player) {
		 		if(IsPlayerInRangeOfPoint(i, range, rPos[0], rPos[1], rPos[2]) && i != playerid && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid)) {
		 			SpawnPlayer(i);
					SCMf(i, COLOR_YELLOW, "* %s te-a respawnat.", GetName(playerid));
					players++;
					PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
				}
			}
		}	
		case _H<despawn>: {
			foreach(new idd : All(MyVehicle<>)) {
				if(CarInfo[idd][Spawned] == 0 || IsVehicleOccupied(CarInfo[idd][Spawned]))
					continue;

				GetVehiclePos(CarInfo[idd][Spawned], rPos[0], rPos[1], rPos[2]);
				if(!PlayerToPoint(range, playerid, rPos[0], rPos[1], rPos[2]))
					continue;

				players ++;

				DestroyPlayerCar(idd);
			}
			format(gString, 150, "{E562A9}(/area){FFFFFF} %s a despawnat %d vehicule personale pe o raza de %dm.", GetName(playerid), players, range);
			SendAdminMessage(COLOR_WHITE, 1, gString);
			return true;
		}	
		default: return SendClientMessage(playerid, COLOR_WHITE, "freeze, unfreeze, heal, armor, fixveh, disarm, respawn, respawncar, despawn (personal car).");
	}
	format(gString, 150, "{E562A9}(/area) {FFFFFF}%s a dat %s pe %d playeri.", GetName(playerid), item, players);
    SendAdminMessage(COLOR_WHITE, 1, gString);
	return true;
}
cmd:va(playerid, params[]) {
	if(!IsAdmin(playerid, 3))
		return true;

	new range;
	if(sscanf(params, "i", range))
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/va <range>");

	if(range > 100)
		return SendClientMessage(playerid, COLOR_GREY, "range maxim 100.");

	SCMf(playerid, COLOR_YELLOW, "Ai respawnat %d masini pe raza de %dm.", RespawnCarRange(playerid, range), range);
	return true;
}
stock RespawnCarRange(playerid, Float:range, idd=-1,Float:x=0.0,Float:y=0.0,Float:z=0.0) {
	new total=0;
	GetPlayerPos(playerid, x, y, z);
	for(new i=0;i<GetVehiclePoolSize(); ++i) {
		if GetVehicleDistanceFromPoint(i, x, y, z) > range || IsVehicleOccupied(i) *then continue;

		if((idd=FindSpawnID(i))!=-1) {if(CarInfo[idd][cClan]) DestroyClanVehicle(idd); else DestroyPlayerCar(idd);}
		else SetVehicleToRespawn(i);
		++total;
	}
	return total;
}
cmd:cspec(playerid, params[]) {
	new cid, string[180];
	if(PlayerInfo[playerid][pAdmin] < 1) return true;
	if(sscanf(params, "i", cid)) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/cspec <clan id (0=off)>");
	if(cid < 0 && cid > MAX_CLANS) return SCMf(playerid, COLOR_GREY, "ID Invalid! (0-%d)", MAX_CLANS);
	if(PlayerInfo[playerid][pClan] == cid && cid != 0) return SendClientMessage(playerid, COLOR_GREY, "Faci parte din acea factiune!");
	SpecClan[playerid] = cid;
	Iter_Add(clan_players<cid>, playerid);
	if(cid == 0) return SendClientMessage(playerid, COLOR_YELLOW, "Optiune dezactivata!");
	else {
		format(string, sizeof(string), "Acum vei vedea ce se scrie pe chatul clanului %d.", cid);
		SendClientMessage(playerid, COLOR_YELLOW, string);
	}
	return true;
}
cmd:fspec(playerid, params[]) {
	new fid;
	if(PlayerInfo[playerid][pAdmin] < 1) return true;
	if(sscanf(params, "i", fid)) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/fspec <fid (0=off)>");
	if(SpecFaction[playerid]==0&&fid==0) return true;
	if(fid < 0 && fid > MAX_FACTIONS) return SendClientMessage(playerid, COLOR_GREY, "ID Invalid!");
	if(PlayerInfo[playerid][pMember] == fid && fid != 0) return SendClientMessage(playerid, COLOR_GREY, "Faci parte din acea factiune!");
	if(fid == 0) {
		SendClientMessage(playerid, COLOR_YELLOW, "Optiune dezactivata!"), Iter_Remove(faction_players<SpecFaction[playerid]>, playerid);
		if(PlayerInfo[playerid][pMember]) Iter_Add(faction_players<PlayerInfo[playerid][pMember]>, playerid);
		SpecFaction[playerid] = 0;
		return true;
	}
	if(SpecFaction[playerid]) {
		Iter_Remove(faction_players<SpecFaction[playerid]>, playerid);
		if(PlayerInfo[playerid][pMember]) Iter_Add(faction_players<PlayerInfo[playerid][pMember]>, playerid);
	}
	SpecFaction[playerid] = fid;
	if(fid) {
		if(PlayerInfo[playerid][pMember]) Iter_Remove(faction_players<PlayerInfo[playerid][pMember]>, playerid);
		Iter_Add(faction_players<fid>, playerid);
	}
	SCMf(playerid, COLOR_YELLOW, "Acum vei vedea ce se scrie pe chatul factiunii %s (%d)!", FactionName(fid), fid);
	return true;
}

cmd:checkv(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) 
		return true;
	
	new id;
	if(sscanf(params, "u", id)) 
		return SendClientMessage(playerid, COLOR_RED, "Syntax: {FFFFFF}/chekcv <playerid/name>");
	
	if(!IsPlayerConnected(id)) 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este connectat!");
	
	if(!Iter_Count(MyVehicle<id>)) 
		return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Acel player nu are un vehicul!");

	SCMf(playerid, -1, "-- %s's (%d) vehicles --", GetName(id), id);
	foreach(new idd : MyVehicle<id>) SCMf(playerid, COLOR_LGREEN, "(ID: %d) Vehicle: %s | Spawned: %d", CarInfo[idd][cID], GetVehicleName(CarInfo[idd][cModel]), CarInfo[idd][Spawned]);
	return true;
}

cmd:closestcar(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 5)
		return SendClientMessage(playerid, COLOR_LGREEN, AdminOnly);

	if(IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COLOR_WHITE, "You're already in a car.");

	new vehicleid = GetClosestVehicle(playerid);
	if(GetVehicleVirtualWorld(vehicleid) == GetPlayerVirtualWorld(playerid)) {
		PutPlayerInVehicleEx(playerid, vehicleid, 0);
		gString[0] = EOS;
		format(gString, 45, "You teleported to the vehicle %d.", vehicleid);
		SendClientMessage(playerid, COLOR_GREY, gString);
	}
	return true;
}

cmd:movehouse(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 6) return true;
	new house;
	if(sscanf(params, "i", house)) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/movehouse <house id>");
	if(house < 1 || house > sql_houses) return SendClientMessage(playerid, COLOR_GREY, "Invalid house!");
	SetPVarInt(playerid, "MoveID", house);
	ShowPlayerDialog(playerid, DIALOG_MOVEHOUSE, DIALOG_STYLE_LIST, "Move house", "Interior\nExterior", "Ok", "Exit");
	return true;	
}
cmd:movebiz(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 6) return true;
	new house;
	if(sscanf(params, "i", house)) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/movebiz <biz id>");
	if(house < 1 || house > sizeof(BizzInfo)) return SendClientMessage(playerid, COLOR_GREY, "Invalid biz!");
	SetPVarInt(playerid, "MoveID", house);
	ShowPlayerDialog(playerid, DIALOG_MOVEBIZ, DIALOG_STYLE_LIST, "Move biz", "Interior\nExterior", "Ok", "Exit");
	return true;	
}

cmd:dp(playerid, params[]) {
	new id;
	if(PlayerInfo[playerid][pAdmin] < 5) 
		return true;

	if(sscanf(params, "i", id)) 
		return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/dp <punish id>");

	mysql_format(SQL, gQuery, 128, "SELECT * FROM `sanctions` WHERE `ID`='%d'", id);
	mysql_tquery(SQL, gQuery, "sql_check_sanctions", "ii", playerid, id);
	return true;
}

redist::sql_check_sanctions(playerid, id) {

	if(!cache_num_rows()) 
		return SendClientMessage(playerid, COLOR_GREY, "Punish id invalid!");

	mysql_format(SQL, gQuery, 128, "DELETE FROM `sanctions` WHERE `ID`='%d'", id);
	mysql_tquery(SQL, gQuery);
	return true;
}
cmd:lp(playerid, params[]) {
	new id;
	if(PlayerInfo[playerid][pAdmin] < 1) return true;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/lastpunish <playerid/name>");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
	ShowPunish(playerid, id);
	return true;
}

cmd:sstats(playerid, params[]) {
	new string[180];
	if(PlayerInfo[playerid][pAdmin] < 5) return true;
	SendClientMessage(playerid, COLOR_SERVER, "--------------------------------------------------------------------------------------------------------------------------");	
	format(string, sizeof(string), "Server start on %s", StartDate);
	SendClientMessage(playerid, COLOR_WHITE, string);
	new ticks = GetServerTickRate(), color[64];
	if(ticks >= 150) color = "{AAFF82}";
	else if(ticks < 150 && ticks >= 100) color = "{FFBFBF}";
	else color = "{FFBFBF}";
	format(string, sizeof(string), "Server tick rate: %s%d{FFFFFF} / streamer: %d | Queries: %d | Dynamic (objects: %d, area: %d) | Players online: %d/%d", color, GetServerTickRate(), Streamer_GetTickRate(), mysql_unprocessed_queries(), CountDynamicObjects(), CountDynamicAreas(), Iter_Count(Player), GetMaxPlayers());
	SendClientMessage(playerid, COLOR_WHITE, string);
	format(string, sizeof(string), "Registered accounts: %s | Houses: %d/%d | Businesses: %d/%d", FormatNumber(GetPlayerInregisters()), FreeHouses(), sql_houses, FreeBusinesses(), bussines);
	SendClientMessage(playerid, COLOR_WHITE, string);
	format(string, sizeof(string), "Admins online: %d (%d afk) | Helpers online: %d (%d afk) | Leaders online: %d (%d afk)", CheckAdmins(0), CheckAdmins(1), CheckHelpers(0), CheckHelpers(1), CheckLeaders(0), CheckLeaders(1));
	SendClientMessage(playerid, COLOR_WHITE, string);
	format(string, sizeof(string), "Players in paintball: %d, %d, %d", PlayersOnPaint(0), PlayersOnPaint(1), PlayersOnPaint(2));
	SendClientMessage(playerid, COLOR_WHITE, string);
	SendClientMessage(playerid, COLOR_SERVER, "--------------------------------------------------------------------------------------------------------------------------");	
	return true;
}

cmd:ah(playerid, params[]) {
    if(PlayerInfo[playerid][pAdmin] >= 1) {
        if(PlayerInfo[playerid][pAdmin] >= 1) {
            SendClientMessage(playerid, -1, "{008080}Admin 1:{FFFFFF} /ban /bano /kick /ajail /jailo /reports /ar /cr /mute /unmute /check /warn /goto /gethere /vre /o /disarm");
            SendClientMessage(playerid, -1, "{008080}Admin 1:{FFFFFF} /cc /spec /setvw /setint /freeze /unfreeze /starttp /slapcar /vsearch");
            SendClientMessage(playerid, -1, "{008080}Admin 1:{FFFFFF} /gotohouse /gotobiz /alicenses /rnewbie /afklist /cspec /spawncar /dm");
            SendClientMessage(playerid, -1, "{008080}Admin 1:{FFFFFF} /fspec /suspend /lp /slap /rmute /respawn/deletead /as /aaa3 /aaa2 /getip /alias");
        }
        if(PlayerInfo[playerid][pAdmin] >= 2) {
            SendClientMessage(playerid, -1, "{008080}Admin 2:{FFFFFF} /unjail /despawncar /jetpack /area /aclear /banip");
        }
        if(PlayerInfo[playerid][pAdmin] >= 3) {
            SendClientMessage(playerid, -1, "{008080}Admin 3:{FFFFFF} /setleader /mark /gotomark /getcar /gotocar /rac /fpk /fpkoff /agl /unban /givegun /unbanip");
        }
        if(PlayerInfo[playerid][pAdmin] >= 4) {
            SendClientMessage(playerid, -1, "{008080}Admin 4:{FFFFFF} /sethp /setarmor /unwarn /skick /sethelper");
        }
        if(PlayerInfo[playerid][pAdmin] >= 5) {
            SendClientMessage(playerid, -1, "{008080}Admin 5:{FFFFFF} /licitatie /setpaydayx /setchapter /startbp /endbp /debugair /svs /fpk /tod /acover /acoveroff /setlw /sethw");
        }
        if(PlayerInfo[playerid][pAdmin] >= 6) {
            SendClientMessage(playerid, -1, "{008080}Admin 6:{FFFFFF} /restart /restartgame /editjob /editclan /edithouse /movehouse /editbizz /deleteclan /systems");
            SendClientMessage(playerid, -1, "{008080}Admin 6:{FFFFFF} /setstat /restartmissions /givehouse /givebiz /movebiz /setaw /addsafezone /editsafezone");
            SendClientMessage(playerid, -1, "{008080}Admin 6:{FFFFFF} /moneyforall /rpforall /ppforall /alock /gotocp");
            SendClientMessage(playerid, -1, "{008080}Admin 6:{FFFFFF} /givehouse /givebiz /movebiz /setaw /addsafezone /editsafezone /givecrate /crateforall /setadmin");
            SendClientMessage(playerid, -1, "{008080}Admin 6:{FFFFFF} /luckywinnercar /luckycrate /setcrate /createeatstand /createhouse /creategarage /debugtickets");
        }
    }
    else SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
    return true;
}

cmd:setpaydayx(playerid, params[]) {
	if(!IsAdmin(playerid, 7))
		return SendClientMessage(playerid, COLOR_GREY, AdminOnly);

	new x=-1;
	if(sscanf(params, "d", x))
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/setpaydayx");

	if(NOT_IN_RANGE(x, 1, 11))
		return SendClientMessage(playerid, COLOR_GREY, "Invalid payday");

	_query("UPDATE `stuff` SET `Payday` = '%i'", x);
	payday_power=x;

	format(gString, sizeof gString, "* Admin %s a setat payday %dx", GetName(playerid), x);
	SendAdminMessage(COLOR_YELLOW, 1, gString);
	return true;
}

cmd:afklist(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) 
		return true;
	
	new x; gString[0] = EOS;
	SendClientMessage(playerid, -1, "AFK List:");
	foreach(new i : Player) {
		if(AFKSeconds[i] < 60)
			continue;

		SCMf(playerid, COLOR_WHITE, "%s (%d) for %d seconds.", GetName(i), i, AFKSeconds[i]);
		x++;
	}
	if(x == 0) return SendClientMessage(playerid, -1, "Nu au fost gasiti jucatori AFK!");
	SCMf(playerid, COLOR_LGREEN, "* Au fost gasiti %d jucatori AFK!", x);
	return true;
}
cmd:sethelper(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 4)
		return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);

	new id,helperlevel, reason[64];
	if(sscanf(params, "uis[64]",id,helperlevel, reason))
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/sethelper <playerid/name> <level(0-3)> <reason>");

	if !IsPlayerConnected(id) *then
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");

	if !IsPlayerLogged(id) *then
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este logat!");

	Iter_Add(Staff<HELPER>, id);
	if(helperlevel == 0) {
		HaveHelp[playerid] = -1;
		PlayerInfo[id][pHW] = 0;
		UpdateVar(id, "HW", 0);
		PlayerInfo[id][pExpHW] = -1;
		UpdateVar(id, "ExpHW", PlayerInfo[id][pExpHW]);
		NewbieChat[id] = true;

		Iter_Remove(Staff<HELPER>, id);
	}
	finishAchievement(id, 18);
	PlayerInfo[id][pHelper] = helperlevel;
	format(gString, 128, "You've been promoted to level %d helper, by %s, reason: %s", helperlevel, GetName(playerid), reason);
	SendClientMessage(id, COLOR_YELLOW, gString);
	format(gString, 128, "* Admin %s has set %s Helper level to %d, reason: %s", GetName(playerid), GetName(id), helperlevel, reason);
	SendAdminMessage(COLOR_YELLOW, 1, gString);

	_query("UPDATE users SET `Helper`='%d', `HelpedPlayers`='0' WHERE `ID`='%d'", helperlevel, PlayerInfo[id][pSQLID]);
	return true;
}
cmd:togfind(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid,COLOR_WHITE,AdminOnly);
	if(togfind[playerid] == 1)  {
		togfind[playerid] = 0;
		SendClientMessage(playerid,COLOR_WHITE,"Ai activat optiunea de a te cauta playerii.");
	}
	else
	{
		togfind[playerid] = 1;
		SendClientMessage(playerid,COLOR_WHITE,"Ai dezactivat optiunea de a te cauta playerii.");
	}
	return true;
}

cmd:gethere(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) 
		return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);

	extract params -> new player:id; else
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/gethere <playerid/name>");
	
	if(!IsPlayerConnected(id)) 
		return SendClientMessage(playerid, COLOR_GREY, "Player Invalid.");

	if(!IsPlayerLogged(id)) 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player este la logare.");

	if(DontSpec[id])
		return SendClientMessage(playerid, COLOR_GREY, "Nu poti teleporta acel jucator la tine!");

	new Float:idcx,Float:idcy,Float:idcz;
	GetPlayerPos(playerid, idcx, idcy, idcz);
	SetPlayerInterior(id,GetPlayerInterior(playerid));
	if(GetPlayerState(id) == 2) SetVehiclePosEx(GetPlayerVehicleID(id), idcx, idcy+4, idcz);
	else SetPlayerPos(id,idcx,idcy+2, idcz);
	Exception[id] = 5;
	InInterior[playerid]=InInteriorID[playerid]=INVALID_INTERIOR;
	SetPlayerVirtualWorld(id, GetPlayerVirtualWorld(playerid));

	SCMf(playerid, COLOR_GRAD3, "You have teleported %s to you.", GetName(id));
	SCMf(id, COLOR_GRAD3, "You have been teleported by admin %s.", GetName(playerid));
	return true;
}

cmd:gotoxyz(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	new string[128],interior,vw;
	new Float:x, Float:y, Float:z;
	if(sscanf(params, "fffii", x,y,z,interior,vw)) return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/gotoxyz <x> <y> <z> <interior> <virtual world>");
	SetPlayerPos(playerid, x, y, z);
	format(string, sizeof(string), "Te-ai teleportat cu succes. (%0.1f,%0.1f,%0.1f | int: %d | vw: %d)",x,y,z,interior, vw);
	SendClientMessage(playerid,COLOR_LGREEN, string);
	SetPlayerVirtualWorld(playerid, vw);
	SetPlayerInterior(playerid,interior);
	InInterior[playerid]=InInteriorID[playerid]=INVALID_INTERIOR;
	return true;
}
cmd:gotods(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, COLOR_WHITE,AdminOnly);
	if(GetPlayerState(playerid) == 2) SetVehiclePosEx(GetPlayerVehicleID(playerid), 2127.2947,-1128.1827,25.2686);
	else SetPlayerPos(playerid, -1657.8251,1210.2487,7.2500);
	SetPlayerInterior(playerid,0);
	InInterior[playerid]=InInteriorID[playerid]=INVALID_INTERIOR;
	SetPlayerVirtualWorld(playerid,0);	
	return true;
}
cmd:gotolv(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	if(GetPlayerState(playerid) == 2) SetVehiclePosEx(GetPlayerVehicleID(playerid), 1699.2, 1435.1, 10.7);
	else SetPlayerPos(playerid, 1699.2,1435.1, 10.7);
	SetPlayerInterior(playerid,0);
	InInterior[playerid]=InInteriorID[playerid]=INVALID_INTERIOR;
	SetPlayerVirtualWorld(playerid,0);
	return true;
}
cmd:gotosf(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	if(GetPlayerState(playerid) == 2) SetVehiclePosEx(GetPlayerVehicleID(playerid), -1417.0,-295.8,14.1);
	else SetPlayerPos(playerid, -1417.0,-295.8,14.1);
	SetPlayerInterior(playerid,0);
	InInterior[playerid]=InInteriorID[playerid]=INVALID_INTERIOR;
	SetPlayerVirtualWorld(playerid,0);
	return true;
}
cmd:gotols(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	if(GetPlayerState(playerid) == 2) SetVehiclePosEx(GetPlayerVehicleID(playerid), 1529.6,-1691.2,13.3);
	else SetPlayerPos(playerid, 1529.6,-1691.2,13.3);
	SetPlayerInterior(playerid,0);
	InInterior[playerid]=InInteriorID[playerid]=INVALID_INTERIOR;
	SetPlayerVirtualWorld(playerid,0);
	return true;
}

cmd:gotom(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	if(GetPlayerState(playerid) == 2) SetVehiclePosEx(GetPlayerVehicleID(playerid), -2317.8091,-1637.5575,483.7031);
	else SetPlayerPos(playerid,-2317.8091,-1637.5575,483.7031);
	SetPlayerInterior(playerid,0);
	InInterior[playerid]=InInteriorID[playerid]=INVALID_INTERIOR;
	SetPlayerVirtualWorld(playerid,0);
	return true;
}
cmd:gotoin(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	if(GetPlayerState(playerid) == 2) SetVehiclePosEx(GetPlayerVehicleID(playerid), 1416.107000,0.268620,1000.926000);
	else SetPlayerPos(playerid,1416.107000,0.268620,1000.926000);
	SetPlayerInterior(playerid,1);
	InInterior[playerid]=InInteriorID[playerid]=INVALID_INTERIOR;
	SetPlayerVirtualWorld(playerid,0);
	return true;
}

cmd:a(playerid, params[]) {
	if !IsAdmin(playerid, 1) *then
		return true;

	if(toga[playerid])
		return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Admin chatul este dezactivat din /toga.");

	extract params -> new string:text[144]; else
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/a <text>");
		
	format(gString, sizeof gString, "* (%d) Admin %s: %s", PlayerInfo[playerid][pAdmin], GetName(playerid), text);
	foreach(new i: Staff<ADMIN>) if(!toga[i]) SendClientMessage(i, COLOR_ADMCHAT, gString);
	return true;
}

cmd:toga(playerid) {
	if !IsAdmin(playerid, 1) *then
		return true;

	toga[playerid] = !toga[playerid];
	SendClientMessage(playerid, COLOR_YELLOW, toga[playerid] ? "Ai dezactivat admin chat-ul." : "Ai activat admin chat-ul.");
	return true;
}

cmd:aaa3(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return true;
	SetPlayerPos(playerid, 1477.5452,1742.9164,10.8125);
	SetPlayerVirtualWorld(playerid, 1337 + random(3000));
	SetPlayerInterior(playerid, 0);
	return true;
}
cmd:aaa2(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return true;
	SetPlayerPos(playerid, 1477.5452,1742.9164,10.8125);
	SetPlayerVirtualWorld(playerid, 1337);
	SetPlayerInterior(playerid, 0);
	return true;
}

cmd:gotocp(playerid) {
	if(!IsAdmin(playerid, 5))
		return SendClientMessage(playerid, COLOR_GREY, AdminOnly);

	if(JobWorking[playerid] && !IsAdmin(playerid, 7))
		return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Nu poti folosi aceasta comanda atata timp cat faci job!");

	if(cp_pos_x[playerid] == 0.0)
		return SendClientMessage(playerid, COLOR_GREY, "Nu ai un checkpoint activ!");

	SetPlayerPos(playerid, cp_pos_x[playerid], cp_pos_y[playerid], cp_pos_z[playerid]);
	SendClientMessage(playerid, COLOR_YELLOW, "Te-ai teleportat cu succes la checkpoint!");
	return true;
}
cmd:ip(playerid, params[]) {
	new id;
	if(PlayerInfo[playerid][pAdmin] < 1) 
		return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	
	if(sscanf(params, "u", id)) 
		return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/ip <playerid>");
	
	if(!IsPlayerConnected(id) || !IsPlayerConnected(id)) 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
	
	if(PlayerInfo[id][pAdmin] >= 4 && PlayerInfo[playerid][pAdmin] < 6) 
		return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Nu poti vedea IP-ul unui admin!");
	
	if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) 
		return SendClientMessage(playerid, -1, "Nu poti folosi comanda aceasta pe acel player.");
	
	new playersip[16];
	GetPlayerIp(id,playersip,sizeof(playersip));

	gString[0] = EOS;
	format(gString, 128, "Conturile cu IP-ul lui %s (%d):",GetName(id),id);
	SendClientMessage(playerid, COLOR_SERVER, gString);

	gQuery[0] = EOS;
	mysql_format(SQL, gQuery, sizeof(gQuery), "SELECT * FROM `users` WHERE `IP`='%s'", playersip);
	mysql_tquery(SQL, gQuery, "SearchIP", "i", playerid);
	return true;
}
redist::SearchIP(playerid) {
	new name[MAX_PLAYER_NAME], idd[16], x;
    for(new i, j = cache_num_rows(); i < j; i++) {
        cache_get_value_name(i, "name", name);
		cache_get_value_name(i, "id", idd);		
		x++;
		gString[0] = EOS;
		format(gString, 128, "%d. %s (user %d)", x, name, strval(idd));
		SendClientMessage(playerid, COLOR_WHITE, gString);
    }
    if(x == 0) SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Nu au fost gasite alte conturi de pe acest IP!");
	return true;
}
cmd:getip(playerid, params[]) {
	new id, playersip[16], string[180];
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	if(sscanf(params, "u", id)) return SendClientMessage(playerid,COLOR_GREY, "Syntax: {FFFFFF}/getip <playerid>");
	if(!IsPlayerConnected(id) || !IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
	if(PlayerInfo[id][pAdmin] >= 1 && PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Nu poti vedea IP-ul unui admin!");
	if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, -1, "Nu poti folosi comanda aceasta pe acel player.");
	GetPlayerIp(id,playersip,sizeof(playersip));
	format(string, sizeof(string), "%s (%d) IP: %s",GetName(id),id,playersip);
	SendClientMessage(playerid,COLOR_WHITE,string);
	return true;
}
cmd:goto(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/goto <playerid/name>");

	if(!IsPlayerConnected(id)) 
		return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");

	if(!IsPlayerLogged(id))
		return SendClientMessage(playerid, COLOR_GREY, "Acel player este la logare.");

	if(DontSpec[id])
		return SendClientMessage(playerid, COLOR_GREY, "Nu te poti teleporta la acel jucator!");

	if(PlayerInfo[playerid][pHelper] >= 1 && PlayerInfo[playerid][pAdmin] < 5) {
		if(PlayerInfo[id][pLevel] > 3 && PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, -1, "Ca helper, te poti teleporta doar la playerii cu nivel maxim de 3.");
	}
	if(id == playerid) return SendClientMessage(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda asupra ta!");
	new Float:ax,Float:ay,Float:az;
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid,ax,ay,az);	
	GetPlayerPos(id, x, y, z);
	
	SCMf(playerid, COLOR_GRAD3, "You have teleported to %s.", GetName(id));
	SCMf(id, COLOR_GRAD3, "Admin %s has been teleported to you.", GetName(playerid));
	
	new tmpcar = GetPlayerVehicleID(playerid);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) SetVehiclePosEx(tmpcar, x, y+4, z);
	else if(GetPlayerState(id) == PLAYER_STATE_DRIVER || GetPlayerState(id) == PLAYER_STATE_PASSENGER) {
		if(!put_player_in_vehicle(playerid, GetPlayerVehicleID(id))) SetPlayerPos(playerid,x,y+2, z);
	}
	else SetPlayerPos(playerid,x,y+2, z);

	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
	SetPlayerInterior(playerid, GetPlayerInterior(id));
	InInterior[playerid] = InInterior[id];
	InInteriorID[playerid] = InInteriorID[id];
	return true;
}

stock put_player_in_vehicle(playerid, vehicleid,x=-1) {
	enterVehicle[playerid] = true;
	while(++x<MaxSeats[GetVehicleModel(vehicleid) - 400]) 
		if !IsSeatTaken(vehicleid, x) *then return PutPlayerInVehicleEx(playerid, vehicleid, x),1;

	return false;
}

cmd:mark(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) 
		return true;

	GetPlayerPos(playerid, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
	SendClientMessage(playerid, COLOR_LGREEN, "Pozitii setate.");
	return true;
}
cmd:gotomark(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) 
		return true;

	if(TeleportDest[playerid][0] == 0) 
		return SendClientMessage(playerid, COLOR_LGREEN, "Nu ai salvat o pozitie.");

	if(GetPlayerState(playerid) == 2) SetVehiclePosEx(GetPlayerVehicleID(playerid), TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
	else SetPlayerPos(playerid, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
	SendClientMessage(playerid, COLOR_WHITE, "Ai fost teleportat cu succes.");
	SetPlayerInterior(playerid,0);
	return true;
}
cmd:gotocar(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 3) 
		return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);

	new testcar, string[128];
	if(sscanf(params, "d", testcar)) 
		return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/gotocar <Car ID>");

	if !IsValidVehicle(testcar) *then return SendClientMessage(playerid, COLOR_WHITE, "Invalid vehicle");
	new Float:cwx2,Float:cwy2,Float:cwz2;
	GetVehiclePos(testcar, cwx2, cwy2, cwz2);
	if(GetPlayerState(playerid) == 2) SetVehiclePosEx(GetPlayerVehicleID(playerid), cwx2, cwy2, cwz2);
	else SetPlayerPos(playerid, cwx2, cwy2, cwz2);
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	format(string, sizeof(string), "Te-ai teleportat la {7BAABA}vehiculul %d{FFFFFF}.", testcar);
	SendClientMessage(playerid, COLOR_WHITE, string);
	InInterior[playerid]=InInteriorID[playerid]=INVALID_INTERIOR;
	return true;
}

cmd:check(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	new id;
	if(sscanf(params, "u",id)) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/check <playerid/name>");
	if(!IsPlayerConnected(id) || !IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
	if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, -1, "Nu poti folosi aceasta comanda pe acel player.");
	ShowStats(playerid,id);
	return true;
}
cmd:pm(playerid, params[]) {
	new id, message[128], string[180];
	if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] < 1) return SendClientMessage(playerid, COLOR_WHITE, AdminOnly);
	if(sscanf(params, "us[128]", id, message)) return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/pm <playerid/name> <text>");
	if(!IsPlayerConnected(id) || !IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_GREY, "Nu iti poti da pm singur.");
	format(string, sizeof(string), "(( PM from %s: %s ))", GetName(playerid), message);
	SendClientMessage(id, COLOR_YELLOW, string);
	format(string, sizeof(string), "(( PM sent to %s: %s ))", GetName(id) , message);
	SendClientMessage(playerid, 0xC8E0DFFF, string);
	format(string, sizeof(string), "(PM) %s catre %s: %s", GetName(playerid), GetName(id), message);
	ChatLog(playerid, string);				
	return true;
}