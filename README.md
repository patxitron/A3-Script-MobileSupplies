MobileSupplies by [UTUM]Patxitron
=================================

My mobile supplies ArmA III script.

Description:
------------

With this script you can make any vehicle acting like a mobile repair,
resupply and rearm device to any other vehilcle (air and land) and also
enables it to be a teleport target. It is possible that this script will
work also for sea vehicles, but I've not tested it.

Features:
---------

* Can be any vehicle (only land vehicles tested)
* Repairs, rearms and refuels any vehicle (only air and land vehicles tested)
* Can be a teleport target
* The vehicles assigned to this script can respawn when destroyed


Installation:
-------------

This script does not require mods nor add-ons. Just copy the ptxtrn folder into
your mission and append the following lines in the description.ext file:

```
class CfgFunctions
{
	#include "ptxtrn\cfgfunctions.hpp"
};
class Params
{
	#include "ptxtrn\params.hpp"
};

```


Usage:
------

In the mission editor for each vehicle you want to be a supplies vehicle
you must to give it a name and add the following sentence to the init field:

```
0 = ["west", this] call ptxtrn_fnc_supplies;
```

This will add the vehicle to the Blufor set of supplies vehicles. You can
change the "west" option to "east", "civ" or "guer" to add to another side
instead.

If you want the supplies vehicle to be a teletransport target, tou must add
an object that can trigger the teleport action and add the following sentence
to its init field:

```
0 = ["west", this] call ptxtrn_fnc_init_teleport;
```

As said before you can change the "west" option to "east", "civ" or "guer".

In the attached test mission, near the respawn point, you can find a heli and
a Cheetah that are supplies vehicles for the west side. There is also a NATO
flag pole wich is the teleport activator.

In another point of the map you can find a Hunter that is also a west side
supplies vehicle and another NATO flag as teleport point.

Walk to the nearest NATO flag and you can see in the action menu three teleport
actions in red, one for each vehicle.

There are also several vehicles that are not supplies vehicles to try the
resupply, repair and refuel operations with them. The have reduced health, fuel
and ammunition. Drive one of them to a supplies vehicle and when you are near
and facing it, stop, and then you can select the action "Resupply and repair" in
green.

Both vehicles (the supplies and the target) must be stopped (less that 3km/h)
and landed (in case of air vehicles).

Any supplies vehicle can repair an resuply any vehicle of any side. But on the
map, only the supplies vehicles of your own side are displayed (if the corresponding
parameter is enabled).

If you enable the teleport, Full vehicles can be teleported: get in as driver,
drive it to the teleport point and activate the option.

Parameters
----------

When in mission player slots assigning you can adjunst several parameters of this
script.

* Support vehicle deserted respawn delay (minutes): Delay to consider a supplies
vehicle deserted and respawn it in its position at mission start. Set it to 0
to disable this functionality (Not working yet).
* Support vehicle destroyed respawn delay (seconds): Dalay to respawn a supplies
vehicle after is has been destroyed. Set to 0 to no respawn at all. It respawns
near the position is was restroyed.
* Ammobox included in support vehicle: Here you can select the type of ammobox
to include in all supplies vehicles. Options are NONE, ARSENAL, VIRTUAL AMMOBOX
SYSTEM and BOTH. In order to use the VIRTUAL AMMOBOX SYSTEM you must include it
in yout mission (it is included in the example mission).
* Support vehicle marker shown in map: Set it to yes if you want a permament mark
in the map for your supplies vehicles. Those marks are only visible for players
of the same side of the vehicle's one.

Known problems
--------------

The deserted respawn does not work at tins moment.

Changelog:
----------

* 2013-10-19 Version 0.1:
	* First public release.
* 2013-12-09 Version 0.2:
	* Rewrote most of the functions.
	* Added targeted friendly players tag, based on ArmA II NameDisplay script by Melbo.
	* Added optional markers in map for own unit players.
	* Now full vehicles can be teleported to the mobile supplies vehicle.
* 2015-03-07 Version 1.0:
	* Completely rewritten from scratch.
	* Now there is no need to modify any script to set a vehicle as supplies vehicle nor to set an object as teleport trigger.
	* Configurable parameters at mission init.
	* This is only a supplies vehicle script so I deleted the players tags and markers.

Credits &amp; Thanks:
---------------------

Previous versions of this script were based on the superb =BTC= Revive by =BTC= Giallustio.
Since version 1.0 this is no longer the case.
