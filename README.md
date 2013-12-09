A3-Script-MobileSupplies
========================

My mobile supplies ArmA III script.

Description:
------------
With this script you can make any vehicle acting like a mobile repair, resupply, rearm device to any other vehilcle (air and land) and also enables it to be a teleport target. It is possible that this script will work also for sea vehicles, but I've not tested it.


Features:
---------
*	Can be any vehicle (only land vehicles tested)
*	Repairs, rearms and refuels any vehicle (only air and land vehicles tested)
*	Can be a teleport target
*	The vehicles assigned to this script can respawn when destroyed


Installation:
-------------
This script does not require mods nor add-ons. Just copy the Patxitron_MobileRepair folder into your mission and append the following line in the init.sqf file:

	call compile preprocessFile "Patxitron_MobileRepair\mobile_repair_init.sqf";


Usage:
------
In the mission editor place one or more vehicles you want to be supplies vehicles and give them a name. Additionally, if you want them act as teleport target, place near the respawn point an object (a flag pole for example) and give it a name also. Then at the beginning of the Patxitron_MobileRepair\mobile_repair_init.sqf file, there are some variables you can adjust:
*	PTXTRN_MBSP_respawn: set it to 0 if you do not want respawning the supplies vehicles. Any value greater than 0 is the number of seconds any supplies vehicle will respawn after it got destroyed.
*	PTXTRN_MBSP_teleport_west: List of objects that are teleport activators for the west side.
*	PTXTRN_MBSP_teleport_east: List of objects that are teleport activators for the east side.
*	PTXTRN_MBSP_teleport_guer: List of objects that are teleport activators for the querrilla side.
*	PTXTRN_MBSP_teleport_civ: List of objects that are teleport activators for the civilian side.
*	PTXTRN_MBSP_msveh_west: List of supplies vehicles for the west side.
*	PTXTRN_MBSP_msveh_east: List of supplies vehicles for the east side.
*	PTXTRN_MBSP_msveh_guer: List of supplies vehicles for the guerrilla side.
*	PTXTRN_MBSP_msveh_civ: List of supplies vehicles for the civilian side.

The first function of the mobile_repair_functions.sqf file, named PTXTRN_MBSP_msveh_Provisional_Set_Loadout, sets the loadout of the supplies vehicles and you can change the magazines/weapons/items they carry.

In the attached test mission, you can find two Zamak covered trucks that are supplies vehicles for the west side. There is also a NATO flag pole wich is the teleport activator. Walk to it and you can see in the action menu two teleport actions in red, one for each vehicle.

There are some "repairable" whicles all of them damaged and with ammo and fuel set to 50%. in order to repair, rearm and refuel one of them, drive it to a supplies vehicle and when you are near and facing it, stop, and then you can select the action "Resupply and repair" in green.

You can do the opposite also: Get in the supplies vehicle and drive it to a damaged vehicle and wen you ar near, stop it and then you can select the "Resupply and repair" action.

Both vehicles (the supplies and the target) must be stopped (less that 3km/h) and landed (in case of air vehicles).

Any supplies vehicle can repeiy an resuply any vehicle of any side. But in the map, only the supplies vehicles of your own side are displayed.


Changelog:
----------
*	2013-10-19 Version 0.1: First public release.


Credits &amp; Thanks:
---------------------
This script is based on the superb =BTC= Revive by =BTC= Giallustio.
