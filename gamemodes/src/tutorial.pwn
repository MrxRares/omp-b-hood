#include <YSI_Coding\y_hooks>

/* --- DEFINES --- */
#define MAX_TUTORIAL_STEP 			(22)
#define MAX_TUTORIAL_TYPE 			(5)

#define MAX_TUTORIAL_ACTORS 		(37)
#define MAX_HOUSE_ACTORS 			(4)
#define MAX_PETRECERE_ACTORS 		(13)
#define MAX_PETRECERE_BODYGUARDS 	(4)
#define MAX_FINAL_ACTORS 			(3)


/* --- VARIABLES --- */
new 

	bool:in_tutorial[MAX_PLAYERS],
	bool:enter_vehicle[MAX_PLAYERS],
	bool:have_actors_killed[MAX_PLAYERS],
	bool:need_arms[MAX_PLAYERS],
	bool:need_get_arms[MAX_PLAYERS],
	bool:entered_cp[MAX_PLAYERS],

	need_bodyguard[MAX_PLAYERS],
	tutorial_vehicle[MAX_PLAYERS][MAX_TUTORIAL_STEP][MAX_TUTORIAL_TYPE],
	tutorial_actors[MAX_PLAYERS][MAX_TUTORIAL_ACTORS][MAX_TUTORIAL_TYPE],
	tutorial_bodyguards[MAX_PLAYERS][MAX_PETRECERE_BODYGUARDS],
	final_actors[MAX_PLAYERS][MAX_FINAL_ACTORS],
	killed_actors[MAX_PLAYERS],
	in_step[MAX_PLAYERS],

	tutorial_timer[MAX_PLAYERS][MAX_TUTORIAL_STEP],

	Float:actor_final_pos[][] = {{1481.6106,1667.2493,10.8125,89.3543}, {1481.5466,1669.5842,10.8125,89.1037}, {1480.4036,1668.3191,10.8125,89.3543}},
	Float:actors_house_pos[][] = {{91.8374,1336.3243,1083.8594,3.3957}, {92.9957,1337.5099,1083.8594,89.0618}, {91.7867,1338.6116,1083.8594,178.2999}, {90.5845,1337.4296,1083.8594,270.9222}},
	Float:actors_petrecere_pos[][] = {{2568.4487,2397.2078,17.8203,266.8611}, {2569.5000,2397.2715,17.8203,86.8611}, {2581.2263,2402.7788,17.8203,209.3953}, {2582.4551,2400.8657,17.8203,29.3952}, {2593.2632,2396.1528,17.8203,151.0521}, {2589.5874,2384.3350,17.8203,51.8498}, {2581.6575,2371.8611,17.8203,132.0638}, {2579.8738,2370.4116,17.8203,312.0638}, {2570.9619,2370.6499,17.8203,328.6903}, {2573.3596,2381.8105,17.8145,287.3928}, {2564.3052,2388.0171,17.8203,270.9346}, {2563.7854,2389.2507,17.8203,273.0026}, {2563.6313,2386.3196,17.8203,272.8146}},
	Float:actors_bodyguard_pos[][] = {{2595.4563,2378.1655,17.8203,43.2440}, {2607.6060,2387.5383,17.8203,29.1868}, {2622.5444,2413.3154,17.8203,181.4053}, {2610.3015,2414.2126,17.8203,183.5986}},
	Float:actor_pos_x[MAX_PLAYERS], Float:actor_pos_y[MAX_PLAYERS], Float:actor_pos_z[MAX_PLAYERS],
	actors_house_model[][] = {{241}, {250}, {292}, {115}},
	actor_final_model[][] = {{163}, {163}, {149}},
	actors_bodyguard_model[][] = {{163}, {163}, {163}, {163}},
	actors_petrecere_model[][] = {{11}, {18}, {28}, {30}, {37}, {47}, {48}, {55}, {56}, {63}, {149}, {163}, {163}};


/* --- ENUMS --- */
enum {TYPE_TUTORIAL_PRESENTS, TYPE_TUTORIAL_HOUSE, TYPE_TUTORIAL_PETRECERE, TYPE_TUTORIAL_BODYGUARDS, TYPE_TUTORIAL_DEATH};
enum {STEP_PRESENTS_1, STEP_PRESENTS_2, STEP_PRESENTS_3, STEP_PRESENTS_4, STEP_PRESENTS_5, STEP_PRESENTS_6, STEP_PRESENTS_7};
enum {STEP_HOUSE_1, STEP_HOUSE_2, STEP_HOUSE_3, STEP_HOUSE_4, STEP_HOUSE_5, STEP_HOUSE_6, STEP_HOUSE_7, STEP_HOUSE_8, STEP_HOUSE_9};
enum {STEP_PETRECERE_1, STEP_PETRECERE_2};
enum {STEP_DEATH_1};
enum {STEP_FINAL_1, STEP_FINAL_2, STEP_FINAL_3};
enum {BODYGUARD_1, BODYGUARD_2, BODYGUARD_3, BODYGUARD_4, BODYGUARD_5, BODYGUARD_6}



/* --- TIMERS --- */

redist::timer_tutorial(playerid, step, type) {
	switch(type) {

		case TYPE_TUTORIAL_PRESENTS: {

			switch(step) {

				case STEP_PRESENTS_1: start_tutorial(playerid, STEP_PRESENTS_2, TYPE_TUTORIAL_PRESENTS);
				case STEP_PRESENTS_2: start_tutorial(playerid, STEP_PRESENTS_3, TYPE_TUTORIAL_PRESENTS);
				case STEP_PRESENTS_3: start_tutorial(playerid, STEP_PRESENTS_4, TYPE_TUTORIAL_PRESENTS);
				case STEP_PRESENTS_4: start_tutorial(playerid, STEP_PRESENTS_5, TYPE_TUTORIAL_PRESENTS);
				case STEP_PRESENTS_5: start_tutorial(playerid, STEP_PRESENTS_6, TYPE_TUTORIAL_PRESENTS);
				case STEP_PRESENTS_6: start_tutorial(playerid, STEP_PRESENTS_7, TYPE_TUTORIAL_PRESENTS);
				case STEP_PRESENTS_7: start_tutorial(playerid, STEP_HOUSE_1, TYPE_TUTORIAL_HOUSE);
			}
		}
		case TYPE_TUTORIAL_HOUSE: {

			switch(step) {

				case STEP_HOUSE_3: start_tutorial(playerid, STEP_HOUSE_4, TYPE_TUTORIAL_HOUSE);
				case STEP_HOUSE_4: start_tutorial(playerid, STEP_HOUSE_5, TYPE_TUTORIAL_HOUSE);
				case STEP_HOUSE_5: start_tutorial(playerid, STEP_HOUSE_6, TYPE_TUTORIAL_HOUSE);
				case STEP_HOUSE_6: start_tutorial(playerid, STEP_HOUSE_7, TYPE_TUTORIAL_HOUSE);
				case STEP_HOUSE_7: start_tutorial(playerid, STEP_HOUSE_8, TYPE_TUTORIAL_HOUSE);
				case STEP_HOUSE_8: start_tutorial(playerid, STEP_HOUSE_9, TYPE_TUTORIAL_HOUSE);
				case STEP_HOUSE_9: start_tutorial(playerid, STEP_PETRECERE_1, TYPE_TUTORIAL_PETRECERE);
			}
		}
		case TYPE_TUTORIAL_PETRECERE: {

			switch(step) {

				case STEP_PETRECERE_1: {

					SetCameraBehindPlayer(playerid); TogglePlayerControllable(playerid, true); CP[playerid] = 0; DisablePlayerCheckpoint(playerid); need_arms[playerid] = true;
					PlayerTextDrawSetString(playerid, TutorialPTD, "~r~HINT:~n~~w~Mergi si ia arma din elicopter pentru a omora cei 4 bodyguardzi."); PlayerTextDrawShow(playerid, TutorialPTD);
				}
			}
		}
		case TYPE_TUTORIAL_DEATH: {

			switch(step) {

				case STEP_DEATH_1: {
					switch(in_step[playerid]) {

						case 1: start_tutorial(playerid, STEP_HOUSE_1, TYPE_TUTORIAL_HOUSE);
						case 2: start_tutorial(playerid, STEP_PETRECERE_1, TYPE_TUTORIAL_PETRECERE);
					}
				}
			}
		}
	}
	return true;
}

