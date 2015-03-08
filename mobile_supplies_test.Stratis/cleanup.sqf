while {true} do {
	{
		_delete = true;
		_unit = _x;
		{
			if(_unit distance _x < 150) then {_delete = false;};
		} forEach playableUnits;
		if(_delete) then {deletevehicle _unit;};
		sleep 1;
	} foreach allDead;
	sleep 60*5;
};
