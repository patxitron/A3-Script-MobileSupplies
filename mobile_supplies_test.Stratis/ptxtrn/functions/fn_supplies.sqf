/*
 * fnc_supplies
 *
 * Watch for the given vehicle, initializes its ammobox, its supplier abilities and its spawn target abilities and
 * then maintains its marker updated while the vehicle is alive.
 *
 * IMPORTANT: Always give a name to the vehicles to be managed.
 *
 * USAGE: Put this line in the "Init" field of the vehicle and give it a name:
 *     _nil = [teleport_target, this] call ptxtrn_fnc_supplies;
 *     where:
 *         teleport_target is one of "none", "west", "east", "guer" or "civ") then
 *                         the vehicle is a teleport target for the given side.
 */

if (isServer) then {
	_spawn = [_this select 1] spawn ptxtrn_fnc_manage_vehicle_server;
};
if (!isDedicated) then {
	_spawn = [_this select 1, _this select 0] spawn ptxtrn_fnc_manage_vehicle;
};
