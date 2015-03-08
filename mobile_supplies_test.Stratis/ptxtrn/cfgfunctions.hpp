class ptxtrn {
	tag = "ptxtrn";
	class functions {
		file = "ptxtrn\functions";
		class do_resupply {};
		class manage_vehicle {};
		class manage_vehicle_server {};
		class init_teleport {description = "Initializes the teleport subsystem and adds an object as trigger"; preInit = 1;};
		class set_teleport {};
		class unset_teleport {};
		class do_teleport {};
		class array_append {};
		class is_in_array {};
		class supplies {description = "Watch for the given vehicle, initializes its ammobox, its supplier abilities and its spawn target abilities and then maintains its marker updated while the vehicle is alive";};
	};
};
