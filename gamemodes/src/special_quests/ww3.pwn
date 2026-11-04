
#define WW3

new quest_car[MAX_PLAYERS], map_vehicle[MAX_PLAYERS][10][10], map_actor[MAX_PLAYERS][10][10], map_shot[MAX_PLAYERS + 1][10], total_progress[MAX_PLAYERS], quest_progress[MAX_PLAYERS + 1][10];

static const Float:array_army[][] = {
	{-58.1050,1302.4622,12.4966},
	{1796.0667,842.9254,10.63171},
	{1687.2310,-484.9137,51.0032},
	{288.2988,1405.1313,10.3924},
	{348.5403,2526.6272,17.2386},
	{-749.7136,696.8380,18.2007},
	{2734.9456,1303.1719,6.8173},
	{2287.2239,336.2257,33.1579},
	{1769.8705,1715.6851,13.3693}
};

redist::load_quests(playerid) {
	total_progress[playerid] = 0;
	cache_get_value_name(0, "special_quests", srsString), sscanf(srsString, "a<i>[10]", quest_progress[playerid]);
	for(new i=0;i<10;++i) if(quest_progress[playerid][i]) ++total_progress[playerid];

	SCMf(playerid, COLOR_RED, "Special Quest: {FFFFFF}%d/10", total_progress[playerid]);
	return true;
}

cmd:startquest(playerid) {
	if(total_progress[playerid] >= 10)
		return SendClientMessage(playerid, COLOR_LGREEN, "Ai terminat deja quest-ul special!");

	if(PlayerInfo[playerid][pLevel] < 3)
		return SendClientMessage(playerid, -1, "Nu ai level 3!");

	if(PlayerInfo[playerid][pGunLicT] < gettime())
		return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Nu ai licenta de gun!");

	if(PlayerInfo[playerid][pCarLicT] < gettime())
		return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Nu ai licenta de driving!");

	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1965.4683,1623.2610,12.8618)) {
		SetPlayerCheckpoint(playerid, 1965.4683,1623.2610,12.8618, 2.0);
		CP[playerid] = 53;
		SendClientMessage(playerid, COLOR_YELLOW, "Nu esti in locul potrivit!");
		return true;
	}

	SendClientMessage(playerid, COLOR_YELLOW, "* Du-te la checkpoint-ul de pe minimap pentru a incepe quest-ul special!");
	SetPlayerCheckpoint(playerid, 290.1216,1821.1726,17.6406, 5.0);
	CP[playerid] = 3213;
	return true;
}

redist::reset_quest() {
	foreach(new i : Player) quest_progress[i] = quest_progress[MAX_PLAYERS];
	_query("UPDATE `users` SET `special_quests`", -1);
	return true;
}

cmd:restartspecialquest(playerid) {
	reset_quest();
	format(gString, sizeof gString, "* Admin %s a resetat special quest!", GetName(playerid));
	SendAdminMessage(COLOR_YELLOW, 7, gString);
	return true;
}

