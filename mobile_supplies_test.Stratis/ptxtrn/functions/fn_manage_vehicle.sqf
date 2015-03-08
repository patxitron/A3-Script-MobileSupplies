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
_teleport_target = _this select 1;

_veh_name = str(_veh);
_destroyed = "ptxtrn_supply_destroyed" call BIS_fnc_getParamValue;
_ammobox = "ptxtrn_supply_ammobox" call BIS_fnc_getParamValue;
_enable_marker = "ptxtrn_supply_marker" call BIS_fnc_getParamValue;

_marker = format ["%1_marker", _veh_name];
_onetime = 1;
_action = 0;
while {_destroyed > 0 || _onetime > 0} do {
	if (_ammobox == 1 || _ammobox == 3) then {
		["AmmoboxInit",[_veh, true]] spawn BIS_fnc_arsenal;
	};
	if (_ammobox == 2 || _ammobox == 3) then {
		_veh addAction["<t color='#ff1111'>Virtual Ammobox</t>", "VAS\open.sqf"];
	};
	_action = _veh addAction [
		"<t color='#11ff11'>Resupply and repair</t>",
		{
			[
				[vehicle (_this select 1), _this select 0],
				"ptxtrn_fnc_do_resupply",
				nil,
				false
			] spawn BIS_fnc_MP
		},
		[],
		10,
		true,
		true,
		"",
		"_this != (vehicle _this) &&  _this == driver (vehicle _this) && (vehicle _this) != _target && speed _target <= 5 && speed _target >= -3 && speed (vehicle _this) <= 5 && speed (vehicle _this) >= -3 && (getPos (vehicle _this)) select 2 <= 2 && (getPos _target) select 2 <= 2"
	];
	if (_teleport_target == "west" || _teleport_target == "east" || _teleport_target == "guer" || _teleport_target == "civ") then {
		[_teleport_target, _veh_name] call ptxtrn_fnc_set_teleport;
	};
	if (_enable_marker > 0) then {
		deleteMarkerLocal _marker;
		createmarkerLocal [_marker, getPos _veh];
		_marker setmarkertypeLocal "mil_dot";
		_marker setMarkerTextLocal format ["%1", _veh_name];
		_marker setmarkerColorlocal "ColorGreen";
		_marker setMarkerSizeLocal [0.5, 0.5];
	};
	hint format ["%1 is available!", _veh_name];
	while {Alive _veh} do {
		_pos = getPos _veh;
		{
			if(!(_x getVariable ["has_resupply_action", false])) then {
				_x addAction [
					"<t color='#11ff11'>Resupply and repair</t>",
					{
						[
							[_this select 0, vehicle (_this select 1)],
							"ptxtrn_fnc_do_resupply",
							nil,
							false
						] spawn BIS_fnc_MP
					},
					[],
					10,
					true,
					true,
					"",
					"_this != (vehicle _this) &&  _this == driver (vehicle _this) && (vehicle _this) != _target && ((vehicle _this) getVariable ['PTXTRN_MBSP_Vehicle_name', '']) != '' && speed _target <= 5 && speed _target >= -3 && speed (vehicle _this) <= 5 && speed (vehicle _this) >= -3 && (getPos (vehicle _this)) select 2 <= 2 && (getPos _target) select 2 <= 2"
				];
				_x setVariable ["has_resupply_action", true];
			};
		} foreach (_pos nearObjects 50);

		if (_enable_marker > 0) then {
			_marker setMarkerPosLocal _pos;
			if (speed _veh <= 5 && speed _veh >= -3) then {
				_marker setMarkerTextLocal format ["%1 deployed", _veh_name];
				_marker setmarkerColorlocal "ColorGreen";
			} else {
				_marker setMarkerTextLocal format ["%1 is moving", _veh_name];
				_marker setmarkerColorlocal "ColorBlack";
			};
		};
		sleep 2;
	};
	_veh removeAction _action;
	hint format ["%1 has been destroyed!", _veh_name];
	if (_enable_marker > 0) then {
		_marker setMarkerTextLocal format ["%1 destroyed!", _veh_name];
		_marker setmarkerColorlocal "ColorRed";
	};
	if (_teleport_target == "west" || _teleport_target == "east" || _teleport_target == "guer" || _teleport_target == "civ") then {
		[_teleport_target, _veh_name] call ptxtrn_fnc_unset_teleport;
	};
	_onetime = 0;
	if (_destroyed > 0) then {
		hint format["destroyed %1, delay=%2", _veh_name, _destroyed];
		sleep _destroyed;
		_veh = objNull;
		while {isNull _veh} do {
			{
				if ((_x getVariable "ptxtrn_vehicle_name") == _veh_name && Alive _x) then {
					_veh = _x;
				};
			} foreach vehicles;
			sleep 1;
		};
	};
};
if(true) exitWith{};
