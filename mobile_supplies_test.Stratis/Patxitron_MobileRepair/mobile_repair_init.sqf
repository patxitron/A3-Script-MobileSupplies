// Written by Patxitron [UTUM]
// Based on =BTC=_revive scripts by =BTC= Giallustio
//
// This script allows a vehicle to be a mobile supplies and repair base that rearms, refuels, and repairs other vehicles.
// In order to do the action, both the mobile supplies and the resupply objetive must be stopped and landed. When action
// menu is selected (driver) it drains all fuel, repairs, rearms, and refuels.
//
// The mobile supplies vehicles are organized by sides (blufor, opfor, guerrilla and civilians). One mobile supplies vehicle
// can repair, rearm and refuel any vehicle of any side, but in the map, only the mobile supplies vehicles of your own
// side are shown.
//
// How to use it:
//
// * Place the following line in the init.sqf file:
// call compile preprocessFile "Patxitron_MobileSupplies\mobile_supplies_init.sqf";
//
// * Edit your mission and give a name to each vehicle you want to be a mobile supplies vehicle.
//
// * Edit the file "Patxitron_MobileSupplies\mobile_supplies_init.sqf" and fill in the arrays with the names
// of the mobile supplies vehicles of each side.
//


////////////////// EDITABLE \\\\\\\\\\\\\\\\\\\\\\\\\\
PTXTRN_MBSP_respawn = 30; // value <= 0 do not respawn destroyed mobile supplies vehicles, value = n -> where n > 0, respawn destroyed mobile supplies vehicles after n seconds.
PTXTRN_MBSP_teleport_west = [Teleport_west]; // List of objects that allow teleporting to the mobile supplies in the blufor side.
PTXTRN_MBSP_teleport_east = []; // List of vehicles that allow teleporting to the mobile supplies in the opfor side.
PTXTRN_MBSP_teleport_guer = []; // List of vehicles that allow teleporting to the mobile supplies in the guerrilla side.
PTXTRN_MBSP_teleport_civ = []; // List of vehicles that allow teleporting to the mobile supplies in the civilian side.
if(isServer) then {
PTXTRN_MBSP_msveh_west = [Supplies_0,Supplies_1]; // List of vehicles that will be mobile supplies in the blufor side.
PTXTRN_MBSP_msveh_east = []; // List of vehicles that will be mobile supplies in the opfor side.
PTXTRN_MBSP_msveh_guer = []; // List of vehicles that will be mobile supplies in the guerrilla side.
PTXTRN_MBSP_msveh_civ = []; // List of vehicles that will be mobile supplies in the civilian side.
}; // if(isServer)

////////////////// Don't edit below \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

call compile preprocessFile "Patxitron_MobileRepair\mobile_repair_functions.sqf";

if(isServer) then {
	PTXTRN_MBSP_msveh_All = [];
	if(0 < count PTXTRN_MBSP_msveh_west) then {
		for "_i" from 0 to ((count PTXTRN_MBSP_msveh_west) - 1) do {
			_veh = (PTXTRN_MBSP_msveh_west select _i);
			_var = str (_veh);
			_veh setVariable ["PTXTRN_MBSP_msveh_west", _var, true];
			_veh call PTXTRN_MBSP_msveh_Provisional_Set_Loadout;
			PTXTRN_MBSP_msveh_All set [count PTXTRN_MBSP_msveh_All, _var];
			if(0 < PTXTRN_MBSP_respawn) then {
				_resp = [_veh, _var, "PTXTRN_MBSP_msveh_west"] spawn PTXTRN_MBSP_msveh_respawn;
			};
		};
	};
	if(0 < count PTXTRN_MBSP_msveh_east) then {
		for "_i" from 0 to ((count PTXTRN_MBSP_msveh_east) - 1) do {
			_veh = (PTXTRN_MBSP_msveh_east select _i);
			_var = str (_veh);
			_veh call PTXTRN_MBSP_msveh_Provisional_Set_Loadout;
			_veh setVariable ["PTXTRN_MBSP_msveh_east", _var, true];
			PTXTRN_MBSP_msveh_All set [count PTXTRN_MBSP_msveh_All, _var];
			if(0 < PTXTRN_MBSP_respawn) then {
				_resp = [_veh, _var, "PTXTRN_MBSP_msveh_east"] spawn PTXTRN_MBSP_msveh_respawn;
			};
		};
	};
	if(0 < count PTXTRN_MBSP_msveh_guer) then {
		for "_i" from 0 to ((count PTXTRN_MBSP_msveh_guer) - 1) do {
			_veh = (PTXTRN_MBSP_msveh_guer select _i);
			_var = str (_veh);
			_veh call PTXTRN_MBSP_msveh_Provisional_Set_Loadout;
			_veh setVariable ["PTXTRN_MBSP_msveh_guer", _var, true];
			PTXTRN_MBSP_msveh_All set [count PTXTRN_MBSP_msveh_All, _var];
			if(0 < PTXTRN_MBSP_respawn) then {
				_resp = [_veh, _var, "PTXTRN_MBSP_msveh_guer"] spawn PTXTRN_MBSP_msveh_respawn;
			};
		};
	};
	if(0 < count PTXTRN_MBSP_msveh_civ) then {
		for "_i" from 0 to ((count PTXTRN_MBSP_msveh_civ) - 1) do {
			_veh = (PTXTRN_MBSP_msveh_civ select _i);
			_var = str (_veh);
			_veh call PTXTRN_MBSP_msveh_Provisional_Set_Loadout;
			_veh setVariable ["PTXTRN_MBSP_msveh_civ", _var, true];
			PTXTRN_MBSP_msveh_All set [count PTXTRN_MBSP_msveh_All, _var];
			if(0 < PTXTRN_MBSP_respawn) then {
				_resp = [_veh, _var, "PTXTRN_MBSP_msveh_civ"] spawn PTXTRN_MBSP_msveh_respawn;
			};
		};
	};
	publicVariable "PTXTRN_MBSP_msveh_All";
}; // if(isServer)

