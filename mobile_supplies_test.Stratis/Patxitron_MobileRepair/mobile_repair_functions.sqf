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


// THIS FUNCTION IS HIHGLY PROVISIONAL AND SETS THE VEHICLE LOADOUT
PTXTRN_MBSP_msveh_Provisional_Set_Loadout = {
	_veh = _this;
	clearItemCargo _veh;
	clearMagazineCargo _veh;
	clearWeaponCargo _veh;
	_veh addMagazineCargoGlobal  ["30Rnd_65x39_caseless_mag", 50];
	_veh addMagazineCargoGlobal  ["30Rnd_556x45_Stanag", 50];
	_veh addMagazineCargoGlobal  ["20Rnd_762x51_Mag", 50];
	_veh addMagazineCargoGlobal  ["5Rnd_127x108_Mag", 30];
	_veh addMagazineCargoGlobal  ["7Rnd_408_Mag", 30];
	_veh addMagazineCargoGlobal  ["30Rnd_9x21_Mag", 15];
	_veh addMagazineCargoGlobal  ["9Rnd_45ACP_Mag", 15];
	_veh addMagazineCargoGlobal  ["30Rnd_45ACP_Mag_SMG_01", 25];
	_veh addMagazineCargoGlobal  ["150Rnd_762x51_Box", 20];
	_veh addMagazineCargoGlobal  ["200Rnd_65x39_cased_Box", 20];
	_veh addMagazineCargoGlobal  ["Titan_AA", 15];
	_veh addMagazineCargoGlobal  ["Titan_AP", 15];
	_veh addMagazineCargoGlobal  ["Titan_AT", 15];
	_veh addMagazineCargoGlobal  ["NLAW_F", 15];
	_veh addMagazineCargoGlobal  ["RPG32_F", 15];
	_veh addMagazineCargoGlobal  ["SatchelCharge_Remote_Mag", 10];
	_veh addItemCargoGlobal  ["FirstAidKit", 80];
	_veh addMagazineCargoGlobal  ["SmokeShell", 20];
	_veh addMagazineCargoGlobal  ["SmokeShellRed", 20];
	_veh addMagazineCargoGlobal  ["SmokeShellGreen", 20];
	_veh addMagazineCargoGlobal  ["handgrenade", 40];
	_veh addMagazineCargoGlobal  ["Laserbatteries", 5];
};



PTXTRN_MBSP_msveh_Rearm = {
	_target = _this select 0;
	_supplier = _this select 1;
	//_type = (getDescription _target) select 0;
	_type = typeOf _target;
	if(!alive _target) exitWith{};
	if(local _target) then {
		_target setFuel 0;
		_target VehicleChat "Repairing ...";
	};
	if(local _supplier) then {
		_supplier VehicleChat format ["Repairing %1...", _type];
	};
	if(local _supplier || local _target) then {
		sleep 15;
	};
	if(local _target) then {
		_target setDammage 0;
		_target VehicleChat "Rearming ...";
	};
	if(local _supplier) then {
		_supplier VehicleChat format ["Rearming %1...", _type];
	};
	if(local _supplier || local _target) then {
		sleep 10;
	};
	if(local _target) then {
		_target setVehicleAmmo 1;
		_target VehicleChat "Refuelling ...";
	};
	if(local _supplier) then {
		_supplier VehicleChat format ["Refuelling %1...", _type];
	};
	if(local _supplier || local _target) then {
		sleep 5;
	};
	if(local _target) then {
		_target setFuel 1;
		_target VehicleChat "Finished.";
	};
	if(local _supplier) then {
		_supplier VehicleChat format ["Finished %1.", _type];
	};
	if(true) exitWith{};
};