#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {
	ApplyDynamicActorAnimation(CreateDynamicActor(73, 1965.0925,1623.2255,12.8620,287.1142), "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1);
	CreateDynamic3DTextLabel("{FF0000}Special Quest\n{FFFFFF}Type ({FF0000}/startquest{FFFFFF}) for start special quests!", -1, 1965.4683,1623.2610,12.8618, 15.0);
	return true;
}

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) {
	if(!quest_car[playerid]) return true;
	if(total_progress[playerid] < 9) {
		if(hittype == BULLET_HIT_TYPE_VEHICLE) GetVehiclePos(hitid, fX, fY, fZ);
		for(new i=0;i<sizeof array_army;++i) 
			if(GetDistanceFromDistance(fX,fY,fZ, array_army[i][0], array_army[i][1], array_army[i][2]) < 50.0) {
		
			++map_shot[playerid][i];
			SCMf(playerid, COLOR_LIGHTRED, "Progress: %d/10 hits", map_shot[playerid][i]);
			if(map_shot[playerid][i] == 10) {
				for(new v=0;v<10;++v) if(map_vehicle[playerid][i][v]) SetVehicleHealth(map_vehicle[playerid][i][v], 150.0);
				RemovePlayerMapIcon(playerid, 70 + i);
				SetTimerEx(#destroy_quest_map, 15000, false, #ii, playerid, i);
				quest_progress[playerid][i] = true;
				if(++total_progress[playerid] != 9) SendClientMessage(playerid, COLOR_YELLOW, "* Du-te la urmatorul convoi de rusi!");
				else {
					SendClientMessage(playerid, COLOR_YELLOW, "* Du-te la checkpoint-ul de pe minimap si omoara-l pe Putin!");
					SetPlayerCheckpoint(playerid, 1481.2010,-1751.7272,15.4453, 5.0);
					map_vehicle[playerid][9][0] = CreateVehicleEx(409,1495.2917,-1739.7983,13.3469,89.7188,0,0);
					map_vehicle[playerid][9][1] = CreateVehicleEx(409,1483.4901,-1739.8986,13.3469,89.7906,0,0);
					map_vehicle[playerid][9][2] = CreateVehicleEx(409,1472.3320,-1739.9541,13.3469,91.1490,0,0);
					map_vehicle[playerid][9][3] = CreateVehicleEx(409,1461.9647,-1740.0680,13.3469,87.1948,0,0);

					for(new vw=0;vw<4;++vw) SetVehicleVirtualWorld(map_vehicle[playerid][9][vw], playerid + 10);

					map_actor[playerid][9][0] = CreateDynamicActor(163,1489.8033,-1739.2794,13.5469,353.4694,1,100.0,playerid+10); 
					map_actor[playerid][9][1] = CreateDynamicActor(163,1478.0302,-1739.0220,13.5469,2.8695,1,100.0,playerid+10); 
					map_actor[playerid][9][2] = CreateDynamicActor(163,1457.6785,-1739.8439,13.5469,315.2423,1,100.0,playerid+10); 
					map_actor[playerid][9][3] = CreateDynamicActor(163,1475.6354,-1751.6152,15.4453,8.1961,1,100.0,playerid+10); 
					map_actor[playerid][9][4] = CreateDynamicActor(163,1486.9541,-1751.8341,15.4453,1.6162,1,100.0,playerid+10); 
					map_actor[playerid][9][5] = CreateDynamicActor(228,1481.2010,-1751.7272,15.4453,2.2400,1,100.0,playerid+10); 
				}
			}
		}
	} else {
		if(GetDistanceFromDistance(1481.2010,-1751.7272,15.4453,fX,fY,fZ) < 3) {
			++total_progress[playerid];
			quest_progress[playerid][9] = 1;
			stopQuest(playerid);
			format(gString, sizeof gString, "(( {B3E027}Special Quest{A9C4E4}: %s a terminat quest-ul special si a primit un premiu special! ))", GetName(playerid));
			SendClientMessageToAll(COLOR_CLIENT, gString);
			SendClientMessage(playerid, COLOR_LGREEN, "* Ai terminat quest-ul special!");
			SpawnPlayer(playerid);

			new money = RandomEx(5000000, 30000000), pp = RandomEx(5,20), bp = RandomEx(100,500), gp = RandomEx(50, 300);
			GivePlayerCash(playerid, money);
			PlayerInfo[playerid][pPremiumPoints] += pp;
			UpdateVar(playerid, "GoldPoints", PlayerInfo[playerid][pPremiumPoints]);
			SCMf(playerid, COLOR_WHITE, "Ai primit: - $%s, %d premium points, %d b-points, %d Gift Points", FormatNumber(money), pp, bp, gp);
			if(random(100) > 50) {
				PlayerInfo[playerid][pHidden] ++;
				UpdateVar(playerid, "Hidden", PlayerInfo[playerid][pHidden]);
				SendClientMessage(playerid, COLOR_WHITE, " + Hidden Color");
			}
			givePoints(playerid, bp, gp);
		}
	}
	return true;
}

cmd:questinfo(playerid) {
    if(PlayerInfo[playerid][pLevel] < 3) return true;
    total_progress[playerid] = 0;
	cache_get_value_name(0, "special_quests", srsString), sscanf(srsString, "a<i>[10]", quest_progress[playerid]);
	for(new i=0;i<10;++i) if(quest_progress[playerid][i]) ++total_progress[playerid];
    SCMf(playerid, COLOR_RED, "Special Quest: {FFFFFF}%d/10", total_progress[playerid]);
    SendClientMessage(playerid, -1, "Armata rusa a pus stapanire pe server! Tu trebuie sa recuperezi serverul si sa salvezi cetatenii.");
    SendClientMessage(playerid, -1, "Ti-am pus la dispozitie un checkpoint unde o sa primesti echipament si instructiuni. Iti uram mult succes!");
    SendClientMessage(playerid, -1, "Premiile tale sunt:");
    SendClientMessage(playerid, -1, "Intre $5.000.000 si $30.000.000, 5-20 premium points, 100-500 b-points, 50-300 giftpoints si sansa sa castigi un hidden. ");
    return true;
}

redist::destroy_quest_map(playerid, i) {
	new x=-1;
	while(++x<10) {
		if(map_vehicle[playerid][i][x]) DestroyVehicleEx(map_vehicle[playerid][i][x], "quest"), map_vehicle[playerid][i][x]=0;
		if(map_actor[playerid][i][x]) DestroyDynamicActor(map_actor[playerid][i][x]), map_actor[playerid][i][x] = 0;
	}
	return true;
}

hook OnPlayerEnterCheckpoint(playerid) {
	if(CP[playerid] != 3213) return true;
	CP[playerid] = 0;
	DisablePlayerCheckpoint(playerid);
	SetPlayerVirtualWorld(playerid, playerid + 10);
	quest_car[playerid] = CreateVehicle(470,298.3282,1807.7299,17.6368,269.4753, -1, -1, -1);
	SetVehicleVirtualWorld(quest_car[playerid], playerid + 10);
	PutPlayerInVehicleEx(playerid, quest_car[playerid], 0);
	ServerWeapon(playerid,34,1000000);
	if(total_progress[playerid] < 9) {
		for(new i=0;i<9;++i) {
			if(quest_progress[playerid][i]) {++total_progress[playerid]; continue;}
			SetPlayerMapIcon(playerid, 70 + i, array_army[i][0], array_army[i][1],array_army[i][2], 56, 0xDE1B1BFF, MAPICON_GLOBAL);
			createMapArmy(playerid, i);
		}

		MesajLung(playerid, COLOR_YELLOW, "* A inceput misiunea, ti-am pus la dispozitie o arma. Trebuie sa mergi la fiecare checkpoint de pe harta si sa tragi in inamici! Dar ai grija, nu te apropria prea tare.");
	} else {
		SendClientMessage(playerid, COLOR_YELLOW, "* Acum ca nimeni nu te mai poate opri, trebuie sa il dobori pe presedintele Putin, urmeaza punctul rosul si asasineaza-l!");
		SetPlayerCheckpoint(playerid, 1481.2010,-1751.7272,15.4453, 5.0);
		map_vehicle[playerid][9][0] = CreateVehicleEx(409,1495.2917,-1739.7983,13.3469,89.7188,0,0);
		map_vehicle[playerid][9][1] = CreateVehicleEx(409,1483.4901,-1739.8986,13.3469,89.7906,0,0);
		map_vehicle[playerid][9][2] = CreateVehicleEx(409,1472.3320,-1739.9541,13.3469,91.1490,0,0);
		map_vehicle[playerid][9][3] = CreateVehicleEx(409,1461.9647,-1740.0680,13.3469,87.1948,0,0);

		for(new vw=0;vw<4;++vw) SetVehicleVirtualWorld(map_vehicle[playerid][9][vw], playerid + 10);

		map_actor[playerid][9][0] = CreateDynamicActor(163,1489.8033,-1739.2794,13.5469,353.4694,1,100.0,playerid+10); 
		map_actor[playerid][9][1] = CreateDynamicActor(163,1478.0302,-1739.0220,13.5469,2.8695,1,100.0,playerid+10); 
		map_actor[playerid][9][2] = CreateDynamicActor(163,1457.6785,-1739.8439,13.5469,315.2423,1,100.0,playerid+10); 
		map_actor[playerid][9][3] = CreateDynamicActor(163,1475.6354,-1751.6152,15.4453,8.1961,1,100.0,playerid+10); 
		map_actor[playerid][9][4] = CreateDynamicActor(163,1486.9541,-1751.8341,15.4453,1.6162,1,100.0,playerid+10); 
		map_actor[playerid][9][5] = CreateDynamicActor(228,1481.2010,-1751.7272,15.4453,2.2400,1,100.0,playerid+10); 
	}
	return true;
}

static Float:health;
stock timer_quest(playerid) {
	for(new i=0;i<sizeof array_army;++i) {
		if(!map_vehicle[playerid][i][0]) continue;
		if(GetPlayerDistanceFromPoint(playerid, array_army[i][0], array_army[i][1],array_army[i][2]) > 35) continue;
		SendClientMessage(playerid, COLOR_LGREEN, "Alerta! Esti prea aproapre de rusi!");
		GetPlayerHealthEx(playerid, health);
		SetPlayerHealthEx(playerid, health-0.5);
	}
	return true;
}

hook OnPlayerSpawn(playerid) {
	stopQuest(playerid);
	return true;
}

stock stopQuest(playerid) {
	if(!quest_car[playerid]) return true;
	save_special_quest(playerid);
	DestroyVehicleEx(quest_car[playerid], "special quest");
	DisablePlayerCheckpoint(playerid);
	SetPlayerVirtualWorld(playerid, 0);
	map_shot[playerid] = map_shot[MAX_PLAYERS];
	total_progress[playerid] = 0;
	ResetWeapons(playerid);

	for(new i=0;i<sizeof array_army;++i) RemovePlayerMapIcon(playerid, 70 + i);
	for(new i=0;i<9 * 10;++i) {
		if(!map_vehicle[playerid][i/9][i%9]) continue;
		DestroyVehicleEx(map_vehicle[playerid][i/9][i%9], "Quest");
		map_vehicle[playerid][i/9][i%9] = 0;
	}
	for(new i=0;i<9 * 10;++i) DestroyDynamicActor(map_actor[playerid][i/9][i%9]);

	save_special_quest(playerid);
	return true;
}


cmd:stopquest(playerid) {
	SendClientMessage(playerid, COLOR_YELLOW, "Quest oprit!");
	stopQuest(playerid);
	return true;
}

hook OnPlayerDisconnect(playerid, reason) {
	stopQuest(playerid);
	return true;
}

stock createMapArmy(playerid, d) {
	switch(d) {
		case 0: {
			map_vehicle[playerid][0][0] = CreateVehicleEx(433,-58.1050,1302.4622,12.4966,42.0612,43,0,-1); 
			map_vehicle[playerid][0][1] = CreateVehicleEx(433,-83.7928,1300.8083,13.0744,310.7176,43,0,-1);
			map_vehicle[playerid][0][2] = CreateVehicleEx(470,-76.2653,1304.6312,11.7870,273.5439,43,0,-1);
			map_vehicle[playerid][0][3] = CreateVehicleEx(470,-65.5831,1305.9624,11.5627,92.9122,43,0,-1); 
			map_vehicle[playerid][0][4] = CreateVehicleEx(470,-71.1552,1301.2826,11.5788,322.5789,43,0,-1);
			map_vehicle[playerid][0][5] = CreateVehicleEx(425,-67.7849,1293.0454,19.0093,61.4614,43,0,-1);

			map_actor[playerid][0][0] = CreateDynamicActor(287,-79.1787,1304.5789,12.0677,344.4161,1,100.0,playerid+10);
			map_actor[playerid][0][1] = CreateDynamicActor(287,-69.2549,1300.5215,11.5917,181.4813,1,100.0,playerid+10);
			map_actor[playerid][0][2] = CreateDynamicActor(287,-62.8121,1304.8640,11.5746,352.5630,1,100.0,playerid+10);
			map_actor[playerid][0][3] = CreateDynamicActor(287,-69.0561,1306.1653,11.5740,340.0296,1,100.0,playerid+10);
			map_actor[playerid][0][4] = CreateDynamicActor(287,-76.4902,1299.6647,11.8368,140.4343,1,100.0,playerid+10);
			map_actor[playerid][0][5] = CreateDynamicActor(287,-63.7295,1298.9623,11.5508,242.8951,1,100.0,playerid+10);
		}
		case 1: {
			map_vehicle[playerid][1][0] = CreateVehicleEx(470,1796.0667,842.9254,10.6317,313.3782,43,0,-1);
			map_vehicle[playerid][1][1] = CreateVehicleEx(433,1796.7036,852.3655,11.1054,26.3145,43,0,-1); 
			map_vehicle[playerid][1][2] = CreateVehicleEx(433,1795.0798,835.5379,11.1043,230.0355,43,0,-1);
			map_vehicle[playerid][1][3] = CreateVehicleEx(470,1803.0070,838.1534,10.6642,238.6528,43,0,-1);
			map_vehicle[playerid][1][4] = CreateVehicleEx(428,1804.4053,844.5175,10.7695,356.4454,4,75,-1);
			map_vehicle[playerid][1][5] = CreateVehicleEx(428,1790.9005,846.6049,10.7798,337.9196,4,75,-1);
			map_vehicle[playerid][1][6] = CreateVehicleEx(425,1805.1770,854.4012,11.3033,218.9172,43,0,-1);

			map_actor[playerid][1][0] = CreateDynamicActor(287,1800.4108,836.3148,10.6719,209.371,1,100.0,playerid+10);
			map_actor[playerid][1][1] = CreateDynamicActor(287,1791.5381,841.4886,10.6436,61.4767,1,100.0,playerid+10);
			map_actor[playerid][1][2] = CreateDynamicActor(287,1793.8387,850.0824,10.6719,31.3964,1,100.0,playerid+10);
			map_actor[playerid][1][3] = CreateDynamicActor(287,1801.6931,846.9073,10.6719,295.202,1,100.0,playerid+10);
			map_actor[playerid][1][4] = CreateDynamicActor(287,1806.3905,840.5723,10.6574,192.114,1,100.0,playerid+10);
			map_actor[playerid][1][5] = CreateDynamicActor(287,1793.9961,849.8279,10.6719,37.6397,1,100.0,playerid+10);
		}
		case 2: {
			map_vehicle[playerid][2][0] = CreateVehicleEx(470,1687.2310,-484.9137,51.0032,83.5075,43,0,-1);
			map_vehicle[playerid][2][1] = CreateVehicleEx(433,1676.5658,-483.5543,51.7227,77.3992,43,0,-1);
			map_vehicle[playerid][2][2] = CreateVehicleEx(433,1663.2335,-480.7762,51.8699,76.7206,43,0,-1);
			map_vehicle[playerid][2][3] = CreateVehicleEx(433,1649.4561,-476.7925,51.5773,72.5643,43,0,-1);
			map_vehicle[playerid][2][4] = CreateVehicleEx(432,1696.7489,-485.6083,50.6151,86.9565,43,0,-1);
			map_vehicle[playerid][2][5] = CreateVehicleEx(432,1709.0419,-486.3399,49.7835,84.8403,43,0,-1);
			map_vehicle[playerid][2][6] = CreateVehicleEx(432,1720.3829,-488.0009,48.5896,75.8114,43,0,-1);
			map_vehicle[playerid][2][7] = CreateVehicleEx(432,1730.4399,-493.0470,46.2262,35.5860,43,0,-1);

			map_actor[playerid][2][0] = CreateDynamicActor(287,1716.6448,-484.4382,49.0720,359.07,1,100.0,playerid+10); 
			map_actor[playerid][2][1] = CreateDynamicActor(287,1707.0883,-483.4330,49.9651,4.0882,1,100.0,playerid+10); 
			map_actor[playerid][2][2] = CreateDynamicActor(287,1700.3149,-483.0391,50.4286,4.0882,1,100.0,playerid+10); 
			map_actor[playerid][2][3] = CreateDynamicActor(287,1693.9965,-482.6644,50.7496,4.0882,1,100.0,playerid+10); 
			map_actor[playerid][2][4] = CreateDynamicActor(287,1686.1548,-481.8854,51.0621,4.0882,1,100.0,playerid+10); 
			map_actor[playerid][2][5] = CreateDynamicActor(287,1679.2557,-480.9725,51.2565,4.0882,1,100.0,playerid+10); 
		}
		case 3: {
			map_vehicle[playerid][3][0] = CreateVehicleEx(432,288.2988,1405.1313,10.3924,356.2362,43,0,-1);
			map_vehicle[playerid][3][1] = CreateVehicleEx(432,288.3003,1415.4093,10.3565,0.4854,43,0,-1);
			map_vehicle[playerid][3][2] = CreateVehicleEx(433,285.9728,1394.3467,11.0225,0.6802,43,0,-1);
			map_vehicle[playerid][3][3] = CreateVehicleEx(433,286.3867,1382.6604,11.0227,1.9688,43,0,-1);
			map_vehicle[playerid][3][4] = CreateVehicleEx(433,285.5308,1425.6426,11.0226,179.4546,43,0,-1);
			map_vehicle[playerid][3][5] = CreateVehicleEx(433,285.5077,1436.3452,11.0225,180.0674,43,0,-1);
			map_vehicle[playerid][3][6] = CreateVehicleEx(425,271.4157,1409.2772,11.1056,325.6488,43,0,-1);

			map_actor[playerid][3][0] = CreateDynamicActor(287,288.8184,1410.2288,10.3542,270.1349,1,100.0,playerid+10);
			map_actor[playerid][3][1] = CreateDynamicActor(287,288.7310,1420.3176,10.5171,281.1014,1,100.0,playerid+10);
			map_actor[playerid][3][2] = CreateDynamicActor(287,290.1954,1399.9969,10.4577,333.5012,1,100.0,playerid+10);
			map_actor[playerid][3][3] = CreateDynamicActor(287,291.5725,1406.4191,10.1922,270.4481,1,100.0,playerid+10);
			map_actor[playerid][3][4] = CreateDynamicActor(287,291.7418,1414.0223,10.1840,286.4282,1,100.0,playerid+10);
			map_actor[playerid][3][5] = CreateDynamicActor(287,295.1479,1412.0758,9.9237,259.4813,1,100.0,playerid+10); 
		}
		case 4: {
			map_vehicle[playerid][4][0] = CreateVehicleEx(433,348.5403,2526.6272,17.2386,180.4478,43,0,-1);
			map_vehicle[playerid][4][1] = CreateVehicleEx(433,339.7841,2526.5381,17.2818,175.3488,43,0,-1);
			map_vehicle[playerid][4][2] = CreateVehicleEx(548,348.6636,2536.9880,18.1967,233.7315,1,1,-1);
			map_vehicle[playerid][4][3] = CreateVehicleEx(432,365.9049,2539.1667,16.7049,178.6517,43,0,-1);
			map_vehicle[playerid][4][4] = CreateVehicleEx(548,381.0099,2535.4895,18.0072,134.7763,1,1,-1);
			map_vehicle[playerid][4][5] = CreateVehicleEx(433,385.0619,2526.7083,17.0612,180.4141,43,0,-1);
			map_vehicle[playerid][4][6] = CreateVehicleEx(433,393.1559,2526.9988,17.0380,181.3447,43,0,-1);

			map_actor[playerid][4][0] = CreateDynamicActor(287,352.7402,2523.4900,16.6624,197.6918,1,100.0,playerid+10); 
			map_actor[playerid][4][1] = CreateDynamicActor(287,363.3841,2535.1582,16.6744,226.3071,1,100.0,playerid+10); 
			map_actor[playerid][4][2] = CreateDynamicActor(287,375.0077,2532.6340,16.6176,141.6044,1,100.0,playerid+10); 
			map_actor[playerid][4][3] = CreateDynamicActor(287,381.8457,2524.6167,16.5203,187.3515,1,100.0,playerid+10); 
			map_actor[playerid][4][4] = CreateDynamicActor(287,391.3673,2521.3284,16.4844,198.3183,1,100.0,playerid+10); 
			map_actor[playerid][4][5] = CreateDynamicActor(287,337.3150,2531.8125,16.8018,106.8241,1,100.0,playerid+10); 
		}
		case 5: {
			map_vehicle[playerid][5][0] = CreateVehicleEx(432,-749.7136,696.8380,18.2007,334.6543,43,0,-1);
			map_vehicle[playerid][5][1] = CreateVehicleEx(432,-743.6710,708.7665,18.1365,330.0748,43,0,-1);
			map_vehicle[playerid][5][2] = CreateVehicleEx(433,-740.8630,726.3976,18.2516,147.3940,43,0,-1);
			map_vehicle[playerid][5][3] = CreateVehicleEx(433,-746.8801,729.7706,18.8248,147.8705,43,0,-1);
			map_vehicle[playerid][5][4] = CreateVehicleEx(433,-759.8530,737.4262,18.7559,151.2453,43,0,-1);
			map_vehicle[playerid][5][5] = CreateVehicleEx(433,-764.0677,739.9533,18.9691,145.2491,43,0,-1);

			map_actor[playerid][5][0] = CreateDynamicActor(287,-746.1142,702.0958,18.2926,252.8974,1,100.0,playerid+10); 
			map_actor[playerid][5][1] = CreateDynamicActor(287,-748.4835,693.5809,18.1257,242.8706,1,100.0,playerid+10); 
			map_actor[playerid][5][2] = CreateDynamicActor(287,-741.1248,708.0538,18.0453,241.9306,1,100.0,playerid+10); 
			map_actor[playerid][5][3] = CreateDynamicActor(287,-750.5636,729.2748,18.2197,72.3921,1,100.0,playerid+10); 
			map_actor[playerid][5][4] = CreateDynamicActor(287,-745.1376,735.2488,18.3062,294.3313,1,100.0,playerid+10); 
			map_actor[playerid][5][5] = CreateDynamicActor(287,-757.7331,743.6528,18.4364,64.8721,1,100.0,playerid+10); 
		}
		case 6: {
			map_vehicle[playerid][6][0] = CreateVehicleEx(432,2734.9456,1303.1719,6.8173,171.5232,43,0,-1);
			map_vehicle[playerid][6][1] = CreateVehicleEx(433,2727.7651,1307.2008,7.2598,266.3874,43,0,-1);
			map_vehicle[playerid][6][2] = CreateVehicleEx(470,2711.9221,1304.6383,6.6281,96.2874,43,0,-1);
			map_vehicle[playerid][6][3] = CreateVehicleEx(470,2704.9207,1304.0005,6.6271,273.0925,43,0,-1);
			map_vehicle[playerid][6][4] = CreateVehicleEx(432,2697.9885,1299.5532,6.9625,220.1451,43,0,-1);
			map_vehicle[playerid][6][5] = CreateVehicleEx(425,2721.9890,1312.9119,14.4185,132.1426,43,0,-1);

			map_actor[playerid][6][0] = CreateDynamicActor(287,2718.6113,1304.3442,14.0787,169.260,1,100.0,playerid+10);
			map_actor[playerid][6][1] = CreateDynamicActor(287,2700.7578,1300.6217,6.8015,154.2203,1,100.0,playerid+10);
			map_actor[playerid][6][2] = CreateDynamicActor(287,2712.0916,1301.4998,6.7344,209.6805,1,100.0,playerid+10);
			map_actor[playerid][6][3] = CreateDynamicActor(287,2721.5979,1304.0190,6.7420,168.3202,1,100.0,playerid+10);
			map_actor[playerid][6][4] = CreateDynamicActor(287,2731.7539,1300.9839,6.7344,173.6470,1,100.0,playerid+10);
			map_actor[playerid][6][5] = CreateDynamicActor(287,2733.2144,1310.1326,6.7483,359.4321,1,100.0,playerid+10); 
		}
		case 7: {
			map_vehicle[playerid][7][0] = CreateVehicleEx(433,2287.2239,336.2257,33.1579,241.3487,43,0,-1);
			map_vehicle[playerid][7][1] = CreateVehicleEx(433,2277.7949,342.8564,33.1692,229.5264,43,0,-1);
			map_vehicle[playerid][7][2] = CreateVehicleEx(433,2274.7288,298.7101,33.0976,63.1166,43,0,-1);
			map_vehicle[playerid][7][3] = CreateVehicleEx(433,2274.7288,298.7101,33.0976,63.1164,43,0,-1);
			map_vehicle[playerid][7][4] = CreateVehicleEx(433,2285.8833,292.4259,32.6216,57.4364,43,0,-1);
			map_vehicle[playerid][7][5] = CreateVehicleEx(432,2262.5181,309.3661,32.6683,359.3588,43,0,-1);
			map_vehicle[playerid][7][6] = CreateVehicleEx(432,2262.3457,322.7312,32.6694,359.7783,43,0,-1);

			map_actor[playerid][7][0] = CreateDynamicActor(287,2259.2830,323.4049,32.6641,120.6556,1,100.0,playerid+10);
			map_actor[playerid][7][1] = CreateDynamicActor(287,2267.8308,307.4672,32.6583,338.2561,1,100.0,playerid+10);
			map_actor[playerid][7][2] = CreateDynamicActor(287,2270.7959,314.8966,32.6641,338.2561,1,100.0,playerid+10);
			map_actor[playerid][7][3] = CreateDynamicActor(287,2270.7549,323.0653,32.6641,9.5897,1,100.0,playerid+10); 
			map_actor[playerid][7][4] = CreateDynamicActor(287,2259.0195,327.0945,32.6641,97.3239,1,100.0,playerid+10); 
			map_actor[playerid][7][5] = CreateDynamicActor(287,2258.1465,313.4315,32.6641,157.4910,1,100.0,playerid+10);
		}
		case 8: {
			map_vehicle[playerid][8][0] = CreateVehicleEx(433,1822.9137,1716.4833,13.5019,90.6205,43,0); 
			map_vehicle[playerid][8][1] = CreateVehicleEx(433,1806.0243,1716.2970,14.1715,90.4860,43,0); 
			map_vehicle[playerid][8][2] = CreateVehicleEx(433,1787.6082,1716.1802,14.1416,88.1527,43,0); 
			map_vehicle[playerid][8][3] = CreateVehicleEx(433,1769.8705,1715.6851,13.3693,88.8925,43,0); 
			map_vehicle[playerid][8][4] = CreateVehicleEx(432,1788.0743,1713.1520,6.7413,263.8842,43,0); 
			map_vehicle[playerid][8][5] = CreateVehicleEx(432,1806.7201,1714.0974,6.7456,87.1749,43,0); 

			map_actor[playerid][8][0] = CreateDynamicActor(287,1772.6826,1722.1180,13.2666,353.7333,1,100.0,playerid+10);
			map_actor[playerid][8][1] = CreateDynamicActor(287,1785.8964,1722.1187,13.8076,342.1400,1,100.0,playerid+10);
			map_actor[playerid][8][2] = CreateDynamicActor(287,1803.9896,1721.9792,13.9368,322.7131,1,100.0,playerid+10);
			map_actor[playerid][8][3] = CreateDynamicActor(287,1799.5376,1714.8414,6.7219,163.4752,1,100.0,playerid+10); 
			map_actor[playerid][8][4] = CreateDynamicActor(287,1786.7314,1705.5402,6.7344,20.0291,1,100.0,playerid+10); 
			map_actor[playerid][8][5] = CreateDynamicActor(287,1783.2979,1722.4965,6.7344,329.8964,1,100.0,playerid+10);
		}
	}
	for(new i=0;i<10;++i) SetVehicleVirtualWorld(map_vehicle[playerid][d][i], playerid + 10);
	return true;
}

save_special_quest(playerid) {
	_query("UPDATE `users` SET `special_quests` = '%i %i %i %i %i %i %i %i %i %i' WHERE `id` = '%i'", quest_progress[playerid][0], quest_progress[playerid][1], quest_progress[playerid][2], quest_progress[playerid][3], quest_progress[playerid][4], quest_progress[playerid][5], quest_progress[playerid][6], quest_progress[playerid][7], quest_progress[playerid][8], quest_progress[playerid][9], PlayerInfo[playerid][pSQLID]);
}