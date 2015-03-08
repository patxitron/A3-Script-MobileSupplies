/*
 * fnc_manage_vehicle
 *
 * Watch for the given vehicle, initializes its ammobox, its supplier abilities and its spawn target abilities and
 * then maintains its marker updated while the vehicle is alive.
 *
 * IMPORTANT: Always give a name to the vehicles to be managed.
 *
 * USAGE:
 *     _spawn = [veh, teleport_target] spawn ptxtrn_fnc_manage_vehicle;
 *     where:
 *         veh is the object (vehicle) to manage.
 *         teleport_target ("none", "west", "east", "guer", "civ") if the vehicle is a teleport target for the given side.
 *
 * Example in the "Init" field of vehicles in mission editor:
 *    _nil = [this, true, "none", "arsenal"] spawn ptxtrn_fnc_manage_vehicle;
 * Example in the "Expression" field of the Vehicle respawn module (if respawn parameter is false):
 *    _this select 0 setName str(_this select 1) ; [_this select 0, true, "none", "arsenal"] spawn ptxtrn_fnc_manage_vehicle;
 */

_veh = _this select 0;
_veh_name = str(_veh);
_type = typeOf _veh;
_destroyed = "ptxtrn_supply_destroyed" call BIS_fnc_getParamValue;
_deserted = "ptxtrn_supply_deserted" call BIS_fnc_getParamValue;
_onetime = 1;
while {_destroyed > 0 || _onetime > 0} do {
	_veh setVariable ["ptxtrn_vehicle_name", _veh_name, true];
	["Managing %1 with destroyed delay=%2", _veh_name, _destroyed] call BIS_fnc_logFormat;
	waitUntil {sleep 2; !Alive _veh};
	_dir  = getDir _veh;
	_pos  = getPos _veh;
	_veh setVariable ["ptxtrn_vehicle_name", "", true];
	_onetime = 0;
	if (_destroyed > 0) then {
		["Managing %1 destroyed", _veh_name] call BIS_fnc_logFormat;
		sleep _destroyed;
		deleteVehicle _veh;
		sleep 2;
		_veh = createVehicle [_type, (_pos findEmptyPosition [1, 500, _type]), [], 0, "NONE"];
		_veh setDir _dir;
		_veh setVelocity [0, 0, -1];
	};
};
if(true) exitWith{};
