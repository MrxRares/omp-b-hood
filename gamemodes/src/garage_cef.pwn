#if defined _GARAGE_CEF_INCLUDED
	#endinput
#endif
#define _GARAGE_CEF_INCLUDED

#include <cef>

#define BROWSER_ID_GARAGE        (31)
#define GARAGE_RESOURCE          "garage"
#define GARAGE_URL               "http://cef/garage/index.html"
#define GARAGE_MAX_CARS          (50)
#define GARAGE_MANAGE_ESCAPE     (1)
#define GARAGE_ACTION_COOLDOWN   (250)
#define GARAGE_CARS_PER_EVENT    (4) 
#define GARAGE_REUSE_BROWSER     (1)      

#define GARAGE_PRICE_TOW         (5000)
#define GARAGE_PRICE_FINE        (5000000)
#define GARAGE_PP_VIPPLUS        (500)
#define GARAGE_PP_VIP            (300)
#define GARAGE_PP_RAINBOW        (300)
#define GARAGE_PP_RESETKM        (200)
#define GARAGE_PP_RESETDAYS      (100)

#define GARAGE_TOAST_INFO        (0)
#define GARAGE_TOAST_OK          (1)
#define GARAGE_TOAST_ERR         (2)

#define GARAGE_R_ERR             (0)
#define GARAGE_R_OK              (1)
#define GARAGE_R_ASK             (2)

#define GACT_SPAWN               (1)
#define GACT_TOW                 (2)
#define GACT_FIND                (3)
#define GACT_INSURANCE           (4)
#define GACT_UNSTUCK             (5)
#define GACT_SELL                (6)
#define GACT_VIPPLUS_OR_TP       (7)
#define GACT_VIP                 (8)
#define GACT_RAINBOW             (9)
#define GACT_RESETKM             (10)
#define GACT_RESETDAYS           (11)
#define GACT_REMOVETUNING        (12)
#define GACT_PAYFINE             (13)

new
	bool:GarageOpen[MAX_PLAYERS],
	bool:GarageBrowser[MAX_PLAYERS], 
	GarageCar[MAX_PLAYERS][GARAGE_MAX_CARS],
	GarageCount[MAX_PLAYERS],
	GaragePending[MAX_PLAYERS][3], 
	GarageLastTick[MAX_PLAYERS];

forward OnGarageReady(playerid, browserid);
forward OnGarageClose(playerid, browserid);
forward OnGarageAction(playerid, browserid, slot, action, arg);
forward OnGarageConfirm(playerid, browserid, bool:yes);


stock Garage_Init() {
	CEF_AddResource(GARAGE_RESOURCE);
	CEF_RegisterEvent("garage:ready",   "OnGarageReady");
	CEF_RegisterEvent("garage:close",   "OnGarageClose");
	CEF_RegisterEvent("garage:action",  "OnGarageAction",  Argument_Integer, Argument_Integer, Argument_Integer);
	CEF_RegisterEvent("garage:confirm", "OnGarageConfirm", Argument_Bool);
	return 1;
}

stock Garage_OnDisconnect(playerid) {
	GarageOpen[playerid] = false;
	GarageBrowser[playerid] = false;
	GarageCount[playerid] = 0;
	GaragePending[playerid][0] = -1;
	return 1;
}

stock Garage_OnBrowserCreated(playerid, browserid, bool:success) {
	if(browserid != BROWSER_ID_GARAGE || success) return 0;
	GarageBrowser[playerid] = false;
	if(!GarageOpen[playerid]) return 1;
	GarageOpen[playerid] = false;
	ShowPlayerVehicle(playerid);
	return 1;
}

static Garage_Toast(playerid, kind, const msg[]) {
	CEF_EmitEvent(playerid, BROWSER_ID_GARAGE, "garage:toast", CEF_INT(kind), CEF_STR(msg));
	return 1;
}

static Garage_Err(playerid, const msg[]) {
	Garage_Toast(playerid, GARAGE_TOAST_ERR, msg);
	return GARAGE_R_ERR;
}

static Garage_Ok(playerid, const msg[]) {
	Garage_Toast(playerid, GARAGE_TOAST_OK, msg);
	return GARAGE_R_OK;
}

static Garage_Ask(playerid, slot, action, arg, const title[], const text[], const label[], tone) {
	GaragePending[playerid][0] = action;
	GaragePending[playerid][1] = slot;
	GaragePending[playerid][2] = arg;
	CEF_EmitEvent(playerid, BROWSER_ID_GARAGE, "garage:ask", CEF_STR(title), CEF_STR(text), CEF_STR(label), CEF_INT(tone));
	return GARAGE_R_ASK;
}

