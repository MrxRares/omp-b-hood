static const Float:airDropPos[][] = 
{{2865.90283, 1098.13037, 10.48633},
{589.04736, 1673.15686, 6.60816},
{698.44440, 1278.63647, 11.18866},
{893.87482, 893.41315, 12.91217},
{1636.91980, 717.08051, 10.37099},
{1631.82178, 346.22696, 18.97007},
{1973.45032, 589.00665, 10.46803},
{1206.95630, 2421.00830, 10.15223},
{1217.38306, 1984.80029, 6.28229},
{1934.78259, 1771.29895, 18.53222}};


static const airHP[3] = {5000, 6500, 9000};

new 
	airDropObject=INVALID_OBJECT_ID, air_Type, airHealth, airID, Text3D:airDropLabel=Text3D:INVALID_3DTEXT_ID, give_arrow[MAX_PLAYERS], GiftTime = 3600,
	Iterator:air_Players<MAX_PLAYERS>, air_Top[3] = {INVALID_PLAYER_ID, ...}, bool:collectGift[MAX_PLAYERS], air_time=-1,
	p_AirDropObject[MAX_PLAYERS] = {INVALID_OBJECT_ID, ...}, Text3D:p_AirDropLabel[MAX_PLAYERS] = {Text3D:INVALID_3DTEXT_ID, ...}
;

stock createAirDrop() {
	if(airDropObject!=INVALID_OBJECT_ID) DestroyDynamicObject(airDropObject);
	if(airDropLabel!=Text3D:INVALID_3DTEXT_ID) DestroyDynamic3DTextLabel(airDropLabel);
	airID = random(696969)%(sizeof(airDropPos)); air_Type = random(696969)%3;
	airHealth = airHP[air_Type];
	GiftTime=0;
	SetProgressBarMaxValue(giftbar, airHP[air_Type]);
	TextDrawSetString(GiftTDx, "~y~dropped");
	airDropObject = CreateDynamicObject(18849, airDropPos[airID][0], airDropPos[airID][1], airDropPos[airID][2] + 200.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.00);
	MoveDynamicObject(airDropObject, airDropPos[airID][0], airDropPos[airID][1], airDropPos[airID][2], 10);
	format(gString, 180, "{5BD2AD}(Gift Info) {FFFFFF}Un cadou de nivel %d (%d HP) a cazut dintr-un avion, acesta este in curs de aterizare...", air_Type+1, airHP[air_Type]);
	SendClientMessageToAll(COLOR_WHITE, gString);
}

public OnDynamicObjectMoved(objectid) {
	if(objectid!=airDropObject) return true;
	new x = airID;
	DestroyDynamicObject(airDropObject);
	Iter_Clear(air_Players);
	air_Top[0] = INVALID_PLAYER_ID;
	air_Top[1] = INVALID_PLAYER_ID;
	air_Top[2] = INVALID_PLAYER_ID;
	airDropObject = CreateDynamicObject(19054, airDropPos[x][0], airDropPos[x][1], airDropPos[x][2], 0.0, 0.0, 0.0, -1, -1, -1, 300.00);
	gString[0] = EOS;
	format(gString, 128, "{5BD2AD}(Gift Info) {FFFFFF}Cadoul a aterizat in zona %s, se asteapta jucatori pentru a fi desfacut cat mai repede.", Get3DZone(airDropPos[x][0], airDropPos[x][1], airDropPos[x][2]));
	SendClientMessageToAll(COLOR_WHITE, gString);
	format(gString, 75, "{0E671A}Giftbox level %d\n{FFFFFF}%d/%d", air_Type+1, airHealth, airHP[air_Type]);
	airDropLabel = CreateDynamic3DTextLabel(gString, -1, airDropPos[x][0], airDropPos[x][1], airDropPos[x][2]+1.0, 25.0);
	foreach(new i : Player) {
		give_arrow[i] = 0, collectGift[i] = false;
		if(p_AirDropLabel[i]!=Text3D:INVALID_3DTEXT_ID) DestroyDynamic3DTextLabel(p_AirDropLabel[i]), p_AirDropLabel[i]=Text3D:INVALID_3DTEXT_ID;
		if(p_AirDropObject[i]!=INVALID_OBJECT_ID) DestroyPlayerObject(i, p_AirDropObject[i]), p_AirDropObject[i]=INVALID_OBJECT_ID;
	}
	return true;
}

cmd:debugair(playerid, params[]) {
	if(!IsAdmin(playerid, 6))
		return true;
	createAirDrop();
	return true;
}

cmd:gotoair(playerid, params[]) {
	if(!IsAdmin(playerid, 6))
		return true;

	SetPlayerPos(playerid, airDropPos[airID][0], airDropPos[airID][1]+5, airDropPos[airID][2]);
	return true;
}

