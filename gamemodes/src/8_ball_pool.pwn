#include <physics>

#define POOL_DISTANCE              0.8
#define DISTACE_PLAYER_TO_TABLE    1.7

#if !defined KEY_AIM
    #define KEY_AIM KEY_HANDBRAKE
#endif

#define MAX_POOL 99

new POOL_COUNT = 0;

enum {
    NO_EVENT_GAME,
    BALL_ENTER_IN_POOL,
    ENTER_WHITE_BALL_IN_POOL,
    WRONG_ENTER_BALL_IN_POOL,
    COLLISION_WRONG_BALLS,
    ENTER_BLACK_BALL_IN_POOL
}


static const table_ball[] = {0, 1,2,3,4,5,6,7,8,1,2,3,4,5,6,7};

enum POOL_MODEL{
    ID,
    Float:POS[3],
    TABLE,
    BALLS[16],
    PLAYERS[2],
    PLAYER_TURN,
    PLAYER_TYPE[2],
    PLAYER_BALLS[2],
    bool:PLAYER_ONE_BALL[2],
    bool:MOVE_BALL,
    GAME_STATE,
    BALLS_ENTER[16],
    COUNT_BALLS_ENTER
};

static const type_ball[][] = {"None", "Stripes", "Solids", "Black"};

new POOL[MAX_POOL][POOL_MODEL] = {{0, {0.0,0.0,0.0},0,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, {-1,-1}, 0, {0,0}, {0,0}, {false, false}, false, NO_EVENT_GAME, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, 0}, ...};

static in_pool[MAX_PLAYERS] = {-1, ...};
static player_tag[MAX_PLAYERS];
static Float:ball_angle[MAX_PLAYERS];
static bool:edit_whiteBall[MAX_PLAYERS];
static Text:PowerTD;
static PlayerBar:power_bar[MAX_PLAYERS];
static Float:tag_speed[MAX_PLAYERS];
static invite_game[MAX_PLAYERS] = {-1, ...};
static PlayerText:PoolInfoTD[MAX_PLAYERS][6];
static string[128];
static objectID[MAX_OBJECTS] = {-1, ...};
static Float:edit_camera[7];

static Float:range_payer[MAX_PLAYERS][2];

static bool:anim_player_pool[MAX_PLAYERS];

CMD:pool(playerid, params[]) {
    if(!IsAdmin(playerid, 5))
        return true;

    new Float:pos[3];
    GetPlayerFrontPos(playerid, pos[0], pos[1], pos[2] , 1.5);
    createPoolTable(pos[0], pos[1], pos[2]);
    return true;
}
#include <YSI_Coding\y_hooks>

hook OnPlayerDisconnect(playerid) {
    in_pool[playerid] = -1;
    invite_game[playerid] = -1;
    return true;
}
forward static TimerSetWhiteBall(playerid, stateid);
forward static destroy_pool_ball(objectid);
forward static OnPlayerStartGame(playerid, poolid);
forward static put_player_in_game(playerid, poolid);

forward static OnGamePoolEnd(stateid);

static EndGame(stateid, win) {
    new 
        winnerid = POOL[stateid][PLAYERS][win],
        loserid = POOL[stateid][PLAYERS][!win]
    ;

    GameTextForPlayer(loserid, "~y~Loser!", 3000, 3);
    GameTextForPlayer(winnerid, "~y~Winner!", 3000, 3);
    
    POOL[stateid][PLAYERS][0] = POOL[stateid][PLAYERS][1] = -1;
    return true;
}


static GetTablePool(tableid, type, x=0) {
    if(type-- == 0) return 7;
    for(new i = type ? 0 : 8, MAX = type ? 8 : 16; ++ i < MAX; )
        if(POOL[tableid][BALLS][i]) ++x;

    return x;
}

hook OnGameModeInit() {
    PowerTD = TextDrawCreate(499.205169, 217.020141, "POWER");
    TextDrawLetterSize(PowerTD, 0.303619, 1.450666);
    TextDrawAlignment(PowerTD, 1);
    TextDrawColor(PowerTD, -1378294017);
    TextDrawSetShadow(PowerTD, 0);
    TextDrawSetOutline(PowerTD, 1);
    TextDrawBackgroundColor(PowerTD, 255);
    TextDrawFont(PowerTD, 2);
    TextDrawSetProportional(PowerTD, 1);
    TextDrawSetShadow(PowerTD, 0);
    return true;
}

