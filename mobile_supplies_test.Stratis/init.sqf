if ((!isServer) && (player != player)) then {
	waitUntil {player == player};
};
enableSaving [false, false];
call compile preprocessFile "Patxitron_MobileRepair\mobile_repair_init.sqf";