attack_gift(playerid, weaponid, objectid) {
	if(objectid!=airDropObject) return false;
	new demage = 0;
	switch(weaponid) {
		case 24: demage = 8;
		case 31: demage = 3;
		case 30: demage = 4;
		case 29: demage = 2;
		case 38: demage = 24;
		default: return true;
	}
	if(!Iter_Contains(air_Players, playerid)) {
		Iter_Add(air_Players, playerid);
		TextDrawShowForPlayer(playerid, _giftboxTD);
	}
	if(airHealth<=0) {
		if(air_time!=-1) KillTimer(air_time), air_time=-1;
		DestroyDynamicObject(airDropObject);
		DestroyDynamic3DTextLabel(airDropLabel);
		airDropObject=INVALID_OBJECT_ID;
		airDropLabel=Text3D:INVALID_3DTEXT_ID;
		new amount=1,szString[500],players; gString[0] = (EOS);
		foreach(new i : air_Players) if(give_arrow[i]) {
			TextDrawHideForPlayer(i, _giftboxTD);
			HideProgressBarForPlayer(i, giftbar);
			collectGift[i] = true;
			p_AirDropObject[i] = CreatePlayerObject(i, 1576, airDropPos[airID][0], airDropPos[airID][1], airDropPos[airID][2], 0.0, 0.0, 0.0, 300.0);
			format(gString, MAX_PLAYER_NAME+60, "%s's gift\n(use /collectgift)", GetName(i));
			p_AirDropLabel[i] = CreateDynamic3DTextLabel(gString, -1, airDropPos[airID][0], airDropPos[airID][1], airDropPos[airID][2], 300.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(i), GetPlayerInterior(i), i);
			players++;
		}
		for(new i=0;i<3;i++) {
			foreach(new p : air_Players) if(give_arrow[p] > amount) amount = give_arrow[p], air_Top[i] = p;
			Iter_Remove(air_Players, air_Top[i]);
			amount=0;
		}
		format(szString, 128, "{5BD2AD}(Gift Info) {FFFFFF}Cadoul a fost desfacut de %d jucatori:", players);
		for(new i=0;i<3;i++) if(air_Top[i]!=INVALID_PLAYER_ID) format(gString, MAX_PLAYER_NAME+5, " %s,", GetName(air_Top[i])), strcat(szString, gString);
		foreach(new i : air_Players) format(gString, MAX_PLAYER_NAME+5, " %s,", GetName(i)), strcat(szString, gString);
		_SCMTA(COLOR_WHITE, szString);
		GiftTime = 3600;
		SendClientMessageToAll(COLOR_WHITE, "{5BD2AD}(Gift Info) {FFFFFF}Felicitari tuturor jucatoriilor ce au participat!");
		return true;
	}
	airHealth -= demage;
	give_arrow[playerid] ++;
	SetProgressBarValue(giftbar, airHealth);
	ShowProgressBarForPlayer(playerid, giftbar);
	format(gString, 80, "giftbox level %d~n~%d/%d", air_Type+1, airHealth, airHP[air_Type]);
	TextDrawSetString(_giftboxTD, gString);
	format(gString, 75, "{0E671A}Giftbox level %d\n{FFFFFF}%d/%d", air_Type+1, airHealth, airHP[air_Type]);
	UpdateDynamic3DTextLabelText(airDropLabel, -1, gString);
	return true;
}

CMD:collectgift(playerid, params[]) {
	if(!collectGift[playerid]||!PlayerToPoint(2.5, playerid, airDropPos[airID][0],airDropPos[airID][1],airDropPos[airID][2]))
		return true;

	new szString[500] = {"#\tGift Owner\tPrize\n"}, count=0; gString[0] = EOS;
	for(new i=0;i<3;i++) if(air_Top[i]!=INVALID_PLAYER_ID&&IsPlayerConnected(air_Top[i])) {
		Selected[playerid][count][0] = air_Top[i];
		count++;
		format(gString, MAX_PLAYER_NAME+40, "%d.\t%s\t$%s. %s\n", count, GetName(air_Top[i]), FormatNumber(give_arrow[air_Top[i]] * 15000), !i?("1-20PP."):i!=2?("100-300EP."):("1-5RP."));
		strcat(szString, gString);
	}
	foreach(new i: air_Players) {
		Selected[playerid][count][0] = i;
		count++;
		format(gString, MAX_PLAYER_NAME+40, "%d.\t%s\t$%s.\n", count, GetName(i), FormatNumber(give_arrow[i] * 15000));
		strcat(szString, gString);		
	}
	ShowPlayerDialogEx(playerid, DIALOG_CGIFT, DIALOG_STYLE_TABLIST_HEADERS, "Collect Gift", szString, "Select", "Close");
	return true;
}