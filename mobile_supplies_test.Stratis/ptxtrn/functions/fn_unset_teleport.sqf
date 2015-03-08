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
		PTXTRN_TELEPORT_TARGETS_WEST = PTXTRN_TELEPORT_TARGETS_WEST - [_veh_name];
	};
	case (_side == "east") : {
		PTXTRN_TELEPORT_TARGETS_EAST = PTXTRN_TELEPORT_TARGETS_EAST - [_veh_name];
	};
	case (_side == "guer") : {
		PTXTRN_TELEPORT_TARGETS_GUER = PTXTRN_TELEPORT_TARGETS_GUER - [_veh_name];
	};
	case (_side == "civ") : {
		PTXTRN_TELEPORT_TARGETS_CIV = PTXTRN_TELEPORT_TARGETS_CIV - [_veh_name];
	};
};