static Garage_Resolve(playerid, slot) {
	if(!GarageOpen[playerid] || slot < 0 || slot >= GarageCount[playerid]) return -1;
	new car = GarageCar[playerid][slot];
	if(car < 0 || !Iter_Contains(MyVehicle<playerid>, car)) return -1;
	return car;
}

static Garage_Original(playerid, car, dialogid, listitem, const input[] = "") {
	new buf[32];
	format(buf, sizeof buf, "%s", input);
	listitemm[playerid] = car;
	dialogID[playerid] = dialogid;
	OnDialogResponse(playerid, dialogid, 1, listitem, buf);
	return 1;
}

static Garage_CheckpointGate(playerid, car, slot, action, arg, bool:confirmed) {
	if(CP[playerid] == 0) return GARAGE_R_OK;
	if(!confirmed) return Garage_Ask(playerid, slot, action, arg, "Active checkpoint", "You already have an active checkpoint.\nCancel it and continue?", "Cancel checkpoint", 1);
	Garage_Original(playerid, car, DIALOG_CHECKPOINT, 0);
	if(CP[playerid] != 0) return Garage_Err(playerid, "Eroare: Nu ai putut anula checkpoint-ul curent.");
	return GARAGE_R_OK;
}

static Garage_Rec(playerid, slot, rec[], len) {
	new car = GarageCar[playerid][slot], model = CarInfo[car][cModel], veh = CarInfo[car][Spawned], now = gettime();
	new name[32], plate[16], status, flags, speed, boost, tp;

	format(name, sizeof name, "%s", aVehicleNames[model - 400]);
	format(plate, sizeof plate, "%s", CarInfo[car][cLicense]);
	for(new i = 0, l = strlen(plate); i < l; i++) if(plate[i] == '|' || plate[i] == ';') plate[i] = ' ';

	if(veh) {
		if(IsVehicleOccupied(veh)) status = 2;
		else if(CarInfo[car][cGarage] != -1 && GetVehicleVirtualWorld(veh)) status = 3;
		else status = 1;
	}

	if(CarInfo[car][cPremium])           flags |= 1;
	if(CarInfo[car][cRainBow])           flags |= 2;
	if(CarInfo[car][cVip])               flags |= 4;
	if(strlen(CarInfo[car][cText]) >= 3) flags |= 8;
	if(CarInfo[car][cNeon])              flags |= 16;
	if(CarInfo[car][cSNeon])             flags |= 32;
	if(CarInfo[car][cPFuel])             flags |= 64;
	if(CarInfo[car][Confiscated])        flags |= 128;
	if(CarInfo[car][cSpecial])           flags |= 512;

	speed = GetVehicleMaxSpeed(model);
	boost = StageSpeed[CarInfo[car][cStage]] + (CarInfo[car][cPremium] ? (300 - speed) : 0);
	tp    = (now < CarInfo[car][cTimeGoto]) ? (CarInfo[car][cTimeGoto] - now) : 0;

	format(rec, len, "%d|%d|%s|%s|%d|%d|%.2f|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d",
		slot, model, name, plate, status, CarInfo[car][cTime], CarInfo[car][KM], CarInfo[car][Dayss],
		CarInfo[car][cPoints], CarInfo[car][cTax], CarInfo[car][cValue], flags, CarInfo[car][cStage],
		speed, boost, tp, CarInfo[car][cLock] ? 1 : 0);
	return 1;
}

static Garage_Send(playerid, selected = -1) {
	if(!GarageOpen[playerid]) return 0;

	GarageCount[playerid] = 0;
	foreach(new car : MyVehicle<playerid>) {
		if(GarageCount[playerid] >= GARAGE_MAX_CARS) break;
		GarageCar[playerid][GarageCount[playerid]++] = car;
	}

	new count = GarageCount[playerid];
	CEF_EmitEvent(playerid, BROWSER_ID_GARAGE, "garage:begin", CEF_INT(count), CEF_INT(GetSlots(playerid)), CEF_INT(PlayerInfo[playerid][pPremiumPoints]), CEF_INT(GetPlayerCash(playerid)));

	new chunk[GARAGE_CARS_PER_EVENT * 160], rec[200];
	for(new i = 0; i < count; i++) {
		Garage_Rec(playerid, i, rec, sizeof rec);
		if(chunk[0]) strcat(chunk, ";", sizeof chunk);
		strcat(chunk, rec, sizeof chunk);
		if(((i + 1) % GARAGE_CARS_PER_EVENT) == 0 || i == count - 1) {
			CEF_EmitEvent(playerid, BROWSER_ID_GARAGE, "garage:car", CEF_STR(chunk));
			chunk[0] = 0;
		}
	}
	CEF_EmitEvent(playerid, BROWSER_ID_GARAGE, "garage:end", CEF_INT(selected));
	return 1;
}


