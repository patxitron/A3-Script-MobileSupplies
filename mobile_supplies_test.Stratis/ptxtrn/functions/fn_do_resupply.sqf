/*
 * fnc_do_resupply
 *
 * Repairs, refuels and resupplies a vehicle.
 *
 * USAGE:
 *     [target, supplier] call ptxtrn_fnc_do_resupply;
 *     where:
 *         target is the object (vehicle) to be resupplied.
 *         supplier is the object (vehicle) which provides the supplies (used to give messages in its vehicle chat).
 *
 * DO NOT USE THIS FUNCTION, IT IS FOR INTERNAL USE ONLY (CALLED BY ptxtrn_fnc_manage_vehicle).
 */

_target = _this select 0;
_supplier = _this select 1;

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
