

_unit = _this select 0;
_who = _unit;
_var = _this select 1;
_veh = objNull;
_unit_veh = vehicle _unit;
if(_unit_veh != _unit) then {
	if(_unit == driver _unit_veh) then {
		_who = _unit_veh;
	};
};



while {isNull _veh} do {
	{if(format ["%1", _x getVariable "ptxtrn_vehicle_name"] == _var && Alive _x) then {_veh = _x;};} foreach vehicles;
	sleep 1;
};
if(!Alive _veh) then {
	_unit sideChat "Can not teleport. The spawn point is destroyed";
} else {
	if(speed _veh <= 5 && speed _veh >= -3) then {
		_who setPos ((getPos _veh) findEmptyPosition [10, 300]);
	} else {
		_unit sideChat "Can not teleport. The spawn point is moving. Wait until it stops";
	};
};
if(true) exitWith{};