static Garage_Update(playerid, slot) {
	if(!GarageOpen[playerid] || slot < 0 || slot >= GarageCount[playerid]) return 0;
	new rec[200];
	Garage_Rec(playerid, slot, rec, sizeof rec);
	CEF_EmitEvent(playerid, BROWSER_ID_GARAGE, "garage:upd", CEF_STR(rec), CEF_INT(PlayerInfo[playerid][pPremiumPoints]), CEF_INT(GetPlayerCash(playerid)));
	return 1;
}

stock Garage_Open(playerid) {
	if(!CEF_PlayerHasPlugin(playerid)) return ShowPlayerVehicle(playerid);
	if(!Iter_Count(MyVehicle<playerid>)) return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Nu ai un vehicul personal!");
	if(GarageOpen[playerid]) return 1;


    CEF_ClearChat(playerid);

	GarageOpen[playerid] = true;
	GaragePending[playerid][0] = -1;
	GarageLastTick[playerid] = 0;

	#if GARAGE_REUSE_BROWSER
		if(GarageBrowser[playerid]) { 
			CEF_SetBrowserVisible(playerid, BROWSER_ID_GARAGE, true);
			CEF_FocusBrowser(playerid, BROWSER_ID_GARAGE, true);
			#if GARAGE_MANAGE_ESCAPE
				CEF_SetEscapeMenuMode(playerid, CEF_ESCAPE_MENU_CUSTOM);
			#endif
			CEF_EmitEvent(playerid, BROWSER_ID_GARAGE, "garage:reset");
			Garage_Send(playerid);
			return 1;
		}
	#endif

	GarageBrowser[playerid] = true;
	CEF_CreateBrowser(playerid, BROWSER_ID_GARAGE, GARAGE_URL, true, true);
	#if GARAGE_MANAGE_ESCAPE
		CEF_SetEscapeMenuMode(playerid, CEF_ESCAPE_MENU_CUSTOM);
	#endif
	return 1;
}

stock Garage_Close(playerid) {
	if(!GarageOpen[playerid]) return 0;

	GarageOpen[playerid] = false;
	GaragePending[playerid][0] = -1;

	#if GARAGE_REUSE_BROWSER
		CEF_SetBrowserVisible(playerid, BROWSER_ID_GARAGE, false);
		CEF_FocusBrowser(playerid, BROWSER_ID_GARAGE, false);
	#else
		GarageBrowser[playerid] = false;
		CEF_DestroyBrowser(playerid, BROWSER_ID_GARAGE);
	#endif
	#if GARAGE_MANAGE_ESCAPE
		CEF_SetEscapeMenuMode(playerid, CEF_ESCAPE_MENU_GTA);
	#endif
	return 1;
}