PTXTRN_MBSP_msveh_marker = {
	_var = _this select 0;
	_faction = _this select 1;
	while {true} do {
		_obj = objNull;
		while {isNull _obj} do {
			{if(format ["%1", _x getVariable _faction] == _var && Alive _x) then {_obj = _x;};} foreach vehicles;
			sleep 1;
		};
		_obj addAction ["<t color='#11ff11'>Resupply and repair</t>", {[[vehicle (_this select 1), _this select 0], "PTXTRN_MBSP_msveh_Rearm", nil, false] spawn BIS_fnc_MP}, [], 10, true, true, "", "_this != (vehicle _this) &&  _this == driver (vehicle _this) && (vehicle _this) != _target && speed _target <= 5 && speed _target >= -3 && speed (vehicle _this) <= 5 && speed (vehicle _this) >= -3 && (getPos (vehicle _this)) select 2 <= 2 && (getPos _target) select 2 <= 2"];
		_marker = format ["%1_marker", _var];
		deleteMarkerLocal _marker;
		createmarkerLocal [_marker, getPos _obj];
		_marker setmarkertypeLocal "mil_dot";
		_marker setMarkerTextLocal format ["%1", _var];
		_marker setmarkerColorlocal "ColorGreen";
		_marker setMarkerSizeLocal [0.5, 0.5];
		hint format ["%1 is available!", _var];
		while {Alive _obj} do {
			_pos = getPos _obj;
			_marker setMarkerPosLocal _pos;
			{
				if(!(_x getVariable ["has_resupply_action", false])) then {
					_x addAction ["<t color='#11ff11'>Resupply and repair</t>", {[[_this select 0, vehicle (_this select 1)], "PTXTRN_MBSP_msveh_Rearm", nil, false] spawn BIS_fnc_MP}, [], 10, true, true, "", format ["_this != (vehicle _this) &&  _this == driver (vehicle _this) && (vehicle _this) != _target &&  ((vehicle _this) getVariable ['%1', '']) in PTXTRN_MBSP_msveh_All && speed _target <= 5 && speed _target >= -3 && speed (vehicle _this) <= 5 && speed (vehicle _this) >= -3 && (getPos (vehicle _this)) select 2 <= 2 && (getPos _target) select 2 <= 2", _faction]];
					_x setVariable ["has_resupply_action", true];
				};
			} foreach (_pos nearObjects 50);
			if (speed _obj <= 5 && speed _obj >= -3) then {
				_marker setMarkerTextLocal format ["%1 deployed", _var];
				_marker setmarkerColorlocal "ColorGreen";
			} else {
				_marker setMarkerTextLocal format ["%1 is moving", _var];
				_marker setmarkerColorlocal "ColorBlack";
			};
			sleep 1;
		};
		hint format ["%1 has been destroyed!", _var];
		_marker setMarkerTextLocal format ["%1 destroyed!", _var];
		_marker setmarkerColorlocal "ColorRed";
	};
	if(true) exitWith{};
};



PTXTRN_MBSP_msveh_client_respawn = {
	_veh  = _this select 0;
	_name = _this select 1;
	_faction = _this select 2;
	_veh setVariable [_faction, _name];
};



PTXTRN_MBSP_msveh_respawn = {
	_veh  = _this select 0;
	_var  = _this select 1;
	_faction = _this select 2;
	_type = typeOf _veh;
	waitUntil {sleep 1; !Alive _veh};
	_dir  = getDir _veh;
	_pos  = getPos _veh;
	sleep PTXTRN_MBSP_respawn;
	deleteVehicle _veh;
	_veh = createVehicle [_type, (_pos findEmptyPosition [2, 200, _type]), [], 0, "NONE"];
	_veh call PTXTRN_MBSP_msveh_Provisional_Set_Loadout;
	_veh setDir _dir;
	_veh setVelocity [0, 0, -1];
	[[_veh, _var, _faction], "PTXTRN_MBSP_msveh_client_respawn", nil, false] spawn BIS_fnc_MP;
	_resp = [_veh, _var] spawn PTXTRN_MBSP_msveh_respawn;
	//_veh setPos _pos;
	if(true) exitWith{};
};

PTXTRN_MBSP_msveh_teleport = {
	_who = _this select 0;
	_var = _this select 1;
	_faction = _this select 2;
	_veh = objNull;
	while {isNull _veh} do {
		{if(format ["%1", _x getVariable _faction] == _var && Alive _x) then {_veh = _x;};} foreach vehicles;
		sleep 1;
	};
	if(!Alive _veh) then {
		_who sideChat "Can not teleport. The spawn point is destroyed";
	} else {
		if(speed _veh <= 5 && speed _veh >= -3) then {
			_who setPos ((getPos _veh) findEmptyPosition [10, 100]);
		} else {
			_who sideChat "Can not teleport. The spawn point is moving. Wait until it stops";
		};
	};
	if(true) exitWith{};
}
