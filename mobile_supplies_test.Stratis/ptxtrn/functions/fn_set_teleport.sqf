/*
 * fnc_set_teleport
 *
 * Set a target for the teleport system.
 *
 * USAGE: Do not call this function in your mission, it ir for internal use only
 *     [side, targetname] call ptxtrn_fnc_set_teleport;
 *     where:
 *         side is one of "west", "east", "guer" or "civ".
 *         targetname is the name of the vehicle which the action will teleport to.
 *
 */

_side = _this select 0;
_veh_name = _this select 1;

waitUntil {! isNil "bis_fnc_init"};

switch (true) do {
	case (_side == "west") : {
		{
			_targets = _x getVariable ["ptxtrn_teleport_targets", []];
			if([_targets,_veh_name] call ptxtrn_fnc_is_in_array < 0) then {
				_x addAction [("<t color=""#ED2744"">") + ("Teleport to " + _veh_name) + "</t>", {[_this select 1, _this select 3] call ptxtrn_fnc_do_teleport}, _veh_name, 2, true, true, "", "side player != east && str(side player) != 'guer' && [PTXTRN_TELEPORT_TARGETS_WEST,""" + _veh_name + """] call ptxtrn_fnc_is_in_array > -1"];
				_targets = [_targets, [_veh_name]] call ptxtrn_fnc_array_append;
				_x setVariable ["ptxtrn_teleport_targets", _targets];
			};
			if([PTXTRN_TELEPORT_TARGETS_WEST,_veh_name] call ptxtrn_fnc_is_in_array < 0) then {
				PTXTRN_TELEPORT_TARGETS_WEST = [PTXTRN_TELEPORT_TARGETS_WEST, [_veh_name]] call ptxtrn_fnc_array_append;
			};
		} foreach PTXTRN_TELEPORT_TRIGGERS_WEST;
	};
	case (_side == "east") : {
		{
			_targets = _x getVariable ["ptxtrn_teleport_targets", []];
			if([_targets,_veh_name] call ptxtrn_fnc_is_in_array < 0) then {
				_x addAction [("<t color=""#ED2744"">") + ("Teleport to " + _veh_name) + "</t>", {[_this select 1, _this select 3] call ptxtrn_fnc_do_teleport}, _veh_name, 2, true, true, "", "side player != west && str(side player) != 'guer' && [PTXTRN_TELEPORT_TARGETS_EAST,""" + _veh_name + """] call ptxtrn_fnc_is_in_array > -1"];
				_targets = [_targets, [_veh_name]] call ptxtrn_fnc_array_append;
				_x setVariable ["ptxtrn_teleport_targets", _targets];
			};
			if([PTXTRN_TELEPORT_TARGETS_EAST,_veh_name] call ptxtrn_fnc_is_in_array < 0) then {
				PTXTRN_TELEPORT_TARGETS_EAST = [PTXTRN_TELEPORT_TARGETS_EAST, [_veh_name]] call ptxtrn_fnc_array_append;
			};
		} foreach PTXTRN_TELEPORT_TRIGGERS_EAST;
	};
	case (_side == "guer") : {
		{
			_targets = _x getVariable ["ptxtrn_teleport_targets", []];
			if([_targets,_veh_name] call ptxtrn_fnc_is_in_array < 0) then {
				_x addAction [("<t color=""#ED2744"">") + ("Teleport to " + _veh_name) + "</t>", {[_this select 1, _this select 3] call ptxtrn_fnc_do_teleport}, _veh_name, 2, true, true, "", "side player != east && side player != west && [PTXTRN_TELEPORT_TARGETS_GUER,""" + _veh_name + """] call ptxtrn_fnc_is_in_array > -1"];
				_targets = [_targets, [_veh_name]] call ptxtrn_fnc_array_append;
				_x setVariable ["ptxtrn_teleport_targets", _targets];
			};
			if([PTXTRN_TELEPORT_TARGETS_GUER,_veh_name] call ptxtrn_fnc_is_in_array < 0) then {
				PTXTRN_TELEPORT_TARGETS_GUER = [PTXTRN_TELEPORT_TARGETS_GUER, [_veh_name]] call ptxtrn_fnc_array_append;
			};
		} foreach PTXTRN_TELEPORT_TRIGGERS_GUER;
	};
	case (_side == "civ") : {
		{
			_targets = _x getVariable ["ptxtrn_teleport_targets", []];
			if([_targets,_veh_name] call ptxtrn_fnc_is_in_array < 0) then {
				_x addAction [("<t color=""#ED2744"">") + ("Teleport to " + _veh_name) + "</t>", {[_this select 1, _this select 3] call ptxtrn_fnc_do_teleport}, _veh_name, 2, true, true, "", "side player == civ && [PTXTRN_TELEPORT_TARGETS_CIV,""" + _veh_name + """] call ptxtrn_fnc_is_in_array > -1"];
				_targets = [_targets, [_veh_name]] call ptxtrn_fnc_array_append;
				_x setVariable ["ptxtrn_teleport_targets", _targets];
			};
			if([PTXTRN_TELEPORT_TARGETS_CIV,_veh_name] call ptxtrn_fnc_is_in_array < 0) then {
				PTXTRN_TELEPORT_TARGETS_CIV = [PTXTRN_TELEPORT_TARGETS_CIV, [_veh_name]] call ptxtrn_fnc_array_append;
			};
		} foreach PTXTRN_TELEPORT_TRIGGERS_CIV;
	};
};