static Garage_Run(playerid, slot, action, arg, bool:confirmed) {
	new car = Garage_Resolve(playerid, slot);
	if(car == -1) return Garage_Err(playerid, "Eroare: Vehicul invalid. Redeschide meniul.");

	new veh = CarInfo[car][Spawned], pp = PlayerInfo[playerid][pPremiumPoints];

	switch(action) {

		case GACT_SPAWN: {
			if(!veh) {
				if(CarInfo[car][Confiscated]) return Garage_Err(playerid, "Acest vehicul este confiscat deoarece a fost parcat neregulamentar! Plateste amenda.");
				if(MyVehicleSpawn[playerid] >= (!PlayerInfo[playerid][pReborn] ? 4 : 6)) return Garage_Err(playerid, !PlayerInfo[playerid][pReborn] ? "Eroare: Poti avea doar 4 masini spawnate." : "Eroare: Poti avea doar 6 masini spawnate.");

				SpawnPlayerCar(playerid, car);	
				if(!CarInfo[car][Spawned]) return Garage_Err(playerid, "Eroare: Vehiculul nu a putut fi spawnat.");
				return Garage_Ok(playerid, "Vehiculul a fost spawnat!");
			}
			if(IsAttached(veh)) return Garage_Err(playerid, "Eroare: Nu poti folosi aceasta functie momentan!");
			if(IsVehicleOccupied(veh)) return Garage_Err(playerid, "Eroare: Vehiculul tau este ocupat!");
			DestroyPlayerCar(car);	
			return Garage_Ok(playerid, "Vehiculul a fost despawnat!");
		}

		case GACT_TOW: {
			if(GetPlayerCash(playerid) < GARAGE_PRICE_TOW) return Garage_Err(playerid, "Nu ai $5000!");
			if(!veh) return Garage_Err(playerid, "Eroare: Vehiculul tau nu este spawnat!");
			if(IsVehicleOccupied(veh)) return Garage_Err(playerid, "Eroare: Vehiculul tau este ocupat!");
			if(CarInfo[car][Confiscated]) return Garage_Err(playerid, "Acest vehicul este confiscat deoarece a fost parcat neregulamentar! Plateste amenda.");
			if(IsAttached(veh)) return Garage_Err(playerid, "Eroare: Nu poti folosi aceasta functie momentan!");
			if(!confirmed) return Garage_Ask(playerid, slot, action, arg, "Tow vehicle", "Your vehicle will be respawned and repaired.\nCost: $5,000.", "Pay $5,000", 0);

			SetVehicleToRespawn(CarInfo[car][Spawned]); SetVehicleHealth(CarInfo[car][Spawned], CarInfo[car][cVip] ? 2000 : 1000);
			CarInfo[car][cTime] = 600;
			SetTunning(car); GivePlayerCash(playerid, -5000);

			return Garage_Ok(playerid, "Vehiculul a fost tractat!");
		}

		case GACT_FIND: {
			new Float:vehx, Float:vehy, Float:vehz, gate = Garage_CheckpointGate(playerid, car,slot, action, arg, confirmed);

			if(!veh) return Garage_Err(playerid, "Eroare: Vehiculul tau nu este spawnat!");
			if(gate != GARAGE_R_OK) return gate;

			GetVehiclePos(CarInfo[car][Spawned], vehx, vehy, vehz);
			SetPlayerCheckpoint(playerid, vehx, vehy, vehz, 3.0);
			CP[playerid] = 53;

			return Garage_Ok(playerid, "Checkpoint-ul a fost setat. Urmeaza-l pentru a-ti gasi vehiculul!");
		}

		case GACT_INSURANCE: {
			if(arg < 1 || arg + CarInfo[car][cPoints] > 5) return Garage_Err(playerid, "Nu poti avea mai mult de 5 puncte de asigurare!");
			if(GetPlayerCash(playerid) < CarInfo[car][cTax] * arg) return Garage_Err(playerid, "Eroare: Nu ai suma necesara pentru a cumpara puncte de asigurare!");

			CarInfo[car][cPoints] += arg;
			GivePlayerCash(playerid, -CarInfo[car][cTax] * arg);
			_query("UPDATE `cars` SET `Points`='%d' WHERE `ID`='%d'", CarInfo[car][cPoints], CarInfo[car][cID]);
			return Garage_Ok(playerid, "Punctele de asigurare au fost cumparate!");
		}

		case GACT_UNSTUCK: {
			if(!veh) return Garage_Err(playerid, "Eroare: Vehiculul tau nu este spawnat!");
			if(IsAttached(veh)) return Garage_Err(playerid, "Eroare: Nu poti folosi aceasta functie momentan!");
			if(IsVehicleOccupied(veh)) return Garage_Err(playerid, "Eroare: Vehiculul tau este ocupat!");
			new gate = Garage_CheckpointGate(playerid, car,slot, action, arg, confirmed);
			if(gate != GARAGE_R_OK) return gate;

			if(IsAFLYCar(CarInfo[car][Spawned])) {
				SetVehiclePosEx(CarInfo[car][Spawned], -1649.1798, -159.0667, 17.3618);
				SetVehicleZAngleEx(CarInfo[car][Spawned], -44.1000);
                new randspawn = random(sizeof(HeliVehPos));
				SetVehiclePosEx(CarInfo[car][Spawned], HeliVehPos[randspawn][0], HeliVehPos[randspawn][1], HeliVehPos[randspawn][2]);
				SetVehicleZAngleEx(CarInfo[car][Spawned], 44.4000);
				SetPlayerCheckpoint(playerid, HeliVehPos[randspawn][0], HeliVehPos[randspawn][1], HeliVehPos[randspawn][2], 5.0);
			}
			else if(IsABOATCar(CarInfo[car][Spawned])) {
		        new randspawn = random(sizeof(BoatVehPos));
				SetVehiclePosEx(CarInfo[car][Spawned], BoatVehPos[randspawn][0], BoatVehPos[randspawn][1], BoatVehPos[randspawn][2]);
			    SetVehicleZAngleEx(CarInfo[car][Spawned], -173.4001);
			    SetPlayerCheckpoint(playerid, BoatVehPos[randspawn][0], BoatVehPos[randspawn][1], BoatVehPos[randspawn][2], 5.0);
	 	    }
			else {
		        new randspawn = random(sizeof(DealerCarPos));
				SetVehiclePosEx(CarInfo[car][Spawned], DealerCarPos[randspawn][0], DealerCarPos[randspawn][1], DealerCarPos[randspawn][2]);
				SetVehicleZAngleEx(CarInfo[car][Spawned], -173.4001);
				SetPlayerCheckpoint(playerid, DealerCarPos[randspawn][0], DealerCarPos[randspawn][1], DealerCarPos[randspawn][2], 5.0);
			}
			
            CP[playerid] = 53;
			return Garage_Ok(playerid, "Vehiculul a fost mutat. Checkpoint setat.");
		}

		case GACT_SELL: {
			if(TradeID[playerid] != -1)  return Garage_Err(playerid, "Eroare: Nu poti folosi aceasta comanda atata timp cat esti implicat intr-o afacere!");
			if(!veh) return Garage_Err(playerid, "Eroare: Vehiculul tau nu este spawnat!");
			if(!PlayerToPoint(10, playerid, -1657.8251, 1210.2487, 7.2500)) return Garage_Err(playerid, "Trebuie sa fii la dealership. Foloseste /gps pentru a afla unde este.");
			if(IsAttached(veh)) return Garage_Err(playerid, "Eroare: Nu poti folosi aceasta functie momentan!");
			if(GetPlayerVehicleID(playerid) != veh) return Garage_Err(playerid, "Eroare: Trebuie sa fi in acel vehicul!");
			if(CarInfo[car][cSpecial]) return Garage_Err(playerid, "Eroare: Nu poti vinde acesta masina!");

			new value = CarInfo[car][cValue] / 2;
			if(!confirmed) {
				new txt[128];
				format(txt, sizeof txt, "Are you sure you want to sell your %s for $%s?\nThis cannot be undone.", aVehicleNames[CarInfo[car][cModel] - 400], FormatNumber(value));
				return Garage_Ask(playerid, slot, action, arg, "Sell vehicle", txt, "Sell", 1);
			}

			PlayerSellCar[playerid] = car;
			if(CP[playerid] == 43 || CP[playerid] == 53) { CP[playerid] = 0; DisablePlayerCheckpointEx(playerid); }
						
			GivePlayerCash(playerid, value);

			format(gString, sizeof gString, "Ai primit $%s pentru ca ti-ai vandut vehiculul!", FormatNumber(value));
			Garage_Ok(playerid, gString);
            
			format(gString, sizeof gString, "%s si-a vandut vehiculul %s[%d] (la stat) si a primit $%s.", GetName(playerid), aVehicleNames[CarInfo[car][cModel]-400], car, FormatNumber(value));
			SendAdminMessage(COLOR_YELLOW, 1, gString);

			DestroyPlayerCar(car);
			Iter_Remove(MyVehicle<playerid>, car);
			_query("DELETE FROM `cars` WHERE `ID`='%d' LIMIT 1", CarInfo[car][cID]);
			return Garage_Ok(playerid, "Felicitari! Ti-ai vandut vehiculul.");
		}

		case GACT_VIPPLUS_OR_TP: {
			if(!CarInfo[car][cVip]) {
				if(!veh) return Garage_Err(playerid, "Eroare: Vehiculul tau nu este spawnat!");
				if(strlen(CarInfo[car][cText]) < 3) return Garage_Err(playerid, "Pentru a upgrada la 'VIP Plus Vehicle' trebuie mai intai ca vehiculul sa aiba optiunea 'VIP'!");
				if(pp < GARAGE_PP_VIPPLUS) return Garage_Err(playerid, "Nu ai destule Premium Points.");
				if(!confirmed) return Garage_Ask(playerid, slot, action, arg, "Upgrade to VIP Plus", "Are you sure you want to upgrade? (500 PP)\n\nBenefits:\n- The vehicle has 2000 HP.\n- You can teleport the vehicle to you (with a cooldown).", "Upgrade - 500 PP", 2);
  
				if(CarInfo[car][cVip]) return SendClientMessage(playerid, COLOR_LGREEN, "Eroare: Ai deja upgradat la VIP Plus.");
				if(strlen(CarInfo[car][cText]) < 3) return SendClientMessage(playerid, -1, "Eraore: Acest vehicul nu are VIP.");

				PlayerInfo[playerid][pPremiumPoints] -= 500; CarInfo[car][cVip] = true;	CarInfo[car][cTimeGoto] = gettime();
			    UpdateVar(playerid, "GoldPoints", PlayerInfo[playerid][pPremiumPoints]);

				format(gString, sizeof(gString), "%s si-a upgradat vehiculul %s[id: %d] la unul VIP Plus pentru 500 Premium Points.", GetName(playerid), aVehicleNames[CarInfo[car][cModel]-400], car);
			    InsertLog(playerid, gString, LOG_SHOP);	

				_query("UPDATE `cars` SET `VIP`='%d', `TimeGoto`='%d' WHERE `ID`='%d'", CarInfo[car][cVip], CarInfo[car][cTimeGoto], CarInfo[car][cID]);
				return Garage_Ok(playerid, "Felicitari! Ti-ai upgradat vehiculul la unul VIP Plus.");
			}

			if(!veh) return Garage_Err(playerid, "Eroare: Vehiculul tau nu este spawnat!");
			if(IsVehicleOccupied(veh))  return Garage_Err(playerid, "Eroare: Vehiculul tau este ocupat!");
			if(IsAttached(veh)) return Garage_Err(playerid, "Eroare: Nu poti folosi aceasta functie momentan!");
			if(gettime() < CarInfo[car][cTimeGoto]) {
				new left = CarInfo[car][cTimeGoto] - gettime(), msg[96];
				format(msg, sizeof msg, "Nu poti folosi aceasta functie pentru %d minute and %d secunde.", left / 60, left % 60);
				return Garage_Err(playerid, msg);
			}
			
			new Float: X, Float: Y, Float: Z;
			GetPlayerPos(playerid, X, Y, Z);
			SetVehiclePosEx(CarInfo[car][Spawned], X, Y+4, Z);
			SetVehicleVirtualWorld(CarInfo[car][Spawned], GetPlayerVirtualWorld(playerid));
			LinkVehicleToInterior(CarInfo[car][Spawned], GetPlayerInterior(playerid));
			CarInfo[car][cTimeGoto] = gettime()+(PlayerInfo[playerid][pVip]!=3?900:450);

			_query("UPDATE `cars` SET `TimeGoto`='%d' WHERE `ID`='%d'", CarInfo[car][cTimeGoto], CarInfo[car][cID]);
			return Garage_Ok(playerid, "Vehiculul tau este pe drum.");
		}

		case GACT_VIP: {
			if(!veh) return Garage_Err(playerid, "Eroare: Vehiculul tau nu este spawnat!");
			if(strlen(CarInfo[car][cText]) >= 3) return Garage_Err(playerid, "Acest vehicul este deja unul VIP!");
			if(pp < GARAGE_PP_VIP) return Garage_Err(playerid, "Nu ai destule Premium Points.");
			if(GetPlayerVehicleID(playerid) != veh) return Garage_Err(playerid, "Eroare: Nu te afli in acel vehicul!"); 
			if(!confirmed) return Garage_Ask(playerid, slot, action, arg, "Upgrade to VIP Vehicle", "Are you sure you want to do this?\nIt costs 300 Premium Points.", "Upgrade - 300 PP", 2);
			
			PlayerInfo[playerid][pPremiumPoints] -= 300;
			UpdateVar(playerid, "GoldPoints", PlayerInfo[playerid][pPremiumPoints]);
			format(gString, sizeof(gString), "%s si-a upgradat vehiculul %s[id: %d] la unul VIP pentru 300 Premium Points.", GetName(playerid), aVehicleNames[CarInfo[car][cModel]-400], car);
			InsertLog(playerid, gString, LOG_SHOP);

			_query("UPDATE `cars` SET `Text`='%s' WHERE `ID`='%d'", GetName(playerid), CarInfo[car][cID]);
			CarInfo[car][cVipPos][0] = CarInfo[car][cVipPos][1] = CarInfo[car][cVipPos][2] = CarInfo[car][cVipPos][3] = CarInfo[car][cVipPos][4] = CarInfo[car][cVipPos][5] = 0.0;

			format(CarInfo[car][cText], 32, GetName(playerid));
			attach_vip_text(car);
			finishAchievement(playerid, 28);
			return Garage_Ok(playerid, "Felicitari! Ti-ai upgradat vehiculul la unul VIP.");
		}

		case GACT_RAINBOW: {
			if(!veh) return Garage_Err(playerid, "Eroare: Vehiculul tau nu este spawnat!");
			if(CarInfo[car][cRainBow]) return Garage_Err(playerid, "Acest vehicul este deja unul RainBow!");
			if(pp < GARAGE_PP_RAINBOW) return Garage_Err(playerid, "Nu ai destule Premium Points.");
			if(!confirmed) return Garage_Ask(playerid, slot, action, arg, "Upgrade to Rainbow", "Are you sure you want to do this?\nIt costs 300 Premium Points.", "Upgrade - 300 PP", 2);
			
			PlayerInfo[playerid][pPremiumPoints] -= 300;
			UpdateVar(playerid, "GoldPoints", PlayerInfo[playerid][pPremiumPoints]);
			finishAchievement(playerid, 29);
			CarInfo[car][cRainBow] = true;

			format(gString, sizeof(gString), "%s si-a upgradat vehiculul %s[id: %d] la unul RainBow pentru 200 Premium Points.", GetName(playerid), aVehicleNames[CarInfo[car][cModel]-400], CarInfo[car][cID]);
			InsertLog(playerid, gString, LOG_SHOP);

			_query("UPDATE `cars` SET `RainBow`='%d' WHERE `ID`='%d'", CarInfo[car][cRainBow], CarInfo[car][cID]);
			return Garage_Ok(playerid, "Felicitari! Ti-ai upgradat vehiculul la unul Rainbow.");
		}

		case GACT_RESETKM: {
			if(!veh) return Garage_Err(playerid, "Eroare: Vehiculul tau nu este spawnat!");
			if(pp < GARAGE_PP_RESETKM) return Garage_Err(playerid, "Nu ai destule Premium Points.");
			if(!confirmed) return Garage_Ask(playerid, slot, action, arg, "Reset KM", "Are you sure you want to reset the odometer of this vehicle?\nIt costs 200 Premium Points.", "Reset - 200 PP", 2);

			PlayerInfo[playerid][pPremiumPoints] -= 200; CarInfo[car][KM] = 0.0;
			UpdateVar(playerid, "GoldPoints", PlayerInfo[playerid][pPremiumPoints]);
			
			_query("UPDATE `cars` SET `KM`='0' WHERE `ID`='%d'", CarInfo[car][cID]);
			return Garage_Ok(playerid, "Felicitari! Ti-ai resetat kilometrii vehiculului.");
		}

		case GACT_RESETDAYS: {
			if(!veh) return Garage_Err(playerid, "Eroare: Vehiculul tau nu este spawnat!");
			if(pp < GARAGE_PP_RESETDAYS) return Garage_Err(playerid, "Nu ai destule Premium Points.");
			if(!confirmed) return Garage_Ask(playerid, slot, action, arg, "Reset days", "Are you sure you want to reset the days of this vehicle?\nIt costs 100 Premium Points.", "Reset - 100 PP", 2);


			PlayerInfo[playerid][pPremiumPoints] -= 100;
			UpdateVar(playerid, "GoldPoints", PlayerInfo[playerid][pPremiumPoints]);
			CarInfo[car][Dayss] = 0;
			mysql_format(SQL, gQuery, 128, "UPDATE `cars` SET `Days`='0' WHERE `ID`='%d'", CarInfo[car][cID]);
			mysql_tquery(SQL, gQuery);
			SendClientMessage(playerid, COLOR_WHITE, "{47A033}(SHOP INFO){D7FFB3} Felicitari! Ti-ai resetat zilele vehiculului personal. (-100 puncte premium)");
			return GARAGE_R_OK;
		}

		case GACT_REMOVETUNING: {
			if(!veh) return Garage_Err(playerid, "Eroare: Vehiculul tau nu este spawnat!");
			if(!confirmed) return Garage_Ask(playerid, slot, action, arg, "Remove tuning", "All installed components and the paintjob will be removed.\nThis cannot be undone.", "Remove tuning", 1);
			for(new i = 0; i < 14; i++) {
				if(CarInfo[car][cMod][i] != 0) RemoveVehicleComponent(car, CarInfo[car][cMod][i]);
				CarInfo[car][cMod][i] = 0;
			}
			CarInfo[car][paintjob] = 3;
			ChangeVehiclePaintjob(CarInfo[car][Spawned], 3);

			_query("UPDATE `cars` SET `Mods`='%i %i %i %i %i %i %i %i %i %i %i %i %i %i' WHERE `ID`='%i'", CarInfo[car][cMod][0], CarInfo[car][cMod][1], CarInfo[car][cMod][2], CarInfo[car][cMod][3], CarInfo[car][cMod][4], CarInfo[car][cMod][5], CarInfo[car][cMod][6], CarInfo[car][cMod][7], CarInfo[car][cMod][8], CarInfo[car][cMod][9], CarInfo[car][cMod][10], CarInfo[car][cMod][11], CarInfo[car][cMod][12], CarInfo[car][cMod][13], CarInfo[car][cID]);	
			_query("UPDATE `cars` SET `paintjob`='%d' WHERE `ID`='%d'",CarInfo[car][paintjob], CarInfo[car][cID]);
			SendClientMessage(playerid, COLOR_YELLOW, "Tunning was successfully deleted!");		
			return GARAGE_R_OK;
		}

		case GACT_PAYFINE: {
			if(!CarInfo[car][Confiscated]) return Garage_Err(playerid, "Acest vehicul nu este confiscat.");
			if(GetPlayerCash(playerid) < GARAGE_PRICE_FINE) return Garage_Err(playerid, "Eroare: Ai nevoie de $5.000.000 pentru a plati amenda!");
			if(!confirmed) return Garage_Ask(playerid, slot, action, arg, "Pay the fine", "Are you sure you want to pay the fine for illegal parking? ($5,000,000)\nIf you think it was unjustified, ask for proof on the forum.", "Pay $5,000,000", 1);

			GivePlayerCash(playerid, -5000000);
			CarInfo[car][Confiscated] = false;
	
			_query("UPDATE `cars` SET `Confiscated`='0' WHERE `ID`='%d'", CarInfo[car][cID]);
			SendFactionMessage(8, COLOR_LIGHTBLUE, "TTC Dispatch: %s (%d) si-a platit amenda in valoare de $5.000.000 pentru a-si recupera vehiculul (dbid:%d)", GetName(playerid), playerid, CarInfo[car][cID]);
			SendClientMessage(playerid, COLOR_MONEY, "Ai platit amenda de $5.000.000 pentru parcarea neregulamentara. Ai grija data viitoare!");
			return GARAGE_R_OK;
		}
	}
	return Garage_Err(playerid, "Eroare: Actiune necunoscuta.");
}

