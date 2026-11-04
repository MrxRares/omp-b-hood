#include <cef>
#include <YSI_Coding\y_hooks>

#define ID_NOTIFY 1

hook OnGameModeInit() {
    CEF_AddResource("notify");
    return 1;
}

hook OnCefReady(playerid)
{
    CEF_CreateBrowser(playerid, ID_NOTIFY, "http://cef/notify/index.html", false, false);
    return 1;
}

stock SendClientNotification(playerid, const type[], const title[], duration = 5000, const format_str[], {Float,_}:...)
{
    if (!IsPlayerConnected(playerid) || !CEF_PlayerHasPlugin(playerid))  return 0;

    new message[192];
    va_format(message, sizeof(message), format_str, ___(5)); 

    CEF_EmitEvent(playerid, ID_NOTIFY, "showNotification", CEF_STR(type), CEF_STR(title), CEF_STR(message), CEF_INT(duration));
    return 1;
}


hook OnPlayerDisconnect(playerid, reason) {
    if(CEF_PlayerHasPlugin(playerid)) {
        CEF_DestroyBrowser(playerid, ID_NOTIFY);
    }
    return 1;
}    