/* --- FUNCTIONS --- */
redist::start_tutorial(const playerid, const step, const type) {
	new engine, lights, alarm, doors, bonnet, boot, objective;
	switch(type) {

		case TYPE_TUTORIAL_PRESENTS: {

			switch(step) {

				case STEP_PRESENTS_1: {
					show_camera_tutorial(playerid, STEP_PRESENTS_1, TYPE_TUTORIAL_PRESENTS); PlayerInfo[playerid][pIntro] = 1;  in_tutorial[playerid] = true;
					SetPlayerVirtualWorld(playerid, playerid+1); 
					gString[0] = (EOS);
					format(gString, sizeof gString, "%s[ID: %d] a intrat in tutorialul de prezentare.", GetName(playerid), playerid);
					SendAdminMessage(COLOR_RED, 1, gString);
					tutorial_timer[playerid][STEP_PRESENTS_1] = SetTimerEx("timer_tutorial", 13000, false, "idd", playerid, STEP_PRESENTS_1, TYPE_TUTORIAL_PRESENTS);
					PlayerTextDrawSetString(playerid, TutorialPTD, "~r~INTRO:~w~~n~Salutare si bun venit pe ~r~comunitatea~w~ noastra, pentru inceput iti vom oferi o scurta prezentare a orasului nostru cat si al serverului de samp."); PlayerTextDrawShow(playerid, TutorialPTD);
				}
				case STEP_PRESENTS_2: {
					KillTimer(tutorial_timer[playerid][STEP_PRESENTS_1]);
					show_camera_tutorial(playerid, STEP_PRESENTS_2, TYPE_TUTORIAL_PRESENTS);
					tutorial_timer[playerid][STEP_PRESENTS_2] = SetTimerEx("timer_tutorial", 13000, false, "idd", playerid, STEP_PRESENTS_2, TYPE_TUTORIAL_PRESENTS);
					PlayerTextDrawSetString(playerid, TutorialPTD, "~r~BANK:~w~~n~In aceasta zona este banca principala din orasul ~r~Los Santos~w~ unde puteti face diferite transferuri, unde puteti retrage / depune o suma de bani in contul tau. Este foarte important atunci cand ai prea multi bani cash sa-i introduci in contul tau bancar."); PlayerTextDrawShow(playerid, TutorialPTD);
				}
				case STEP_PRESENTS_3: {
					KillTimer(tutorial_timer[playerid][STEP_PRESENTS_2]);
					show_camera_tutorial(playerid, STEP_PRESENTS_3, TYPE_TUTORIAL_PRESENTS);
					tutorial_timer[playerid][STEP_PRESENTS_3] = SetTimerEx("timer_tutorial", 13000, false, "idd", playerid, STEP_PRESENTS_3, TYPE_TUTORIAL_PRESENTS);
					PlayerTextDrawSetString(playerid, TutorialPTD, "~r~GUNSHOP:~w~~n~In aceasta zona este magazinul pentru ~r~Arme~w~, un magazin foarte important pentru cei experimentati in arme. Este important sa ai licenta de port arma pentru a cumpara din acest magazin."); PlayerTextDrawShow(playerid, TutorialPTD);
				}
				case STEP_PRESENTS_4: {
					KillTimer(tutorial_timer[playerid][STEP_PRESENTS_3]);
					show_camera_tutorial(playerid, STEP_PRESENTS_4, TYPE_TUTORIAL_PRESENTS);
					tutorial_timer[playerid][STEP_PRESENTS_4] = SetTimerEx("timer_tutorial", 13000, false, "idd", playerid, STEP_PRESENTS_4, TYPE_TUTORIAL_PRESENTS);
					PlayerTextDrawSetString(playerid, TutorialPTD, "~r~CNN:~w~~n~CNN-ul este o zona importanta atunci cand doresti sa pui un ~r~Anunt~w~ pe server. Acest anunt il vor vedea toti jucatorii pe server, deaceea recomandam sa nu postezi anunturi ce nu tin de afaceri / recrutari sau alte informatii despre server."); PlayerTextDrawShow(playerid, TutorialPTD);
				}
				case STEP_PRESENTS_5: {
					KillTimer(tutorial_timer[playerid][STEP_PRESENTS_4]);
					show_camera_tutorial(playerid, STEP_PRESENTS_5, TYPE_TUTORIAL_PRESENTS);
					tutorial_timer[playerid][STEP_PRESENTS_5] = SetTimerEx("timer_tutorial", 13000, false, "idd", playerid, STEP_PRESENTS_5, TYPE_TUTORIAL_PRESENTS);
					PlayerTextDrawSetString(playerid, TutorialPTD, "~r~LSPD:~w~~n~Politia los santos este pe urmele fiecarui ~r~infractor~w~, recomandam evitarea de a purta droguri / de a merge neregulamentar sau de a face diferite crime, deoarece risti sa intri foarte usor la puscarie."); PlayerTextDrawShow(playerid, TutorialPTD);
				}
				case STEP_PRESENTS_6: {
					KillTimer(tutorial_timer[playerid][STEP_PRESENTS_5]);
					show_camera_tutorial(playerid, STEP_PRESENTS_6, TYPE_TUTORIAL_PRESENTS);
					tutorial_timer[playerid][STEP_PRESENTS_6] = SetTimerEx("timer_tutorial", 13000, false, "idd", playerid, STEP_PRESENTS_6, TYPE_TUTORIAL_PRESENTS);
					PlayerTextDrawSetString(playerid, TutorialPTD, "~r~JOBS:~w~~n~Toate joburile de pe server sunt profitabile cu exceptia jobului ~r~Detective~w~. Recomandam sa faci job cat mai mult daca doresti sa-ti achizitionezi bunurile dorite de la jucatori sau de la server."); PlayerTextDrawShow(playerid, TutorialPTD);
				}
				case STEP_PRESENTS_7: {
					KillTimer(tutorial_timer[playerid][STEP_PRESENTS_6]);
					show_camera_tutorial(playerid, STEP_PRESENTS_7, TYPE_TUTORIAL_PRESENTS);
					SetTimerEx("timer_tutorial", 13000, false, "idd", playerid, STEP_PRESENTS_7, TYPE_TUTORIAL_PRESENTS);
					PlayerTextDrawSetString(playerid, TutorialPTD, "~r~FINAL:~w~~n~Am ajuns la finalul acestui tutorial, in continuare urmeaza un tutorial practic pentru acomodarea usoara pe server si totodata pentru a te informa cum este la noi in oras."); PlayerTextDrawShow(playerid, TutorialPTD);
				}
			}
		}
		case TYPE_TUTORIAL_HOUSE: {

			switch(step) {

				case STEP_HOUSE_1: {
					CP[playerid] = 0; DisablePlayerCheckpoint(playerid);
					PlayerTextDrawHide(playerid, TutorialPTD);
					KillTimer(tutorial_timer[playerid][STEP_PRESENTS_7]);
					KillTimer(tutorial_timer[playerid][STEP_DEATH_1]);
					TogglePlayerSpectating(playerid, false); PlayerInfo[playerid][pIntro] = 2; in_tutorial[playerid] = true; SpawnPlayer(playerid); SetPlayerVirtualWorld(playerid, playerid+1); for(new i=0;i<30;i++) SendClientMessage(playerid,-1,"");
					if(!IsValidVehicle(tutorial_vehicle[playerid][STEP_HOUSE_1][TYPE_TUTORIAL_HOUSE])) tutorial_vehicle[playerid][STEP_HOUSE_1][TYPE_TUTORIAL_HOUSE] = CreateVehicleEx(522, -1990.8778,137.8139,27.5391,91.1286, 1, 1, -1); GetVehicleParamsEx(tutorial_vehicle[playerid][STEP_HOUSE_1][TYPE_TUTORIAL_HOUSE], engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleHealth(tutorial_vehicle[playerid][STEP_HOUSE_1][TYPE_TUTORIAL_HOUSE], 9000.0);
					SetVehicleVirtualWorld(tutorial_vehicle[playerid][STEP_HOUSE_1][TYPE_TUTORIAL_HOUSE], playerid+1); SetVehicleParamsEx(tutorial_vehicle[playerid][STEP_HOUSE_1][TYPE_TUTORIAL_HOUSE], VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, VEHICLE_PARAMS_ON);
					SendClientMessage(playerid, COLOR_SERVER, "Mission Step (1/3):"); in_tutorial[playerid] = true; in_step[playerid] = 1;
					SendClientMessage(playerid, -1, "");
					va_SendClientMessage(playerid, -1, "{ff0000}> {f9f9f9}Salutare {ff0000}%s{f9f9f9}, bine ai venit in noul tau oras natal.", GetName(playerid));
					SendClientMessage(playerid, -1, "{ff0000}> {f9f9f9}Pentru acomodarea in acest oras, staff-ul comunitatii noastre te asteapta la casa lor din apropriere.");
					SendClientMessage(playerid, -1, "{ff0000}> {f9f9f9}Pentru a ajunge acolo ti-a fost adus un {ff0000}NRG-500{f9f9f9} in fata pentru deplasarea la locatia respectiva.");
				}
				case STEP_HOUSE_2: {
					CP[playerid] = 0; DisablePlayerCheckpoint(playerid);
					if(enter_vehicle[playerid]) return true; enter_vehicle[playerid] = true;
					SetPlayerCheckpoint(playerid, -2374.7781,-232.8673,42.7816, 1.5); CP[playerid] = 9993;
					
				}
				case STEP_HOUSE_3: {
					DestroyVehicle(tutorial_vehicle[playerid][STEP_HOUSE_1][TYPE_TUTORIAL_HOUSE], "asd");
					for(new i=0;i<30;i++) SendClientMessage(playerid,-1,""); 
					TogglePlayerControllable(playerid, false);	
					SetPlayerVirtualWorld(playerid, playerid+1); 
					SetPlayerInterior(playerid, 9); 
					CP[playerid] = 0; 
					DisablePlayerCheckpoint(playerid);
					SetPlayerPosEx(playerid, 85.6513,1330.9709,1083.8594); show_camera_tutorial(playerid, STEP_HOUSE_3, TYPE_TUTORIAL_HOUSE);
					for(new i; i < MAX_HOUSE_ACTORS; i++) if(!IsValidDynamicActor(tutorial_actors[playerid][i][TYPE_TUTORIAL_HOUSE])) tutorial_actors[playerid][i][TYPE_TUTORIAL_HOUSE] = CreateDynamicActor(actors_house_model[i][0], actors_house_pos[i][0], actors_house_pos[i][1], actors_house_pos[i][2], actors_house_pos[i][3], 1, 100.0, playerid+1, 9, -1, STREAMER_ACTOR_SD);
					for(new i; i < MAX_HOUSE_ACTORS; i++) ApplyDynamicActorAnimation(tutorial_actors[playerid][i][TYPE_TUTORIAL_HOUSE], "PED","SEAT_idle", 4.0, 1, 0, 0, 0, 0);
					for(new i; i < MAX_HOUSE_ACTORS; i++) ApplyDynamicActorAnimation(tutorial_actors[playerid][i][TYPE_TUTORIAL_HOUSE], "MISC","Seat_talk_01", 4.1, 1, 0, 0, 0, 0);
					tutorial_timer[playerid][STEP_HOUSE_3] = SetTimerEx("timer_tutorial", 11000, false, "idd", playerid, STEP_HOUSE_3, TYPE_TUTORIAL_HOUSE);
				}
				case STEP_HOUSE_4: {
					KillTimer(tutorial_timer[playerid][STEP_HOUSE_3]);
					show_camera_tutorial(playerid, STEP_HOUSE_4, TYPE_TUTORIAL_HOUSE); PlayerTextDrawSetString(playerid, TutorialPTD, "~r~FusYan:~w~~n~Salutare, ma gandesc ca ai venit aici cu un scop, de a te acomoda in noul tau oras?"); PlayerTextDrawShow(playerid, TutorialPTD);
					tutorial_timer[playerid][STEP_HOUSE_4] = SetTimerEx("timer_tutorial", 11000, false, "idd", playerid, STEP_HOUSE_4, TYPE_TUTORIAL_HOUSE);
				}
				case STEP_HOUSE_5: {
					gString[0] = (EOS);
					KillTimer(tutorial_timer[playerid][STEP_HOUSE_4]);
					format(gString, sizeof gString, "~r~%s:~w~~n~Salut, da am fost trimis de la aeroport sa ajung aici. Sunt nou in acest oras si as dori sa lucrez pentru voi pentru a ma acomoda in noul meu oras.", GetName(playerid));
					show_camera_tutorial(playerid, STEP_HOUSE_5, TYPE_TUTORIAL_HOUSE); PlayerTextDrawSetString(playerid, TutorialPTD, gString); PlayerTextDrawShow(playerid, TutorialPTD);
					tutorial_timer[playerid][STEP_HOUSE_5] = SetTimerEx("timer_tutorial", 11000, false, "idd", playerid, STEP_HOUSE_5, TYPE_TUTORIAL_HOUSE);
				}
				case STEP_HOUSE_6: {
					KillTimer(tutorial_timer[playerid][STEP_HOUSE_5]);
					show_camera_tutorial(playerid, STEP_HOUSE_6, TYPE_TUTORIAL_HOUSE); PlayerTextDrawSetString(playerid, TutorialPTD, "~r~K1ng:~w~~n~Bun, deci sa inteleg ca ai mai tras cu arma? Ai experienta in ceea ce tine de arme / mafie?"); PlayerTextDrawShow(playerid, TutorialPTD);
					tutorial_timer[playerid][STEP_HOUSE_6] = SetTimerEx("timer_tutorial", 11000, false, "idd", playerid, STEP_HOUSE_6, TYPE_TUTORIAL_HOUSE);
				}
				case STEP_HOUSE_7: {
					gString[0] = (EOS);
					KillTimer(tutorial_timer[playerid][STEP_HOUSE_6]);
					format(gString, sizeof gString, "~r~%s:~w~~n~Da, de unde vin eu acolo se umbla des cu arme. In special pot spune ca ma descurc cu un M4 sau chiar cu un Rifle.", GetName(playerid));
					show_camera_tutorial(playerid, STEP_HOUSE_5, TYPE_TUTORIAL_HOUSE); PlayerTextDrawSetString(playerid, TutorialPTD, gString); PlayerTextDrawShow(playerid, TutorialPTD);
					tutorial_timer[playerid][STEP_HOUSE_7] = SetTimerEx("timer_tutorial", 11000, false, "idd", playerid, STEP_HOUSE_7, TYPE_TUTORIAL_HOUSE);
				}
				case STEP_HOUSE_8: {
					KillTimer(tutorial_timer[playerid][STEP_HOUSE_7]);
					show_camera_tutorial(playerid, STEP_HOUSE_7, TYPE_TUTORIAL_HOUSE); PlayerTextDrawSetString(playerid, TutorialPTD, "~r~Adrian_:~w~~n~Da, te pricepi cu un M4? Foarte bine, iti vom da un elicopter unde trebuie sa mergi sa-l asasinezi pe cel ce ne ameninta orasul. Ai grija deoarece pasnici lui sunt foarte bine antrenati."); PlayerTextDrawShow(playerid, TutorialPTD);
					tutorial_timer[playerid][STEP_HOUSE_8] = SetTimerEx("timer_tutorial", 11000, false, "idd", playerid, STEP_HOUSE_8, TYPE_TUTORIAL_HOUSE);
				}
				case STEP_HOUSE_9: {
					gString[0] = (EOS);
					KillTimer(tutorial_timer[playerid][STEP_HOUSE_8]);
					format(gString, sizeof gString, "~r~%s:~w~~n~Foarte bine, atunci haideti sa nu mai stam degeaba si sa incepem treaba.", GetName(playerid));
					show_camera_tutorial(playerid, STEP_HOUSE_5, TYPE_TUTORIAL_HOUSE); PlayerTextDrawSetString(playerid, TutorialPTD, gString); PlayerTextDrawShow(playerid, TutorialPTD);
					tutorial_timer[playerid][STEP_HOUSE_9] = SetTimerEx("timer_tutorial", 11000, false, "idd", playerid, STEP_HOUSE_9, TYPE_TUTORIAL_HOUSE);
				}
			}
		}
		case TYPE_TUTORIAL_PETRECERE: {

			switch(step) {

				case STEP_PETRECERE_1: {
					CP[playerid] = 0; DisablePlayerCheckpoint(playerid);
					KillTimer(tutorial_timer[playerid][STEP_DEATH_1]);
					SetPlayerCheckpoint(playerid, 2617.3167,2442.7329,14.8672, 1.5); 
					CP[playerid] = 9994;
					SetPlayerVirtualWorld(playerid, playerid+1); KillTimer(tutorial_timer[playerid][STEP_HOUSE_9]);
					PlayerTextDrawHide(playerid, TutorialPTD); SetCameraBehindPlayer(playerid); SetPlayerInterior(playerid, 0);
					for(new i; i < MAX_HOUSE_ACTORS; i++) DestroyDynamicActor(tutorial_actors[playerid][i][TYPE_TUTORIAL_HOUSE]);
					if(!IsValidVehicle(tutorial_vehicle[playerid][STEP_PETRECERE_1][TYPE_TUTORIAL_PETRECERE])) tutorial_vehicle[playerid][STEP_PETRECERE_1][TYPE_TUTORIAL_PETRECERE] = CreateVehicleEx(487, -2341.7766,-258.8198,43.2679,275.7662, 0, 0, -1); SetVehicleVirtualWorld(tutorial_vehicle[playerid][STEP_PETRECERE_1][TYPE_TUTORIAL_PETRECERE], playerid+1); PutPlayerInVehicle(playerid, tutorial_vehicle[playerid][STEP_PETRECERE_1][TYPE_TUTORIAL_PETRECERE], 0);
					SendClientMessage(playerid, COLOR_SERVER, "Mission Step (2/3):");
					SendClientMessage(playerid, -1, "{ff0000}> {f9f9f9}Mergi la checkpoint-ul marcat pe mini map pentru a ajunge la {ff0000}Elian{f9f9f9}."); TogglePlayerControllable(playerid, true); in_step[playerid] = 2;
					for(new i; i < MAX_PETRECERE_ACTORS; i++) if(!IsValidDynamicActor(tutorial_actors[playerid][i][TYPE_TUTORIAL_PETRECERE])) tutorial_actors[playerid][i][TYPE_TUTORIAL_PETRECERE] = CreateDynamicActor(actors_petrecere_model[i][0], actors_petrecere_pos[i][0], actors_petrecere_pos[i][1], actors_petrecere_pos[i][2], actors_petrecere_pos[i][3], 1, 100.0, playerid+1, 0, -1, STREAMER_ACTOR_SD);
				}
			}
		}
	}
	return true;
}
redist::show_camera_tutorial(const playerid, const step, const type) {
	switch(type) {

		case TYPE_TUTORIAL_PRESENTS: {

			switch(step) {
				case STEP_PRESENTS_1: {
					InterpolateCameraPos(playerid, -2005.645874, 167.361404, 44.152355, -2004.726562, 466.132568, 50.882648, 10000);
					InterpolateCameraLookAt(playerid, -2005.597900, 172.360168, 44.252346, -2004.711303, 471.131317, 50.993576, 10000);
				}
				case STEP_PRESENTS_2: {
					InterpolateCameraPos(playerid, -1527.280761, 892.054321, 16.285514, -1527.232177, 926.009460, 14.843111, 10000);
					InterpolateCameraLookAt(playerid, -1523.503173, 895.194091, 15.351963, -1522.379150, 925.091064, 14.065807, 10000);
				}
				case STEP_PRESENTS_3: {
					InterpolateCameraPos(playerid, -2141.696777, 148.821609, 44.885021, -2141.379394, 127.303512, 42.396026, 10000);
					InterpolateCameraLookAt(playerid, -2145.468017, 146.086395, 43.069660, -2146.083007, 127.973205, 40.838031, 10000);
				}
				case STEP_PRESENTS_4: {
					InterpolateCameraPos(playerid, -2023.432495, 463.949401, 41.748260, -2039.325561, 475.381622, 39.597671, 10000);
					InterpolateCameraLookAt(playerid, -2028.271118, 463.742553, 40.505184, -2042.751708, 471.864501, 38.653373, 10000);	
				}
				case STEP_PRESENTS_5: {
					InterpolateCameraPos(playerid, -1578.475219, 740.510864, 18.282110, -1619.708251, 738.788085, 17.675697, 10000);
					InterpolateCameraLookAt(playerid, -1581.727539, 736.779541, 17.575113, -1617.369750, 734.398376, 17.164094, 10000);
				}
				case STEP_PRESENTS_6: {
					InterpolateCameraPos(playerid, -2928.493652, 451.421508, 17.373022, -2988.036865, 456.171142, 14.691808, 10000);
					InterpolateCameraLookAt(playerid, -2931.036865, 455.456298, 15.872302, -2985.327148, 460.176849, 13.422267, 10000);
				}
				case STEP_PRESENTS_7: {
					InterpolateCameraPos(playerid, -1998.275390, 124.124694, 33.736789, -1995.122192, 151.029800, 31.930574, 10000);
					InterpolateCameraLookAt(playerid, -1994.174194, 126.679618, 32.451385, -1991.629028, 147.637908, 30.793729, 10000);
				}
			}
		}
		case TYPE_TUTORIAL_HOUSE: {

			switch(step) {

				case STEP_HOUSE_3: {
					InterpolateCameraPos(playerid, 87.982276, 1341.617065, 1086.757568, 87.386444, 1332.819335, 1086.070678, 10000);
					InterpolateCameraLookAt(playerid, 90.928581, 1338.365478, 1084.360473, 90.623703, 1336.244995, 1084.401733, 10000);
				}
				case STEP_HOUSE_4: {
					InterpolateCameraPos(playerid, 91.734291, 1337.629760, 1084.485595, 91.734291, 1337.629760, 1084.485595, 1000);
					InterpolateCameraLookAt(playerid, 91.864639, 1332.946289, 1082.739624, 91.864639, 1332.946289, 1082.739624, 1000);
				}
				case STEP_HOUSE_5: {
					InterpolateCameraPos(playerid, 91.756523, 1337.455688, 1084.258666, 91.756523, 1337.455688, 1084.258666, 1000);
					InterpolateCameraLookAt(playerid, 96.580932, 1337.520507, 1082.946899, 96.580932, 1337.520507, 1082.946899, 1000);
				}
				case STEP_HOUSE_6: {
					InterpolateCameraPos(playerid, 91.788589, 1337.452148, 1084.262084, 91.788589, 1337.452148, 1084.262084, 1000);
					InterpolateCameraLookAt(playerid, 91.856918, 1342.305419, 1083.061401, 91.856918, 1342.305419, 1083.061401, 1000);
				}
				case STEP_HOUSE_7: {
					InterpolateCameraPos(playerid, 92.084411, 1337.475097, 1084.359985, 92.084411, 1337.475097, 1084.359985, 1000);
					InterpolateCameraLookAt(playerid, 87.214546, 1337.411376, 1083.228515, 87.214546, 1337.411376, 1083.228515, 1000);
				}
			}
		}
		case TYPE_TUTORIAL_PETRECERE: {

			switch(step) {

				case STEP_PETRECERE_2: {
					InterpolateCameraPos(playerid, 2543.024414, 2414.184570, 29.062841, 2561.973144, 2355.477050, 28.865861, 10000);
					InterpolateCameraLookAt(playerid, 2547.427001, 2412.258544, 27.681812, 2564.419921, 2359.646728, 27.590274, 10000);
				}
			}
		}
	}
	return true;
}
redist::setup_animation_actors(playerid, step) {
	switch(step) {

		case 0: ApplyDynamicActorAnimation(tutorial_actors[playerid][0][TYPE_TUTORIAL_PETRECERE], "PED","IDLE_CHAT", 4.0, 0, 0, 0, 0, 0);
		case 1: ApplyDynamicActorAnimation(tutorial_actors[playerid][1][TYPE_TUTORIAL_PETRECERE], "PED","IDLE_CHAT", 4.0, 0, 0, 0, 0, 0);
		case 2: ApplyDynamicActorAnimation(tutorial_actors[playerid][2][TYPE_TUTORIAL_PETRECERE], "PED","IDLE_CHAT", 4.0, 0, 0, 0, 0, 0);
		case 3: ApplyDynamicActorAnimation(tutorial_actors[playerid][3][TYPE_TUTORIAL_PETRECERE], "PED","IDLE_CHAT", 4.0, 0, 0, 0, 0, 0);
		case 4: ApplyDynamicActorAnimation(tutorial_actors[playerid][4][TYPE_TUTORIAL_PETRECERE], "BEACH", "bather", 4.0, 1, 0, 0, 0, 0);
		case 5: ApplyDynamicActorAnimation(tutorial_actors[playerid][5][TYPE_TUTORIAL_PETRECERE], "PED","IDLE_CHAT", 4.0, 0, 0, 0, 0, 0);
		case 6: ApplyDynamicActorAnimation(tutorial_actors[playerid][6][TYPE_TUTORIAL_PETRECERE], "PED","IDLE_CHAT", 4.0, 0, 0, 0, 0, 0);
		case 7: ApplyDynamicActorAnimation(tutorial_actors[playerid][7][TYPE_TUTORIAL_PETRECERE], "Null", "Null", 0, 0, 0, 0, 0, 0);
		case 8: ApplyDynamicActorAnimation(tutorial_actors[playerid][8][TYPE_TUTORIAL_PETRECERE], "BEACH", "bather", 4.0, 1, 0, 0, 0, 0);
		case 9: ApplyDynamicActorAnimation(tutorial_actors[playerid][9][TYPE_TUTORIAL_PETRECERE], "Null", "Null", 0, 0, 0, 0, 0, 0);
		case 10: ApplyDynamicActorAnimation(tutorial_actors[playerid][10][TYPE_TUTORIAL_PETRECERE], "Null", "Null", 0, 0, 0, 0, 0, 0);
		case 11: ApplyDynamicActorAnimation(tutorial_actors[playerid][11][TYPE_TUTORIAL_PETRECERE], "Null", "Null", 0, 0, 0, 0, 0, 0);
	}
	return true;
}
redist::setup_damaged_actors(playerid, step) {
	switch(step) {

		case 0: ApplyDynamicActorAnimation(tutorial_actors[playerid][0][TYPE_TUTORIAL_PETRECERE], "ped", "cower", 3.0, 1, 0, 0, 0, 0);
		case 1: ApplyDynamicActorAnimation(tutorial_actors[playerid][1][TYPE_TUTORIAL_PETRECERE], "ped", "cower", 3.0, 1, 0, 0, 0, 0);
		case 2: ApplyDynamicActorAnimation(tutorial_actors[playerid][2][TYPE_TUTORIAL_PETRECERE], "ped", "cower", 3.0, 1, 0, 0, 0, 0);
		case 3: ApplyDynamicActorAnimation(tutorial_actors[playerid][3][TYPE_TUTORIAL_PETRECERE], "ped", "cower", 3.0, 1, 0, 0, 0, 0);
		case 4: ApplyDynamicActorAnimation(tutorial_actors[playerid][4][TYPE_TUTORIAL_PETRECERE], "ped", "cower", 3.0, 1, 0, 0, 0, 0);
		case 5: ApplyDynamicActorAnimation(tutorial_actors[playerid][5][TYPE_TUTORIAL_PETRECERE], "ped", "cower", 3.0, 1, 0, 0, 0, 0);
		case 6: ApplyDynamicActorAnimation(tutorial_actors[playerid][6][TYPE_TUTORIAL_PETRECERE], "ped", "cower", 3.0, 1, 0, 0, 0, 0);
		case 7: ApplyDynamicActorAnimation(tutorial_actors[playerid][7][TYPE_TUTORIAL_PETRECERE], "ped", "cower", 3.0, 1, 0, 0, 0, 0);
		case 8: ApplyDynamicActorAnimation(tutorial_actors[playerid][8][TYPE_TUTORIAL_PETRECERE], "ped", "cower", 3.0, 1, 0, 0, 0, 0);
		case 9: ApplyDynamicActorAnimation(tutorial_actors[playerid][9][TYPE_TUTORIAL_PETRECERE], "ped", "cower", 3.0, 1, 0, 0, 0, 0);
	}
	for(new i = 10; i < 13; i++) if(IsValidDynamicActor(tutorial_actors[playerid][i][TYPE_TUTORIAL_PETRECERE])) DestroyDynamicActor(tutorial_actors[playerid][i][TYPE_TUTORIAL_PETRECERE]);
	return true;
}


redist::finish_tutorial(playerid) {
	GameTextForPlayer(playerid, "~y~Mission Passed~n~~w~Killed the boss!", 3000, 3); reset_tutorial_assets(playerid);
	SpawnPlayer(playerid);
	for(new i=0;i<30;i++) SendClientMessage(playerid,-1,""); SendAdminMessage(COLOR_RED, 1, "[ID: %d, SQLID: %d]%s a terminat tutorialul.", playerid, PlayerInfo[playerid][pSQLID], GetName(playerid));
	SendClientMessage(playerid, COLOR_SERVER, "Final:");
	SendClientMessage(playerid, -1, "");
	va_SendClientMessage(playerid, -1, "{ff0000}> {f9f9f9}Felicitari {ff0000}%s{f9f9f9}, ai terminat tutorialul cu succes si ai fost transferat in lumea normala.", GetName(playerid));
	PlayerInfo[playerid][pBoatLicT] = PlayerInfo[playerid][pGunLicT] = PlayerInfo[playerid][pFlyLicT] = gettime() + (7 * 86400);
	PlayerInfo[playerid][pBoatLic] = PlayerInfo[playerid][pGunLic] = PlayerInfo[playerid][pFlyLic] = 1;

	GiveVehicle(playerid, 411, false, true);

	SendClientMessage(playerid, COLOR_YELLOW, "Ai primit toate licentele pentru 7 zile deoarece server-ul este abia deschis!");
	SendClientMessage(playerid, COLOR_YELLOW, "Ai primit un Infernus cu VIP Plus pentru a te deplasa pana avansezi la nivel 7.");
	SCMf(playerid, COLOR_YELLOW, "Salut! %s, bine ai venit pe Epic Times! Foloseste [/bonus] pentru a beneficia de bonus-ul de inceput!", GetName(playerid));

	_query("update users set Intro = '0', `FlyLicT` = '%i', `BoatLicT` = '%i', `GunLicT` = '%i', `FlyLic` = '1', `BoatLic` = '1', `GunLic` = '1' where id = '%d'", gettime() + (7 * 86400), gettime() + (7 * 86400), gettime() + (7 * 86400), PlayerInfo[playerid][pSQLID]); PlayerTextDrawHide(playerid, TutorialPTD);
	return true;
}
redist::reset_tutorial_assets(playerid) {
	if(in_tutorial[playerid]) {
		for(new i; i < MAX_PETRECERE_BODYGUARDS; i++) if(IsValidDynamicActor(tutorial_actors[playerid][i][TYPE_TUTORIAL_PETRECERE])) DestroyDynamicActor(tutorial_actors[playerid][i][TYPE_TUTORIAL_PETRECERE]);
		for(new i; i < MAX_TUTORIAL_ACTORS; i++) if(IsValidDynamicActor(tutorial_actors[playerid][i][TYPE_TUTORIAL_HOUSE])) DestroyDynamicActor(tutorial_actors[playerid][i][TYPE_TUTORIAL_HOUSE]);
		for(new i; i < MAX_FINAL_ACTORS; i++) if(IsValidDynamicActor(final_actors[playerid][i])) DestroyDynamicActor(final_actors[playerid][i]);
		for(new i; i < MAX_PETRECERE_BODYGUARDS; i++) if(IsValidDynamicActor(tutorial_bodyguards[playerid][i])) DestroyDynamicActor(tutorial_bodyguards[playerid][i]);
		for(new i; i < MAX_TUTORIAL_TYPE; i++) for(new x; x < 20; x++) KillTimer(tutorial_timer[playerid][x]);
		for(new x; x < 3; x++) DestroyVehicle(tutorial_vehicle[playerid][x][TYPE_TUTORIAL_PETRECERE], "asd");
		in_tutorial[playerid] = false; enter_vehicle[playerid] = false; have_actors_killed[playerid] = false; need_arms[playerid] = false; need_get_arms[playerid] = false;
		need_bodyguard[playerid] = 0; killed_actors[playerid] = 0; in_step[playerid] = -1;
	}
	return true;
}
stock is_player_near_veh(const playerid, const vehicleid, Float:range) {
    new 
    	Float:X, Float:Y, Float:Z;

    GetVehiclePos(vehicleid, X, Y, Z);
    if(IsPlayerInRangeOfPoint(playerid, range, X, Y, Z)) return true;
    else return false;
}
/* --- CALLBACKS --- */
hook OnPlayerDeath(playerid) {
	tutorial_timer[playerid][STEP_DEATH_1] = SetTimerEx("tutorial_timer", 6000, false, "idd", playerid, STEP_DEATH_1, TYPE_TUTORIAL_DEATH);
	return true;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if(newkeys == KEY_YES) {
		if(in_tutorial[playerid] && need_arms[playerid]) {
			if !is_player_near_veh(playerid, tutorial_vehicle[playerid][STEP_PETRECERE_1][TYPE_TUTORIAL_PETRECERE], 5) *then return 1;
			else if !is_player_near_veh(playerid, tutorial_vehicle[playerid][STEP_PETRECERE_1][TYPE_TUTORIAL_PETRECERE], 10) *then return 1;
			GivePlayerWeapon(playerid, 31, 100); PlayerTextDrawSetString(playerid, TutorialPTD, "~r~HINT:~w~~n~Omoara cei 4 bodyguardzi cu arma din mana.");
			PlayerTextDrawShow(playerid, TutorialPTD); need_arms[playerid] = false; need_get_arms[playerid] = true;
		}
	}
	return true;
}
hook OnPlayerConnect(playerid) {
	for(new i; i < MAX_TUTORIAL_TYPE; i++) for(new x; x < 20; x++) KillTimer(tutorial_timer[playerid][x]);
	in_tutorial[playerid] = false; enter_vehicle[playerid] = false; have_actors_killed[playerid] = false; need_arms[playerid] = false; need_get_arms[playerid] = false;
	need_bodyguard[playerid] = 0; killed_actors[playerid] = 0; in_step[playerid] = -1;
	return true;
}
public OnPlayerGiveDamageDynamicActor(playerid, actorid, Float:amount, weaponid, bodypart) {
	if(weaponid == 31 && in_tutorial[playerid]) {
		if(actorid == tutorial_bodyguards[playerid][BODYGUARD_1]) {
			new Float:healthActor[MAX_PLAYERS]; GetDynamicActorHealth(tutorial_bodyguards[playerid][BODYGUARD_1], healthActor[playerid]); SetDynamicActorHealth(tutorial_bodyguards[playerid][BODYGUARD_1], healthActor[playerid] - amount);
			if(healthActor[playerid] == 30.0) {
				killed_actors[playerid] ++; for(new i; i < 11; i++) setup_damaged_actors(playerid, i); ApplyDynamicActorAnimation(tutorial_bodyguards[playerid][BODYGUARD_1],"PED", "FLOOR_HIT_F", 4.1, 0, 0, 0, 1, 0);
				if(killed_actors[playerid] >= 4) {
					PlayerTextDrawSetString(playerid, TutorialPTD, "~r~HINT:~w~~n~Elion a aflat de cele intamplate iar acum a fugit la aeroport, mergi sa-l omori inainte sa fuga cu avionul sau privat.");
					PlayerTextDrawShow(playerid, TutorialPTD); need_get_arms[playerid] = false; killed_actors[playerid] = 0; for(new i=0;i<30;i++) SendClientMessage(playerid,-1,""); 
					SendClientMessage(playerid, COLOR_SERVER, "Mission Step (3/3):");
					SendClientMessage(playerid, -1, "{ff0000}> {f9f9f9}Toti bodyguardzii au fost omorati, acum urmeaza noul pas!");
					SetPlayerCheckpoint(playerid, 1504.1311,1638.3447,10.8203, 1.5); CP[playerid] = 9995;
					for(new i; i < MAX_FINAL_ACTORS; i++) final_actors[playerid][i] = CreateDynamicActor(actor_final_model[i][0], actor_final_pos[i][0], actor_final_pos[i][1], actor_final_pos[i][2], actor_final_pos[i][3], 0, 30.0, playerid+1, 0, -1, STREAMER_ACTOR_SD);
					tutorial_vehicle[playerid][STEP_FINAL_1][TYPE_TUTORIAL_PETRECERE] = CreateVehicleEx(519, 1477.5017,1671.7867,11.7344,179.9573, 1, 1, -1);
					SetVehicleVirtualWorld(tutorial_vehicle[playerid][STEP_FINAL_1][TYPE_TUTORIAL_PETRECERE], playerid+1);
				}
				else va_SendClientMessage(playerid, -1, "{ff0000}> {f9f9f9}Ai omorat {ff0000}%d{f9f9f9} bodyguardzi.", killed_actors[playerid]);
			}
		}
		if(actorid == tutorial_bodyguards[playerid][BODYGUARD_2]) {

			new Float:healthActor[MAX_PLAYERS]; GetDynamicActorHealth(tutorial_bodyguards[playerid][BODYGUARD_2], healthActor[playerid]); SetDynamicActorHealth(tutorial_bodyguards[playerid][BODYGUARD_2], healthActor[playerid] - amount);
			if(healthActor[playerid] == 30.0) {
				killed_actors[playerid] ++; for(new i; i < 11; i++) setup_damaged_actors(playerid, i); ApplyDynamicActorAnimation(tutorial_bodyguards[playerid][BODYGUARD_2],"PED", "FLOOR_HIT_F", 4.1, 0, 0, 0, 1, 0);
				if(killed_actors[playerid] >= 4) {
					PlayerTextDrawSetString(playerid, TutorialPTD, "~r~HINT:~w~~n~Elion a aflat de cele intamplate iar acum a fugit la aeroport, mergi sa-l omori inainte sa fuga cu avionul sau privat.");
					PlayerTextDrawShow(playerid, TutorialPTD); need_get_arms[playerid] = false; killed_actors[playerid] = 0; for(new i=0;i<30;i++) SendClientMessage(playerid,-1,""); 
					SendClientMessage(playerid, COLOR_SERVER, "Mission Step (3/3):");
					SendClientMessage(playerid, -1, "");
					SendClientMessage(playerid, -1, "{ff0000}> {f9f9f9}Toti bodyguardzii au fost omorati, acum urmeaza noul pas!");
					SetPlayerCheckpoint(playerid, 1504.1311,1638.3447,10.8203, 1.5); CP[playerid] = 9995;
					for(new i; i < MAX_FINAL_ACTORS; i++) final_actors[playerid][i] = CreateDynamicActor(actor_final_model[i][0], actor_final_pos[i][0], actor_final_pos[i][1], actor_final_pos[i][2], actor_final_pos[i][3], 0, 30.0, playerid+1, 0, -1, STREAMER_ACTOR_SD);
					tutorial_vehicle[playerid][STEP_FINAL_1][TYPE_TUTORIAL_PETRECERE] = CreateVehicleEx(519, 1477.5017,1671.7867,11.7344,179.9573, 1, 1, -1);
					SetVehicleVirtualWorld(tutorial_vehicle[playerid][STEP_FINAL_1][TYPE_TUTORIAL_PETRECERE], playerid+1);
				}
				else va_SendClientMessage(playerid, -1, "{ff0000}> {f9f9f9}Ai omorat {ff0000}%d{f9f9f9} bodyguardzi.", killed_actors[playerid]);
			}
		}
		if(actorid == tutorial_bodyguards[playerid][BODYGUARD_3] && !have_actors_killed[playerid]) {

			new Float:healthActor[MAX_PLAYERS]; GetDynamicActorHealth(tutorial_bodyguards[playerid][BODYGUARD_3], healthActor[playerid]); SetDynamicActorHealth(tutorial_bodyguards[playerid][BODYGUARD_3], healthActor[playerid] - amount);
			if(healthActor[playerid] == 30.0) {
				killed_actors[playerid] ++; for(new i; i < 11; i++) setup_damaged_actors(playerid, i); ApplyDynamicActorAnimation(tutorial_bodyguards[playerid][BODYGUARD_3],"PED", "FLOOR_HIT_F", 4.1, 0, 0, 0, 1, 0);
				if(killed_actors[playerid] >= 4) {
					PlayerTextDrawSetString(playerid, TutorialPTD, "~r~HINT:~w~~n~Elion a aflat de cele intamplate iar acum a fugit la aeroport, mergi sa-l omori inainte sa fuga cu avionul sau privat.");
					PlayerTextDrawShow(playerid, TutorialPTD); need_get_arms[playerid] = false; killed_actors[playerid] = 0; for(new i=0;i<30;i++) SendClientMessage(playerid,-1,"");
					SendClientMessage(playerid, COLOR_SERVER, "Mission Step (3/3):");
					SendClientMessage(playerid, -1, "");
					SendClientMessage(playerid, -1, "{ff0000}> {f9f9f9}Toti bodyguardzii au fost omorati, acum urmeaza noul pas!");
					SetPlayerCheckpoint(playerid, 1504.1311,1638.3447,10.8203, 1.5); CP[playerid] = 9995;
					for(new i; i < MAX_FINAL_ACTORS; i++) final_actors[playerid][i] = CreateDynamicActor(actor_final_model[i][0], actor_final_pos[i][0], actor_final_pos[i][1], actor_final_pos[i][2], actor_final_pos[i][3], 0, 30.0, playerid+1, 0, -1, STREAMER_ACTOR_SD);
					tutorial_vehicle[playerid][STEP_FINAL_1][TYPE_TUTORIAL_PETRECERE] = CreateVehicleEx(519, 1477.5017,1671.7867,11.7344,179.9573, 1, 1, -1);
					SetVehicleVirtualWorld(tutorial_vehicle[playerid][STEP_FINAL_1][TYPE_TUTORIAL_PETRECERE], playerid+1);
				}
				else va_SendClientMessage(playerid, -1, "{ff0000}> {f9f9f9}Ai omorat {ff0000}%d{f9f9f9} bodyguardzi.", killed_actors[playerid]);
			}
		}
		if(actorid == tutorial_bodyguards[playerid][BODYGUARD_4] && !have_actors_killed[playerid]) {

			new Float:healthActor[MAX_PLAYERS]; GetDynamicActorHealth(tutorial_bodyguards[playerid][BODYGUARD_4], healthActor[playerid]); SetDynamicActorHealth(tutorial_bodyguards[playerid][BODYGUARD_4], healthActor[playerid] - amount);
			if(healthActor[playerid] == 30.0) {
				killed_actors[playerid] ++;  for(new i; i < 11; i++) setup_damaged_actors(playerid, i); ApplyDynamicActorAnimation(tutorial_bodyguards[playerid][BODYGUARD_4],"PED", "FLOOR_HIT_F", 4.1, 0, 0, 0, 1, 0);
				if(killed_actors[playerid] >= 4) {
					have_actors_killed[playerid] = true;
					PlayerTextDrawSetString(playerid, TutorialPTD, "~r~HINT:~w~~n~Elion a aflat de cele intamplate iar acum a fugit la aeroport, mergi sa-l omori inainte sa fuga cu avionul sau privat.");
					PlayerTextDrawShow(playerid, TutorialPTD); need_get_arms[playerid] = false; killed_actors[playerid] = 0; for(new i=0;i<30;i++) SendClientMessage(playerid,-1,"");
					SendClientMessage(playerid, COLOR_SERVER, "Mission Step (3/3):");
					SendClientMessage(playerid, -1, "");
					SendClientMessage(playerid, -1, "{ff0000}> {f9f9f9}Toti bodyguardzii au fost omorati, acum urmeaza noul pas!");
					SetPlayerCheckpoint(playerid, 1504.1311,1638.3447,10.8203, 1.5); CP[playerid] = 9995;
					for(new i; i < MAX_FINAL_ACTORS; i++) final_actors[playerid][i] = CreateDynamicActor(actor_final_model[i][0], actor_final_pos[i][0], actor_final_pos[i][1], actor_final_pos[i][2], actor_final_pos[i][3], 0, 30.0, playerid+1, 0, -1, STREAMER_ACTOR_SD);
					tutorial_vehicle[playerid][STEP_FINAL_1][TYPE_TUTORIAL_PETRECERE] = CreateVehicleEx(519, 1477.5017,1671.7867,11.7344,179.9573, 1, 1, -1);
					SetVehicleVirtualWorld(tutorial_vehicle[playerid][STEP_FINAL_1][TYPE_TUTORIAL_PETRECERE], playerid+1);
				}
				else va_SendClientMessage(playerid, -1, "{ff0000}> {f9f9f9}Ai omorat {ff0000}%d{f9f9f9} bodyguardzi.", killed_actors[playerid]);
			}
		}

		/* ---------- FINAL MISSION KILL ----------*/
		if(actorid == final_actors[playerid][STEP_FINAL_1] && entered_cp[playerid] == true) {

			new Float:healthActor[MAX_PLAYERS]; GetDynamicActorHealth(final_actors[playerid][STEP_FINAL_1], healthActor[playerid]); SetDynamicActorHealth(final_actors[playerid][STEP_FINAL_1], healthActor[playerid] - amount);
			if(healthActor[playerid] == 30.0) {
				killed_actors[playerid] ++; need_bodyguard[playerid] ++;
				ApplyDynamicActorAnimation(final_actors[playerid][STEP_FINAL_1],"PED", "FLOOR_HIT_F", 4.1, 0, 0, 0, 1, 0);
				if(killed_actors[playerid] >= 3) finish_tutorial(playerid);
			}
		}
		if(actorid == final_actors[playerid][STEP_FINAL_2] && entered_cp[playerid] == true) {

			new Float:healthActor[MAX_PLAYERS]; GetDynamicActorHealth(final_actors[playerid][STEP_FINAL_2], healthActor[playerid]); SetDynamicActorHealth(final_actors[playerid][STEP_FINAL_2], healthActor[playerid] - amount);
			if(healthActor[playerid] == 30.0) {
				killed_actors[playerid] ++; need_bodyguard[playerid] ++;
				ApplyDynamicActorAnimation(final_actors[playerid][STEP_FINAL_2],"PED", "FLOOR_HIT_F", 4.1, 0, 0, 0, 1, 0);
				if(killed_actors[playerid] >= 3) finish_tutorial(playerid);
			}
		}
		if(actorid == final_actors[playerid][STEP_FINAL_3] && entered_cp[playerid] == true) {
			if(need_bodyguard[playerid] < 2) return SendClientMessage(playerid, COLOR_GREY, "Trebuie sa omori mai intai bodyguardzii din jurul lui Elion."); new Float:healthActor[MAX_PLAYERS];
			GetDynamicActorHealth(final_actors[playerid][STEP_FINAL_3], healthActor[playerid]); SetDynamicActorHealth(final_actors[playerid][STEP_FINAL_3], healthActor[playerid] - amount);
			if(healthActor[playerid] == 30.0) {
				killed_actors[playerid] ++; need_bodyguard[playerid] ++;
				ApplyDynamicActorAnimation(final_actors[playerid][STEP_FINAL_3],"PED", "FLOOR_HIT_F", 4.1, 0, 0, 0, 1, 0);
				if(killed_actors[playerid] >= 3) finish_tutorial(playerid);
			}
		}
	}
	return true;
}
hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {
	if(in_tutorial[playerid] && PlayerInfo[playerid][pIntro] == 2 && in_step[playerid] == 1) {
		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(tutorial_vehicle[playerid][STEP_HOUSE_1][TYPE_TUTORIAL_HOUSE], engine, lights, alarm, doors, bonnet, boot, objective); start_tutorial(playerid, STEP_HOUSE_2, TYPE_TUTORIAL_HOUSE);
		if(vehicleid == tutorial_vehicle[playerid][STEP_HOUSE_1][TYPE_TUTORIAL_HOUSE]) SetVehicleParamsEx(tutorial_vehicle[playerid][STEP_HOUSE_1][TYPE_TUTORIAL_HOUSE], engine, lights, alarm, doors, bonnet, boot, VEHICLE_PARAMS_OFF);
	}
	return true;
}
hook OnPlayerDisconnect(playerid, reason) {
	reset_tutorial_assets(playerid);
	return true;
}
hook OnPlayerEnterCheckpoint(playerid) {
	switch(CP[playerid]) {

		case 9993: {
			if(IsPlayerInAnyVehicle(playerid)) return true;
			start_tutorial(playerid, STEP_HOUSE_3, TYPE_TUTORIAL_HOUSE);
		}
		case 9994: {
			if(IsPlayerInAnyVehicle(playerid)) return true; for(new i; i < MAX_PETRECERE_ACTORS; i++) setup_animation_actors(playerid, i);
			show_camera_tutorial(playerid, STEP_PETRECERE_2, TYPE_TUTORIAL_PETRECERE); TogglePlayerControllable(playerid, false);
			for(new i; i < MAX_PETRECERE_BODYGUARDS; i++) if(!IsValidDynamicActor(tutorial_bodyguards[playerid][i])) tutorial_bodyguards[playerid][i] = CreateDynamicActor(actors_bodyguard_model[i][0], actors_bodyguard_pos[i][0], actors_bodyguard_pos[i][1], actors_bodyguard_pos[i][2], actors_bodyguard_pos[i][3], 0, 30.0, playerid+1, 0, -1, STREAMER_ACTOR_SD);
			for(new i; i < MAX_PETRECERE_BODYGUARDS; i++) ApplyDynamicActorAnimation(tutorial_bodyguards[playerid][i], "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1);
			tutorial_timer[playerid][STEP_DEATH_1] = SetTimerEx("tutorial_timer", 10000, false, "idd", playerid, STEP_PETRECERE_1, TYPE_TUTORIAL_PETRECERE);
			GetDynamicActorPos(tutorial_actors[playerid][10][TYPE_TUTORIAL_PETRECERE], actor_pos_x[playerid], actor_pos_y[playerid], actor_pos_z[playerid]);
		}
		case 9995: {
			if(IsPlayerInAnyVehicle(playerid)) return true;
			CP[playerid] = 0; DisablePlayerCheckpoint(playerid); entered_cp[playerid] = true;
			PlayerTextDrawSetString(playerid, TutorialPTD, "~r~INFO:~n~~w~Omoara bodyguardzii lui Elion inainte sa-l omori pe el insusi. BodyGuardzii iti pot face rau daca incerci sa-l omori primul pe el.");
		}
	}
	return true;
}