static Garage_Handle(playerid, slot, action, arg, bool:confirmed) {
	new r = Garage_Run(playerid, slot, action, arg, confirmed);
	if(r == GARAGE_R_ASK) return 1;                       // waiting for the player's answer
	if(!GarageOpen[playerid]) return 1;

	if(!Iter_Count(MyVehicle<playerid>))                    Garage_Close(playerid);       // last vehicle sold
	else if(action == GACT_SELL && r == GARAGE_R_OK)        Garage_Send(playerid, -1);    // the list changed
	else if(Garage_Resolve(playerid, slot) != -1)           Garage_Update(playerid, slot);// normal case: 1 event
	else                                                    Garage_Send(playerid, -1);    // out of sync -> resend all
	return 1;
}

/* ---------------------------------------------------------------------------
   CALLBACKS FROM THE BROWSER
   The plugin passes: playerid, browserid, then the registered arguments.
   --------------------------------------------------------------------------- */
public OnGarageReady(playerid, browserid) {
	if(GarageOpen[playerid]) Garage_Send(playerid);
	return 1;
}

public OnGarageClose(playerid, browserid) {
	Garage_Close(playerid);
	return 1;
}

public OnGarageAction(playerid, browserid, slot, action, arg) {
	if(!GarageOpen[playerid]) return 1;
	new now = GetTickCount();
	if(now - GarageLastTick[playerid] < GARAGE_ACTION_COOLDOWN) return 1;
	GarageLastTick[playerid] = now;
	GaragePending[playerid][0] = -1;                       // a new action cancels any open question
	Garage_Handle(playerid, slot, action, arg, false);
	return 1;
}

public OnGarageConfirm(playerid, browserid, bool:yes) {
	if(!GarageOpen[playerid]) return 1;
	new action = GaragePending[playerid][0], slot = GaragePending[playerid][1], arg = GaragePending[playerid][2];
	GaragePending[playerid][0] = -1;
	if(!yes || action == -1) return 1;                     // only answers a question the server asked
	Garage_Handle(playerid, slot, action, arg, true);
	return 1;
}
