/*
 * fnc_init_teleport
 *
 * Initializes the teleport subsystem and adds an object as trigger.
 *
 * USAGE: Put the following line in the "Init" field of the object:
 *     _nil = [side, this] call ptxtrn_fnc_init_teleport;
 *     where:
 *         side is one of "west", "east", "guer" or "civ".
 *
 */

_side = _this select 0;

if (_side == "preInit") then {
	PTXTRN_TELEPORT_TARGETS_WEST = [];
	PTXTRN_TELEPORT_TARGETS_EAST = [];
	PTXTRN_TELEPORT_TARGETS_GUER = [];
	PTXTRN_TELEPORT_TARGETS_CIV = [];
	PTXTRN_TELEPORT_TRIGGERS_WEST = [];
	PTXTRN_TELEPORT_TRIGGERS_EAST = [];
	PTXTRN_TELEPORT_TRIGGERS_GUER = [];
	PTXTRN_TELEPORT_TRIGGERS_CIV = [];
} else {
	_object = _this select 1;
	_object setVariable ["ptxtrn_teleport_targets", []];
	switch (true) do {
		case (_side == "west") : {
			PTXTRN_TELEPORT_TRIGGERS_WEST = [PTXTRN_TELEPORT_TRIGGERS_WEST, [_object]] call ptxtrn_fnc_array_append;
		};
		case (_side == "east") : {
			PTXTRN_TELEPORT_TRIGGERS_EAST = [PTXTRN_TELEPORT_TRIGGERS_EAST, [_object]] call ptxtrn_fnc_array_append;
		};
		case (_side == "guer") : {
			PTXTRN_TELEPORT_TRIGGERS_GUER = [PTXTRN_TELEPORT_TRIGGERS_GUER, [_object]] call ptxtrn_fnc_array_append;
		};
		case (_side == "civ") : {
			PTXTRN_TELEPORT_TRIGGERS_CIV = [PTXTRN_TELEPORT_TRIGGERS_CIV, [_object]] call ptxtrn_fnc_array_append;
		};
	};
};
