class ptxtrn_supply_deserted
{
        title = "Support vehicle deserted respawn delay (minutes)";
	values[] = {0,30,45,60,75,90};
	default = 0; // Never respawn
};
class ptxtrn_supply_destroyed
{
        title = "Support vehicle destroyed respawn delay (seconds)";
	values[] = {0,15,30,45,60,75,90};
	default = 60;
};
class ptxtrn_supply_ammobox
{
        title = "Ammobox included in support vehicle ";
	values[] = {0,1,2,3};
	texts[] = {"NONE","ARSENAL","VIRTUAL AMMOBOX SYSTEM","BOTH"};
	default = 0;
};
class ptxtrn_supply_marker
{
        title = "Support vehicle marker shown in map";
	values[] = {0,1};
	texts[] = {"NO","YES"};
	default = 0;
};
