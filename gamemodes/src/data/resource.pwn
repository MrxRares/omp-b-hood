
#define YSI_NO_HEAP_MALLOC
#define YSI_NO_MODE_CACHE
#define YSI_NO_CACHE_MESSAGE
#define CGEN_MEMORY 60000
//#define _DEBUG 7

#include <open.mp>
#include <gvar>
#include <a_mysql>	
#include <streamer>		                                                                                                                                                                                                                                                                                
#include <omp_gangzone>	
#include <sscanf2>                                                        
#include <mSelection>                                                                                                                                                                                                                                                                                                                              
#include <progress>
#include <progress2>
#include <Pawn.CMD>
#include <fly>  
#include <YSI_Coding\y_timers>
#include <YSI_Data\y_iterate>
#include <YSI_Coding\y_stringhash>
#include <YSI_Coding\y_va>
#include <playerzone>	
#include <BigInt>
#include <mxINI>
#include <a_http>
#include "../gamemodes/src/variable.pwn"
#include <easyDialog>
//#include "../src/lucru_manual.pwn"
#include "../gamemodes/src/notify.inc"


#include <antibots>

#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {
	printf("%d", getIPToInt("255.255.255.254"));
	return true;
}