if(isDedicated) exitWith {};

//Init
[] spawn {
	waitUntil {!isNull player};
	waitUntil {player == player};
	PTXTRN_MBSP_side = playerSide;
	switch (true) do {
		case (PTXTRN_MBSP_side == west) : {
			{
				private ["_var"];
				_var = _x getVariable ["PTXTRN_MBSP_msveh_west", ""];
				if(_var != "") then {
					_spawn = [_var, "PTXTRN_MBSP_msveh_west"] spawn PTXTRN_MBSP_msveh_marker;
					{
						_x addAction [("<t color=""#ED2744"">") + ("Teleport to " + _var) + "</t>", {[_this select 1, _this select 3, "PTXTRN_MBSP_msveh_west"] call PTXTRN_MBSP_msveh_teleport}, _var];
					} foreach PTXTRN_MBSP_teleport_west;
				};
			} foreach vehicles;
		};
		case (PTXTRN_MBSP_side == east) : {
			{
				private ["_var"];
				_var = _x getVariable ["PTXTRN_MBSP_msveh_east", ""];
				if(_var != "") then {
					_spawn = [_var, "PTXTRN_MBSP_msveh_east"] spawn PTXTRN_MBSP_msveh_marker;
					{
						_x addAction [("<t color=""#ED2744"">") + ("Teleport to " + _var) + "</t>", {[_this select 1, _this select 3, "PTXTRN_MBSP_msveh_east"] call PTXTRN_MBSP_msveh_teleport}, _var];
					} foreach PTXTRN_MBSP_teleport_east;
				};
			} foreach vehicles;
		};
		case (str (PTXTRN_MBSP_side) == "guer") : {
			{
				private ["_var"];
				_var = _x getVariable ["PTXTRN_MBSP_msveh_guer", ""];
				if(_var != "") then {
					_spawn = [_var, "PTXTRN_MBSP_msveh_guer"] spawn PTXTRN_MBSP_msveh_marker;
					{
						_x addAction [("<t color=""#ED2744"">") + ("Teleport to " + _var) + "</t>", {[_this select 1, _this select 3, "PTXTRN_MBSP_msveh_guer"] call PTXTRN_MBSP_msveh_teleport}, _var];
					} foreach PTXTRN_MBSP_teleport_guer;
				};
			} foreach vehicles;
		};
		case (PTXTRN_MBSP_side == civilian) : {
			{
				private ["_var"];
				_var = _x getVariable ["PTXTRN_MBSP_msveh_civ", ""];
				if(_var != "") then {
					_spawn = [_var, "PTXTRN_MBSP_msveh_civ"] spawn PTXTRN_MBSP_msveh_marker;
					{
						_x addAction [("<t color=""#ED2744"">") + ("Teleport to " + _var) + "</t>", {[_this select 1, _this select 3, "PTXTRN_MBSP_msveh_civ"] call PTXTRN_MBSP_msveh_teleport}, _var];
					} foreach PTXTRN_MBSP_teleport_civ;
				};
			} foreach vehicles;
		};
	};
}; // spawn

if(true) exitWith {};
