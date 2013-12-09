Mobile repair, refuel and rearm script para ArmA III, por [UTUM]Patxitron
=========================================================================

En primer lugar agradecer a =BTC= Giallustio su excelente
script =BTC= Revive en el que este está basado.

Esta versión también incluye códifo del script namedisplay para Arma 2
de Marker y Melbo.

Para qué sirve:
---------------
Con este script puedes hacer que uno o más vehículos actúen como
centro de reparación, rearamado y repostado para otros vehículos
tanto terrestres como aéreos. En principio podría funcionar también
en vehículos marinos, pero no está probado.

También sirve como punto de teletransporte de tropas.

A lo largo de este documento, me referiré a estos vehículos como
vehículos de suminstros.


Cómo incluirlo en tu misión:
----------------------------
Este script no requiere mods ni addons. Símplemente copia la carpeta
Patxitron_MobileRepair en nu misión y añade la siguiente línea en
el fichero init.sqf:

	call compile preprocessFile "Patxitron_MobileRepair\mobile_repair_init.sqf";

Después, en el editor de misiones, pon uno o más vehículos que quieras
que actúen como vehículos de suminstros y ponles un nombre. Adicionalmente,
si quieres que además actúen como punto de teletransporte, añade en el mapa,
cerca del punto de respawn, un objeto que actúe de activador de teletransporte
y ponle también un nombre. Después, al principio del fichero
Patxitron_MobileRepair\mobile_repair_init.sqf, hay unas variables que puedes
ajustar:

*	PTXTRN_MBSP_respawn: ponla a 0 si NO quieres que los vehículos de suministros reaparezcan una vez destruidos. Cualquier valor mayor que 0 es el número de segundos que el vehículo tardará en reaparecer una vez destruido.
*	PTXTRN_MBSP_teleport_west: Lista de objetos que activan el teletransporte a vehhículos de suminstros del lado blufor.
*	PTXTRN_MBSP_teleport_east Lista de objetos que activan el teletransporte a vehhículos de suminstros del lado opfor.
*	PTXTRN_MBSP_teleport_guer Lista de objetos que activan el teletransporte a vehhículos de suminstros del lado guerrilla.
*	PTXTRN_MBSP_teleport_civ Lista de objetos que activan el teletransporte a vehhículos de suminstros del lado civil.
*	PTXTRN_MBSP_msveh_west: Lista de vehículos de suministros del lado blufor.
*	PTXTRN_MBSP_msveh_east Lista de vehículos de suministros del lado opfor.
*	PTXTRN_MBSP_msveh_guer Lista de vehículos de suministros del lado guerrilla.
*	PTXTRN_MBSP_msveh_civ Lista de vehículos de suministros del lado civil.
*	PTXTRN_show_player_tag: Cuando encaras a un jugador que está a menos distancia que la especificada aquí, aparecerá en pantalla un "tag" indicando el nombre del jugador y su arma principal. Pon la distancia a 0 para deshabilitar el tag.
* PTXTRN_show_player_marker: Los jugadores de tu propio grupo que estén a menos distancia de la indicada, tendrán un marcador con su nombre en el mapa. Pon esta distancia a 0 para desactivar las marcas en el mapa.

Es decir, si por ejemplo pones dos camiones en el lado blufor y otros dos en el opfor y quieres que sean vehículos de suministros, en el editor de misiones, ponles un nombre significativo, por ejemplo Suministros_blufor_0, Suministros_blufor_1, Suministros_opfor_0 y Suministros_opfor_1 y en el mobile_repair_init.sqf pon las variables como siguen:

	PTXTRN_MBSP_msveh_west = [Suministros_blufor_0, Suministros_blufor_1]
	PTXTRN_MBSP_msveh_east = [Suministros_opfor_0, Suministros_opfor_1]

Si pones vehículos de suministros en otros bandos, pon sus nombres en las variables correspondientes.

Si además quieres que dichos vehículos actúen como punto de teletransporte, en la base blufor, pon un objeto (por ejemplo un mástil de bandera), date un nombre (como por ejemplo Teletransporte_blufor) y en mobile_repair_init.sqf pon ese nombre en la variable PTXTRN_MBSP_teleport_west:

	PTXTRN_MBSP_teleport_west = [Teletransporte_blufor]

Si quieres poner puntos de teletransporte para otros bandos, haz lo mismo en las variables correspondientes.

Eso es todo para un uso simple.

Como "Bonus" en el fihero mobile_repair_functions.sqf la primera función llamada PTXTRN_MBSP_msveh_Provisional_Set_Loadout se encarga de establecer qué municiones y suministros de tropa lleva el vehículo de suministros. Podéis cambiarla y añadir/quitar los suministros deseados.


Cómo funciona:
--------------
En la misión de prueba tenéis dos cammiones Zamak con toldo que son vehículos de suministros del lado blufor. También tenéis un mástil con la bandera de la OTAN que os puede teletransportar a las cercanías de cualquiera de estos dos vehículos.

Para el teletransporte, acercáos a dicha bandera y en el menú de acciones aparecerán en rojo dos entradas de teletransporte: una para cada vehículo.

También tenéis varios vehículos, todos ellos dañados, y con la munición y el combustible al 50%. Para repararlos y recargarlos, se pueden hacer dos cosas: Coger el vehículo dañado y llevarlo cerca del vehículo de suministros. Una
vez en las cercanías, con el morro apuntando al vahículo de suministros y nos hayamos parado, nos aparecerá en el menú de acciones, en verde la opción de Recargar y reparar (Resupply and repair). Seleccionala y en unos segundos
el vehículo estará reparado y recargado.

La otra opción es coger el vehículo de suministros y llevarlo hasta el vehículo a reparar. Lo mismo que antes, una vez cerca y "apuntando" hacia el vehículo que queremos reparar, una vez parados, podemos seleccionar la acción de reparar y recargar.

Para que la acción tenga lugar, amboas vahículos (el de suministros y el reparable) han de estar parados (menos de 3km/h) y aterrizados (en el caso de vehículos aéreos).

Un vehículo de suministros de un bando puede reparar y recargar vehículos de cualquier bando. Sin embargo, en el mapa, sólo salen señalados los vehículos de suministros del lado propio.


Chengelog:
----------
-	V1.0:
	*	First public version.


Créditos y agradecimentos:
--------------------------
Este script está basado en el excelente =BTC= Revive de =BTC= Giallustio.