static saveGamePoint(stateid, type, ball) {
    POOL[stateid][GAME_STATE] = type > POOL[stateid][GAME_STATE] ? type : POOL[stateid][GAME_STATE];
    if(type == BALL_ENTER_IN_POOL) POOL[stateid][BALLS_ENTER][POOL[stateid][COUNT_BALLS_ENTER]++] = ball;
    return true;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
    switch(newkeys) {
        case KEY_SECONDARY_ATTACK: {
            if(GetPlayerWeapon(playerid) == WEAPON_POOLSTICK) {
                if(edit_whiteBall[playerid]) return stopEditBall(playerid);
                if(in_pool[playerid] == -1) {
                    new poolid = getPoolInNerby(playerid);
                    if(poolid == -1) return true;
                    new turn = POOL[poolid][PLAYER_TURN];
                    if(POOL[poolid][PLAYERS][turn] == playerid)
                        EnterPlayerInGame(playerid, poolid);
                }
            }
        }
        case KEY_AIM: ExitGame(playerid), TogglePlayerControllable(playerid, true);
        case KEY_FIRE: {
            if(anim_player_pool[playerid]) return SetPlayerArmedWeapon(playerid, 0);
            if(GetPlayerWeapon(playerid) == WEAPON_POOLSTICK && in_pool[playerid] == -1) {
                anim_player_pool[playerid] = true;
                ApplyAnimation(playerid, "POOL", "POOL_ChalkCue", 4.1, 0, 0, 0, 0, 0);
                SetPlayerArmedWeapon(playerid, 0);
                SetPlayerAttachedObject(playerid, 0, 3004, 6, 0.1180, -0.0599, 0.3480, -76.9000, -27.1000, 10.4000, 1.0000, 1.0000, 1.0000);
                SetTimerEx(#reset_player_weapon_pool, 3650, false, #i, playerid);
            }
        }
    }
    return true;
}

forward static reset_player_weapon_pool(playerid);
public reset_player_weapon_pool(playerid) {
    anim_player_pool[playerid] = false;
    SetPlayerArmedWeapon(playerid, WEAPON_POOLSTICK);
    RemovePlayerAttachedObject(playerid, 0);
    return true;
}

static EnterPlayerInGame(playerid, poolid) {
    in_pool[playerid] = poolid;
    if(POOL[poolid][MOVE_BALL] || POOL[poolid][BALLS][0] == 0)
        return SetPlayerPosWhiteBall(playerid, poolid);

    SetTimerEx(#put_player_in_game, 500, false, #ii, playerid, poolid);
    new 
        Float:bx,Float:by,Float:bz,
        Float:px,Float:py,Float:pz
    ;

    GetObjectPos(POOL[poolid][BALLS][0], bx, by, bz);
    GetPlayerPos(playerid,px,py,pz);    
    ball_angle[playerid] = 180 - atan2(px - bx, py - by);
    range_payer[playerid][0] = px;
    range_payer[playerid][1] = py;

    new turn = POOL[poolid][PLAYER_TURN];
    POOL[poolid][PLAYER_BALLS][turn] = GetTablePool(poolid, POOL[poolid][PLAYER_TYPE][turn]);
    POOL[poolid][PLAYER_BALLS][!turn] = GetTablePool(poolid, POOL[poolid][PLAYER_TYPE][!turn]);


    SetObjectRot(POOL[poolid][BALLS][0], 0.0, 0.0, ball_angle[playerid]);
    player_tag[playerid] = CreateObject(3004, bx, by, bz, 0.0, 0.0, 0.0, 50.0);
    AttachObjectToObject(player_tag[playerid], POOL[poolid][BALLS][0], 0.0, 0.0, 0.0, 0.0, 0.0, 180.0);

    power_bar[playerid] = CreatePlayerProgressBar(playerid, 551.000000, 222.000000, 59.500000, 5.700000, -1429936641, 100.0000, 0);
    SetPlayerProgressBarMaxValue(playerid, power_bar[playerid], 3.0);
    TextDrawShowForPlayer(playerid, PowerTD);

    ShowPlayerProgressBar(playerid, power_bar[playerid]);
    tag_speed[playerid] = 0.0;

    new Float:angle = ball_angle[playerid]+180.0, Float:distance, Float:x,Float:y,Float:z;
    GetObjectPos(POOL[poolid][BALLS][0], x,y,z);

    GetDistanceTableFromPlayer(playerid, poolid, distance);

    SetPlayerPos(playerid, x+(floatsin(-angle,degrees)*distance),y+(floatcos(-angle,degrees)*distance),z);
    SetPlayerFacingAngle(playerid, angle-180.0);

    if(distance < 1.0) ApplyAnimation(playerid, "POOL", "POOL_Short_Start", 4.1, 0, 0, 0, 1, 0);
    else if(distance < 1.5) ApplyAnimation(playerid, "POOL", "POOL_Med_Start", 4.1, 0, 0, 0, 1, 0);
    else if(distance < 2.0) ApplyAnimation(playerid, "POOL", "POOL_Long_Start", 4.1, 0, 0, 0, 1, 0);
    else ApplyAnimation(playerid, "POOL", "POOL_XLong_Start", 4.1, 0, 0, 0, 1, 0);

    SetPlayerArmedWeapon(playerid, 0);
    return true;
}

public put_player_in_game(playerid, poolid) {
    if(in_pool[playerid] == -1) return true;
    SetTimerEx(#OnPlayerStartGame, 50, false, #ii, playerid, poolid);

    SetPlayerCameraTo(playerid, POOL[poolid][BALLS][0]);
    return true;
}

public OnPlayerStartGame(playerid, poolid) {
    if(in_pool[playerid] == -1) return true;
    new k,ud, lr;
    GetPlayerKeys(playerid, k,ud, lr);
    SetTimerEx(#OnPlayerStartGame, 50, false, #ii, playerid, poolid);

    if(k == KEY_FIRE) {
        if(tag_speed[playerid] >= 3.0) return true;
        tag_speed[playerid] += 0.25;
        SetPlayerProgressBarValue(playerid, power_bar[playerid], tag_speed[playerid]);
        return true;
    }

    if(tag_speed[playerid] > 0.0)
        return SetPLayerBallShot(playerid);

    if(lr != 0) {
        ball_angle[playerid] = ball_angle[playerid] + (lr == KEY_RIGHT ? 1.0 : -1.0);
        SetObjectRot(POOL[poolid][BALLS][0], 0.0, 0.0, ball_angle[playerid]);
        
        new Float:angle = ball_angle[playerid]+180.0, Float:distance;

        GetDistanceTableFromPlayer(playerid, poolid, distance);


        new Float:x,Float:y,Float:z;
        GetPlayerPos(playerid, x,y,z);

        if(lr == KEY_RIGHT) {
            if(y > POOL[poolid][POS][1]-0.900 && y < POOL[poolid][POS][1]+0.900) SetPlayerVelocity(playerid, 0.0, x < POOL[poolid][POS][0]+0.900 ? -0.035 : 0.035,0.0);
            if(y > POOL[poolid][POS][1]+0.900 || y < POOL[poolid][POS][1]-0.900) SetPlayerVelocity(playerid, y < POOL[poolid][POS][1]-0.900 ? 0.04 : -0.04,0.0,0.0);
        } else {
            if(y > POOL[poolid][POS][1]-0.900 && y < POOL[poolid][POS][1]+0.900) SetPlayerVelocity(playerid, 0.0, x < POOL[poolid][POS][0]+0.900 ? 0.035 : -0.035,0.0);
            if(y > POOL[poolid][POS][1]+0.900 || y < POOL[poolid][POS][1]-0.900) SetPlayerVelocity(playerid, y < POOL[poolid][POS][1]-0.900 ? -0.04 : 0.04,0.0,0.0);
        }

        SetPlayerFacingAngle(playerid, angle-180.0);

        SetPlayerCameraTo(playerid, POOL[poolid][BALLS][0]);
    }
    return true;
}

static SetPlayerPosWhiteBall(playerid, stateid) {
    TogglePlayerControllable(playerid, false);

    if(POOL[stateid][BALLS][0] == 0) {
        POOL[stateid][BALLS][0] = CreateObject(3003, POOL[stateid][POS][0] + 0.5, POOL[stateid][POS][1], POOL[stateid][POS][2] -0.045 , 0, 0, 180.0);

        objectID[POOL[stateid][BALLS][0]] = 0;
        PHY_InitObject(POOL[stateid][BALLS][0], stateid, 3003, _, _, PHY_MODE_2D);
        PHY_SetObjectFriction( POOL[stateid][BALLS][0] , 0.08);
        PHY_RollObject( POOL[stateid][BALLS][0] ,1);
    }

    SetPlayerCameraPos(playerid, POOL[stateid][POS][0]-0.5, POOL[stateid][POS][1], POOL[stateid][POS][2]+3.0);
    SetPlayerCameraLookAt(playerid, POOL[stateid][POS][0], POOL[stateid][POS][1], POOL[stateid][POS][2]);

    edit_whiteBall[playerid] = true;
    SetTimerEx(#TimerSetWhiteBall, 100, false, #ii, playerid, stateid);
    return true;
}

static getVectorSizeDistance(Float:x, Float:_x, &Float:ret1, &Float:ret2, Float:range) {
    ret1 = VectorSize((x-_x)+range,0.0,0.0);
    ret2 = VectorSize((x-_x)-range,0.0,0.0);
    return true;
}

static GetDistanceTableFromPlayer(playerid, stateid, &Float:distance) {
    new Float:x1, Float:x2, Float:y1, Float:y2, Float:x,Float:y,Float:z;
    GetObjectPos(POOL[stateid][BALLS][0], x, y, z);
    getVectorSizeDistance(POOL[stateid][POS][0], x, x1, x2, 1.000);
    getVectorSizeDistance(POOL[stateid][POS][1], y, y1, y2, 0.600);


    new Float:px = range_payer[playerid][0];
    new Float:py = range_payer[playerid][1];

    distance += px-POOL[stateid][POS][0] > 0 ? x1 : x2;
    distance += py-POOL[stateid][POS][1] > 0 ? y1 : y2;
    return true;
}

public TimerSetWhiteBall(playerid, stateid) {
    if(!edit_whiteBall[playerid]) return true;
    SetTimerEx(#TimerSetWhiteBall, 100, false, #ii, playerid, stateid);
    new k,ud,lr, Float:x,Float:y,Float:z;

    GetPlayerKeys(playerid, k, ud, lr);
    GetObjectPos(POOL[stateid][BALLS][0], x, y, z);

    if(lr == KEY_RIGHT)     y = y-0.02 > (POOL[stateid][POS][1] - 0.46) ? y - 0.02 : POOL[stateid][POS][1]-0.46;
    else if(lr == KEY_LEFT) y = y+0.02 < (POOL[stateid][POS][1] + 0.49) ? y + 0.02 : POOL[stateid][POS][1]+0.49;
 
    if(ud == KEY_UP)        x = x+0.02 < (POOL[stateid][POS][0] + 0.92) ? x + 0.02 : POOL[stateid][POS][0]+0.92;
    else if(ud == KEY_DOWN) x = x-0.02 > (POOL[stateid][POS][0] - 0.92) ? x - 0.02 : POOL[stateid][POS][0]-0.92; 

    print("");
    printf("%.2f %c %.2f (x)", POOL[stateid][POS][0], POOL[stateid][POS][0]-x ? '-' : '+', POOL[stateid][POS][0]-x);
    printf("%.2f %c %.2f (y)", POOL[stateid][POS][1], POOL[stateid][POS][1]-y ? '-' : '+', POOL[stateid][POS][1]-y);

    SetObjectPos(POOL[stateid][BALLS][0],x,y,z);
    return true;
}

static stopEditBall(playerid) {
    new poolid = in_pool[playerid];
    POOL[poolid][MOVE_BALL] = false;
    edit_whiteBall[playerid] = false;
    TogglePlayerControllable(playerid, true);
    EnterPlayerInGame(playerid, poolid);
    return true;
}


static SetPlayerCameraTo(playerid, objectid) {
    new Float:bx,Float:by,Float:bz;
    GetObjectPos(objectid, bx, by, bz);

    SetPlayerCameraPos(playerid, 
        bx + (POOL_DISTANCE * floatsin( -(ball_angle[playerid]+180.0), degrees)), 
        by + (POOL_DISTANCE * floatcos( -(ball_angle[playerid]+180.0), degrees)), 
        bz + 0.3
    );
    SetPlayerCameraLookAt(playerid, bx, by, bz);
    return true;
}

static SetPLayerBallShot(playerid) {
    new poolid = in_pool[playerid];
    if(!ExitGame(playerid)) return false;

    POOL[poolid][PLAYER_ONE_BALL][POOL[poolid][PLAYER_TURN]] = false;

    SetPlayerArmedWeapon(playerid, WEAPON_POOLSTICK);

    TogglePlayerControllable(playerid, false);

    new Float:angle = ball_angle[playerid]+180.0, Float:distance, Float:x,Float:y,Float:z;
    GetObjectPos(POOL[poolid][BALLS][0], x,y,z);

    GetDistanceTableFromPlayer(playerid, poolid, distance);

    SetPlayerPos(playerid, x+(floatsin(-angle,degrees)*distance),y+(floatcos(-angle,degrees)*distance),z);
    SetPlayerFacingAngle(playerid, angle-180.0);

    if(distance < 1.0) ApplyAnimation(playerid, "POOL", "POOL_Short_Shot", 4.1, 0, 0, 0, 1, 0);
    else if(distance < 1.5) ApplyAnimation(playerid, "POOL", "POOL_Med_Shot", 4.1, 0, 0, 0, 1, 0);
    else if(distance < 2.0) ApplyAnimation(playerid, "POOL", "POOL_Long_Shot", 4.1, 0, 0, 0, 1, 0);
    else ApplyAnimation(playerid, "POOL", "POOL_XLong_Shot", 4.1, 0, 0, 0, 1, 0);

    SetPlayerCameraPos(playerid, 
        POOL[poolid][POS][0] + (2.5 * floatsin( -ball_angle[playerid], degrees)), 
        POOL[poolid][POS][1] + (2.5 * floatcos( -ball_angle[playerid], degrees)), 
        POOL[poolid][POS][2] + 2.5
    );
    SetPlayerCameraLookAt(playerid, POOL[poolid][POS][0], POOL[poolid][POS][1], POOL[poolid][POS][2]);

    SetTimerEx(#set_player_shoot_bool, 400, false, #ii, playerid, poolid);
    return true;
}

forward static set_player_shoot_bool(playerid, poolid);
public set_player_shoot_bool(playerid, poolid) {
    StartCheckMyPHY(poolid);
    PHY_SetObjectVelocity(POOL[poolid][BALLS][0], tag_speed[playerid] * floatsin( -ball_angle[playerid], degrees), tag_speed[playerid] * floatcos( -ball_angle[playerid], degrees));   
    tag_speed[playerid] = 0.0; 
    return true;
}

static ExitGame(playerid) {
    if(in_pool[playerid] == -1) return false;
    if(edit_whiteBall[playerid]) return stopEditBall(playerid);

    SetPlayerArmedWeapon(playerid, WEAPON_POOLSTICK);
    SetCameraBehindPlayer(playerid);
    in_pool[playerid] = -1;
    DestroyObject(player_tag[playerid]);
    TextDrawHideForPlayer(playerid, PowerTD);
    DestroyPlayerProgressBar(playerid, power_bar[playerid]);
    return true;
}
CMD:leavegame(playerid, params[]) {
    ExitGame(playerid);
    SendClientMessage(playerid, COLOR_WHITE, "Game leaved succesfully");
    return true;
}
CMD:deletepool(playerid, params[]) {
    new i = getPoolInNerby(playerid);
    if(i != -1) {
        DestroyPoolGame(i);
        format(gString,sizeof gString, "(POOL) Ai distrus masa de billiard #%d cu success!", i + 1);
        SendClientMessage(playerid, COLOR_YELLOW, gString);
    }
    return true;
}

static DestroyPoolGame(poolid) {
    for(new i=-1;++ i < 16;)
        PHY_DeleteObject(POOL[poolid][BALLS][i], poolid),
        DestroyDynamicObject(POOL[poolid][BALLS][i]);

    DestroyDynamicObject(POOL[poolid][TABLE]);
    return true;
}

stock getPoolInNerby(playerid) {
    for(new i = -1; ++ i < POOL_COUNT; ) { 
        if(!IsPlayerInRangeOfPoint(playerid, 4.0, POOL[i][POS][0], POOL[i][POS][1], POOL[i][POS][2])) continue; //if not exist continue or exist stop loop
        return i;
    }
    return -1;
}

stock createPoolTable(Float:x,Float:y,Float:z){

    // table id
    POOL[POOL_COUNT][ID] = ( POOL_COUNT + 1);
    
    // table position
    POOL[POOL_COUNT][POS][0] = x;
    POOL[POOL_COUNT][POS][1] = y;
    POOL[POOL_COUNT][POS][2] = z;
        

    POOL[POOL_COUNT][TABLE] = CreateDynamicObject(2964, x,y,z -1     , 0, 0, 0);

    // balls object array
    POOL[POOL_COUNT][BALLS][0] = CreateObject(3003, x + 0.5,   y,         z -0.045 , 0, 0, 180.0); // 0
    POOL[POOL_COUNT][BALLS][1] = CreateObject(3002, x - 0.3,   y,         z -0.045 , 0, 0, 0); // 1
    POOL[POOL_COUNT][BALLS][2] = CreateObject(3100, x - 0.525, y - 0.040, z -0.045 , 0, 0, 0); // 2
    POOL[POOL_COUNT][BALLS][3] = CreateObject(3101, x - 0.375, y + 0.044, z -0.045 , 0, 0, 0); // 3
    POOL[POOL_COUNT][BALLS][4] = CreateObject(3102, x - 0.600, y + 0.079, z -0.045 , 0, 0, 0); // 4
    POOL[POOL_COUNT][BALLS][5] = CreateObject(3103, x - 0.525, y + 0.118, z -0.045 , 0, 0, 0); // 5
    POOL[POOL_COUNT][BALLS][6] = CreateObject(3104, x - 0.600, y - 0.157, z -0.045 , 0, 0, 0); // 6
    POOL[POOL_COUNT][BALLS][7] = CreateObject(3105, x - 0.450, y - 0.079, z -0.045 , 0, 0, 0); // 7
    POOL[POOL_COUNT][BALLS][8] = CreateObject(3106, x - 0.450, y,         z -0.045 , 0, 0, 0); // 8
    POOL[POOL_COUNT][BALLS][9] = CreateObject(2995, x - 0.375, y - 0.044, z -0.045 , 0, 0, 0); // 1
    POOL[POOL_COUNT][BALLS][10] = CreateObject(2996, x - 0.450, y + 0.079, z -0.045 , 0, 0, 0); // 2
    POOL[POOL_COUNT][BALLS][11] = CreateObject(2997, x - 0.525, y - 0.118, z -0.045 , 0, 0, 0); // 3
    POOL[POOL_COUNT][BALLS][12] = CreateObject(2998, x - 0.600, y - 0.079, z -0.045 , 0, 0, 0); // 4
    POOL[POOL_COUNT][BALLS][13] = CreateObject(2999, x - 0.600, y,         z -0.045 , 0, 0, 0); // 5
    POOL[POOL_COUNT][BALLS][14] = CreateObject(3000, x - 0.600, y + 0.157, z -0.045 , 0, 0, 0); // 6
    POOL[POOL_COUNT][BALLS][15] = CreateObject(3001, x - 0.525, y + 0.040, z -0.045 , 0, 0, 0); // 7
    


    PHY_CreateArea( x - 0.96, y - 0.49,x + 0.95, y + 0.49,0.6,FLOAT_NEG_INFINITY);

    for(new i = 0; i < 16; i++){
        objectID[POOL[POOL_COUNT][BALLS][i]] = i;
        PHY_InitObject(POOL[POOL_COUNT][BALLS][i], POOL_COUNT, 3003, _, _, PHY_MODE_2D);
        PHY_SetObjectFriction( POOL[POOL_COUNT][BALLS][i] , 0.08);
        PHY_RollObject( POOL[POOL_COUNT][BALLS][i] ,1);
    }
    POOL_COUNT ++;
}

public OnGamePoolEnd(stateid) {
    new 
        turn = POOL[stateid][PLAYER_TURN], 
        player_turn = POOL[stateid][PLAYERS][turn],
        type = POOL[stateid][GAME_STATE],
        ballid = POOL[stateid][BALLS_ENTER][0]
    ;

    switch(type) {
        case NO_EVENT_GAME, COLLISION_WRONG_BALLS, ENTER_WHITE_BALL_IN_POOL, ENTER_BLACK_BALL_IN_POOL, WRONG_ENTER_BALL_IN_POOL: SetCameraBehindPlayer(player_turn), TogglePlayerControllable(player_turn, true);
    }

    switch(type) {
        case NO_EVENT_GAME: {
            if(!POOL[stateid][PLAYER_ONE_BALL][turn]) POOL[stateid][MOVE_BALL] = true;
            switchPlayerGame(stateid);
        }
        case COLLISION_WRONG_BALLS: {
            switchPlayerGame(stateid);
            POOL[stateid][MOVE_BALL] = true;
        }
        case BALL_ENTER_IN_POOL: {
            if(POOL[stateid][PLAYER_TYPE][turn] == 0) {
                POOL[stateid][PLAYER_TYPE][!turn] = (POOL[stateid][PLAYER_TYPE][turn] = ballid < 8 ? 2 : 1) == 2 ? 1 : 2;

                switch(POOL[stateid][PLAYER_TYPE][turn]) {
                    case 0: PlayerTextDrawSetString(player_turn, PoolInfoTD[player_turn][5], "The balls have not been decided yet.");
                    case 1: PlayerTextDrawSetString(player_turn, PoolInfoTD[player_turn][5], "You play Stripe!");
                    case 2: PlayerTextDrawSetString(player_turn, PoolInfoTD[player_turn][5], "You play Solids!");
                    case 3: PlayerTextDrawSetString(player_turn, PoolInfoTD[player_turn][5], "You play Black!");
                }
                PlayerTextDrawShow(player_turn, PoolInfoTD[player_turn][5]);
                SetTimerEx(#hide_player_pool_info, 5000, false, #i, player_turn);
            }   

            new str[128], len; string[0] = 0;
            strcat(str, "Pocketed ball!~n~~w~"), len = strlen(str);

            for(new i = -1; ++ i < POOL[stateid][COUNT_BALLS_ENTER]; )
                str[len] = '0' + table_ball[POOL[stateid][BALLS_ENTER][i]], str[len + 1] = '_', len += 2;

            showPlayerPoolInfo(player_turn, stateid, str);
        }
        case WRONG_ENTER_BALL_IN_POOL: {
            switchPlayerGame(stateid);
        }

        case ENTER_WHITE_BALL_IN_POOL: {
            switchPlayerGame(stateid);
            POOL[stateid][MOVE_BALL] = true;
        }
        case ENTER_BLACK_BALL_IN_POOL: {
            if(POOL[stateid][PLAYER_TYPE][turn] == 0) {
                POOL[POOL_COUNT][BALLS][8] = CreateObject(3106, POOL[stateid][POS][0] - 0.450, POOL[stateid][POS][1], POOL[stateid][POS][2] -0.045 , 0, 0, 0); // 8 ball
                objectID[POOL[POOL_COUNT][BALLS][8]] = 8;
                PHY_InitObject(POOL[stateid][BALLS][8], stateid, 3003, _, _, PHY_MODE_2D);
                PHY_SetObjectFriction( POOL[stateid][BALLS][8] , 0.08);
                PHY_RollObject( POOL[stateid][BALLS][8] ,1);
                switchPlayerGame(stateid);
                return true;
            }

            EndGame(stateid, (POOL[stateid][PLAYER_TYPE][turn] == 3 && POOL[stateid][BALLS][0] ? turn : _:!turn));
        }
    }

    POOL[stateid][COUNT_BALLS_ENTER] = 0;
    POOL[stateid][GAME_STATE] = NO_EVENT_GAME;
    return true;
}

forward static hide_player_pool_info(playerid);

static switchPlayerGame(stateid) {
    POOL[stateid][PLAYER_TURN] = !POOL[stateid][PLAYER_TURN];
    new turn = POOL[stateid][PLAYER_TURN];

    new id = POOL[stateid][PLAYERS][turn];

    GameTextForPlayer(id, "~w~~h~YOUR TURN!", 3000, 3);
    switch(POOL[stateid][PLAYER_TYPE][turn]) {
        case 0: PlayerTextDrawSetString(id, PoolInfoTD[id][5], "The balls have not been decided yet.");
        case 1: PlayerTextDrawSetString(id, PoolInfoTD[id][5], "You play Stripe!");
        case 2: PlayerTextDrawSetString(id, PoolInfoTD[id][5], "You play Solids!");
        case 3: PlayerTextDrawSetString(id, PoolInfoTD[id][5], "You play Black!");
    }
    PlayerTextDrawShow(id, PoolInfoTD[id][5]);


    SetTimerEx(#hide_player_pool_info, 5000, false, #i, id);
    return true;
}

public hide_player_pool_info(playerid) {
    PlayerTextDrawHide(playerid, PoolInfoTD[playerid][5]);
    return true;
}

CMD:debuganimation(playerid, params[]) {
    new a[32],a2[32], Float:speed, lockx, locky, freeze;
    if(sscanf(params, "s[32]s[32]fiii", a, a2, speed, lockx, locky, freeze))
        return true;

    ApplyAnimation(playerid, a, a2, speed, 0, lockx, locky, freeze, 0);
    return true;
}

static const Float:POOL_Corner[][] = {
    {0.955, 0.510},
    {0.955, -0.510},
    {0.000, 0.550},
    {0.000, -0.550},
    {-0.955, 0.510},
    {-0.955, -0.510}
};

public PHY_OnStateObjectUpdate(stateid) {
    new turn = POOL[stateid][PLAYER_TURN],Float:x,Float:y,Float:z;

    new Float:vx,Float:vy,Float:vz,bool:game=false;
    for(new b = -1; ++ b < 16; ) {
        if(!POOL[stateid][BALLS][b]) continue;

        GetObjectPos(POOL[stateid][BALLS][b], x, y, z);
        for(new c = -1; ++ c < sizeof POOL_Corner; ) {
            if(VectorSize(POOL[stateid][POS][0]-x+POOL_Corner[c][0], POOL[stateid][POS][1]-y+POOL_Corner[c][1], 0.0) > 0.10)
                continue;

            objectID[POOL[stateid][BALLS][b]] = -1;
            PHY_DeleteObject(POOL[stateid][BALLS][b], stateid);
            MoveObject(POOL[stateid][BALLS][b], POOL[stateid][POS][0] + POOL_Corner[c][0], POOL[stateid][POS][1] + POOL_Corner[c][1], POOL[stateid][POS][2] -0.25, 0.5);

            switch(b) {
                case 0: saveGamePoint(stateid, ENTER_WHITE_BALL_IN_POOL, b);
                case 8: saveGamePoint(stateid, ENTER_BLACK_BALL_IN_POOL, b);
                default: {
                    if(POOL[stateid][PLAYER_TYPE][turn] != 0) saveGamePoint(stateid, POOL[stateid][PLAYER_TYPE][turn] == (b < 8 ? 2 : 1) ? BALL_ENTER_IN_POOL : WRONG_ENTER_BALL_IN_POOL, b);
                    else saveGamePoint(stateid, BALL_ENTER_IN_POOL, b);
                }
            }
            SetTimerEx(#destroy_pool_ball, 1000, false, #i, POOL[stateid][BALLS][b]);
            POOL[stateid][BALLS][b] = 0;
            break;
        }

        PHY_GetObjectVelocity(POOL[stateid][BALLS][b], vx,vy,vz);
        if(VectorSize(vx, vy, vz) > 0.0) game = true;
    }

    if(!game) {
        OnGamePoolEnd(stateid);
        StopCheckMyPHY(stateid);
    }

    return true;
}

public PHY_OnObjectCollideWithObject(object1, object2, stateid) {
    new ball1 = objectID[object1], ball2 = objectID[object2];
    new turn = POOL[stateid][PLAYER_TURN];
    new id = POOL[stateid][PLAYERS][turn];
    new bool:one_shot=false;

    if(id == -1) return true;

    if(ball1 != 0) 
        return true;

    if(!POOL[stateid][PLAYER_ONE_BALL][turn])
        POOL[stateid][PLAYER_ONE_BALL][turn] = true, one_shot=true;

    if(POOL[stateid][PLAYER_TYPE][id] == 0)
        return true;

    if(one_shot) {
        if((ball2 < 8 && POOL[stateid][PLAYER_TYPE][turn] != 2) ||
            (ball2 > 8 && POOL[stateid][PLAYER_TYPE][turn] != 1) ||
            (ball2 == 8 && POOL[stateid][PLAYER_BALLS][turn] != 3)
        ) return saveGamePoint(stateid, COLLISION_WRONG_BALLS, ball2);
    }

    return true;
}



cmd:invitegame(playerid, params[]) {
    new id;
    if(sscanf(params, "u", id))
        return SendClientMessage(playerid, COLOR_GREY, "Syntax: {FFFFFF}/invitegame [playerid/name]");

    if(!IsPlayerConnected(id))
        return SendClientMessage(playerid, COLOR_GREY, "Player not connected!");

    if(!IsPlayerLogged(id))
        return SendClientMessage(playerid, COLOR_GREY, "Not logged in!");

    new Float:x,Float:y,Float:z;
    GetPlayerPos(playerid, x,y,z);

    if(!IsPlayerInRangeOfPoint(playerid, 8.0, x,y,z))
        return SendClientMessage(playerid, COLOR_GREY, "This player is not in your range!");

    if(getPoolInNerby(playerid) == -1)
        return SendClientMessage(playerid, COLOR_GREY, "You are not near a pool table!");
    
    invite_game[playerid] = id;
    SCMf(playerid, COLOR_WHITE, "You invited %s to a pool game!", GetName(id));
    SCMf(id, COLOR_WHITE, "You have been invited by player %s to a pool game! Use (/acceptgame %d)", GetName(playerid), playerid);
    return true;
}

cmd:acceptgame(playerid, params[]) {
    new id;
    if(sscanf(params, "u", id))
        return SendClientMessage(playerid, COLOR_GREY, "/acceptgame [playerid/name]");

    if(!IsPlayerConnected(id))
        return SendClientMessage(playerid, COLOR_GREY, "Player not connected.");

    if(!IsPlayerLogged(id))
        return SendClientMessage(playerid, COLOR_GREY, "Player not logged!");

    new Float:x,Float:y,Float:z;
    GetPlayerPos(playerid, x,y,z);

    if(!IsPlayerInRangeOfPoint(id, 8.0, x,y,z))
        return SendClientMessage(playerid, COLOR_GREY, "This player is not in your range!");

    if(invite_game[id] != playerid)
        return SendClientMessage(playerid, COLOR_GREY, "That player didn't invite you!");

    new poolid = getPoolInNerby(playerid);

    invite_game[id] = -1;

    POOL[poolid][MOVE_BALL] = true;

    POOL[poolid][PLAYERS][0] = playerid;
    POOL[poolid][PLAYERS][1] = id;

    POOL[poolid][PLAYER_TURN] = random(100)%2;

    POOL[poolid][PLAYER_BALLS][0] = 7;
    POOL[poolid][PLAYER_BALLS][1] = 7;

    PutPlayerInGame(playerid, poolid);
    PutPlayerInGame(id, poolid);

    SendClientMessage(playerid, COLOR_WHITE, "The game has begun!");

    SCMf(id, COLOR_WHITE, "%s has accepted your game request!", GetName(playerid));
    return true;
}

CMD:debuggame(playerid, params[]) {
    new poolid = getPoolInNerby(playerid);

    POOL[poolid][MOVE_BALL] = true;

    POOL[poolid][PLAYERS][0] = playerid;

    POOL[poolid][PLAYERS][1] = playerid;

    POOL[poolid][PLAYER_TURN] = 0;

    POOL[poolid][PLAYER_BALLS][0] = 7;
    POOL[poolid][PLAYER_BALLS][1] = 7;

    PutPlayerInGame(playerid, poolid);
    return true;
}


static PutPlayerInGame(playerid, poolid) {
     //textdraw
    PoolInfoTD[playerid][0] = CreatePlayerTextDraw(playerid, 36.047618, 182.733306, "LD_SPAC:white");
    PlayerTextDrawLetterSize(playerid, PoolInfoTD[playerid][0], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, PoolInfoTD[playerid][0], 99.000000, 148.000000);
    PlayerTextDrawAlignment(playerid, PoolInfoTD[playerid][0], 1);
    PlayerTextDrawColor(playerid, PoolInfoTD[playerid][0], 221);
    PlayerTextDrawSetShadow(playerid, PoolInfoTD[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, PoolInfoTD[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, PoolInfoTD[playerid][0], 255);
    PlayerTextDrawFont(playerid, PoolInfoTD[playerid][0], 4);
    PlayerTextDrawSetProportional(playerid, PoolInfoTD[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, PoolInfoTD[playerid][0], 0);

    PoolInfoTD[playerid][1] = CreatePlayerTextDraw(playerid, 41.238124, 168.666687, "Pool");
    PlayerTextDrawLetterSize(playerid, PoolInfoTD[playerid][1], 0.729143, 2.560000);
    PlayerTextDrawAlignment(playerid, PoolInfoTD[playerid][1], 1);
    PlayerTextDrawColor(playerid, PoolInfoTD[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, PoolInfoTD[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, PoolInfoTD[playerid][1], 2);
    PlayerTextDrawBackgroundColor(playerid, PoolInfoTD[playerid][1], 147);
    PlayerTextDrawFont(playerid, PoolInfoTD[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid, PoolInfoTD[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, PoolInfoTD[playerid][1], 0);

    PoolInfoTD[playerid][2] = CreatePlayerTextDraw(playerid, 43.523761, 196.826660, "Prabhat~n~~w~Solids");
    PlayerTextDrawLetterSize(playerid, PoolInfoTD[playerid][2], 0.313904, 1.621333);
    PlayerTextDrawAlignment(playerid, PoolInfoTD[playerid][2], 1);
    PlayerTextDrawColor(playerid, PoolInfoTD[playerid][2], -1378294017);
    PlayerTextDrawSetShadow(playerid, PoolInfoTD[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, PoolInfoTD[playerid][2], 1);
    PlayerTextDrawBackgroundColor(playerid, PoolInfoTD[playerid][2], 118);
    PlayerTextDrawFont(playerid, PoolInfoTD[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, PoolInfoTD[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, PoolInfoTD[playerid][2], 0);

    PoolInfoTD[playerid][3] = CreatePlayerTextDraw(playerid, 43.142810, 233.519958, "Redkiller~n~~w~Stripes");
    PlayerTextDrawLetterSize(playerid, PoolInfoTD[playerid][3], 0.310476, 1.710933);
    PlayerTextDrawAlignment(playerid, PoolInfoTD[playerid][3], 1);
    PlayerTextDrawColor(playerid, PoolInfoTD[playerid][3], -1378294017);
    PlayerTextDrawSetShadow(playerid, PoolInfoTD[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, PoolInfoTD[playerid][3], 1);
    PlayerTextDrawBackgroundColor(playerid, PoolInfoTD[playerid][3], 118);
    PlayerTextDrawFont(playerid, PoolInfoTD[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, PoolInfoTD[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, PoolInfoTD[playerid][3], 0);

    PoolInfoTD[playerid][4] = CreatePlayerTextDraw(playerid, 43.142807, 271.919921, "Pocketed ball!~n~~w~3");
    PlayerTextDrawLetterSize(playerid, PoolInfoTD[playerid][4], 0.297523, 1.753599);
    PlayerTextDrawAlignment(playerid, PoolInfoTD[playerid][4], 1);
    PlayerTextDrawColor(playerid, PoolInfoTD[playerid][4], -1378294017);
    PlayerTextDrawSetShadow(playerid, PoolInfoTD[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, PoolInfoTD[playerid][4], 1);
    PlayerTextDrawBackgroundColor(playerid, PoolInfoTD[playerid][4], 118);
    PlayerTextDrawFont(playerid, PoolInfoTD[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, PoolInfoTD[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, PoolInfoTD[playerid][4], 0);

    PoolInfoTD[playerid][5] = CreatePlayerTextDraw(playerid, 426.761901, 387.120025, "you play solids!");
    PlayerTextDrawLetterSize(playerid, PoolInfoTD[playerid][5], 0.404571, 1.779200);
    PlayerTextDrawAlignment(playerid, PoolInfoTD[playerid][5], 2);
    PlayerTextDrawColor(playerid, PoolInfoTD[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, PoolInfoTD[playerid][5], 1);
    PlayerTextDrawSetOutline(playerid, PoolInfoTD[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, PoolInfoTD[playerid][5], 255);
    PlayerTextDrawFont(playerid, PoolInfoTD[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, PoolInfoTD[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, PoolInfoTD[playerid][5], 1);

    new id = POOL[poolid][PLAYER_TURN];
    if(POOL[poolid][PLAYERS][id] == playerid) 
        GameTextForPlayer(playerid, "~w~YOU TURN!", 3000, 3);

    ServerWeapon(playerid, WEAPON_POOLSTICK, 1);
    return true;
}

forward static hide_payer_info(playerid);

static showPlayerPoolInfo(playerid, poolid, const string:info[]) {
    format(string, sizeof string, "%s~n~~w~%s", GetName(POOL[poolid][PLAYERS][0]), type_ball[POOL[poolid][PLAYER_TYPE][0]]);
    PlayerTextDrawSetString(playerid, PoolInfoTD[playerid][2], string);

    format(string, sizeof string, "%s~n~~w~%s", GetName(POOL[poolid][PLAYERS][1]), type_ball[POOL[poolid][PLAYER_TYPE][1]]);
    PlayerTextDrawSetString(playerid, PoolInfoTD[playerid][3], string);

    PlayerTextDrawSetString(playerid, PoolInfoTD[playerid][4], info);

    for(new i = -1; ++ i < 5; )
        PlayerTextDrawShow(playerid, PoolInfoTD[playerid][i]);

    SetTimerEx(#hide_payer_info, 5000, false, #i, playerid);
    return true;
}


public hide_payer_info(playerid) {
    for(new i = -1; ++ i < 5; )
        PlayerTextDrawHide(playerid, PoolInfoTD[playerid][i]);



    TogglePlayerControllable(playerid, true);
    SetCameraBehindPlayer(playerid);
    return true;
}

CMD:debugsound(playerid, params[]) {
    new sound;
    if(sscanf(params, "i", sound))
        return true;

    new Float:x,Float:y,Float:z;
    GetPlayerPos(playerid,x,y,z);
    PlayerPlaySound(playerid, sound, x, y, z);
    return true;
}

CMD:editcamera(playerid, params[]) {
    if(sscanf(params, "a<f>[7]", edit_camera))
        return true;

    SetPlayerCameraPos(playerid, 
        POOL[0][POS][0] + (edit_camera[6] * floatsin( -ball_angle[playerid], degrees)) + edit_camera[0], 
        POOL[0][POS][1] + (edit_camera[6] * floatcos( -ball_angle[playerid], degrees)) + edit_camera[1], 
        POOL[0][POS][2] + edit_camera[2]
    );
    SetPlayerCameraLookAt(playerid, POOL[0][POS][0]+edit_camera[3], POOL[0][POS][1]+edit_camera[4], POOL[0][POS][2]+edit_camera[5]);
    return true;
}

CMD:edittag(playerid, params[]) { 
    new Float:pos[6];
    if(sscanf(params, "P<,>ffffff", pos[0], pos[1], pos[2], pos[3], pos[4], pos[5]))
        return true;

    DestroyObject(player_tag[playerid]);
    new Float:x,Float:y,Float:z;

    GetObjectPos(POOL[0][BALLS][0], x, y, z);
    player_tag[playerid] = CreateObject(3004, x,y,z, 0.0, 0.0, 50.0);

    AttachObjectToObject(player_tag[playerid], POOL[0][BALLS][0], pos[0], pos[1], pos[2], pos[3], pos[4], pos[5]);

    SetObjectRot(POOL[0][BALLS][0], 0.0, 0.0, ball_angle[playerid]);
    return true;
}
public destroy_pool_ball(objectid) {
    DestroyObject(objectid);
    return true;
}


CMD:debugpool(playerid, params[]) {
    new Float:x1,Float:y1,Float:z1, Float:x2,Float:y2,Float:z2;
    GetObjectPos(POOL[0][TABLE], x1, y1, z1);

    GetPlayerPos(playerid,x2,y2,z2);

    return true;
}

stock GetPlayerFrontPos(playerid,&Float:x,&Float:y,&Float:z,Float:distance=0.0){

    new
        Float:px,
        Float:py,
        Float:pz,
        Float:pa;

    GetPlayerPos(playerid,px,py,pz);
    GetPlayerFacingAngle(playerid,pa);
    
    x = px+(floatsin(-pa, degrees)*distance);
    y = py+(floatcos(-pa, degrees)*distance);
    
    z = pz;
    
}