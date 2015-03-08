MobileSupplies por [UTUM]Patxitron
==================================

Mi script ArmA III de vehículo de suministros.


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

Este script no requiere mods ni addons. Símplemente copia la carpeta ptxtrn
en tu misión y añade las siguientes líneas en el fichero description.ext:

```
class CfgFunctions
{
	#include "ptxtrn\cfgfunctions.hpp"
};
class Params
{
	#include "ptxtrn\params.hpp"
};

```

Después, en el editor de misiones, pon uno o más vehículos que quieras
que actúen como vehículos de suminstros y ponles un nombre. En el campo "init" del
vehículo pones la siguiente orden:

```
0 = ["west", this] call ptxtrn_fnc_supplies;
```

Con esto, el vehículo será un centro de suministros para los Blufor. Si quieres que
lo sea para los Opfor, cambia la opción "west" por "east". Esta opción también
puede ser "civ" para los civiles o "guer" para la guerrilla.

Recuerda que es importante que estos vehículos tengan un nombre.

Adicionalmente, si quieres que además actúen como punto de teletransporte,
añade en el mapa, cerca del punto de respawn, un objeto que actúe de activador
de teletransporte y en el campo init le añades la siguiente sentencia:

```
0 = ["west", this] call ptxtrn_fnc_init_teleport;
```

Con esto dicho objeto actuará como elemento de teletransporte a los
vehículos de suministros del lado Blufor. Al igual que en el caso anterior
la opción "west" puede ser cambiada por "east", "civ" o "guer" y actuará
como elemento de teletransporte para el bando designado.

Cómo funciona:
--------------

En la misión de prueba tenéis al lado del respawn un helicóptero y un vehículo blindado
que actúan como vehículos de suministros para el bando Blufor. También hay un mástil
con la bandera de la OTAN que actúa como elemento de teletransporte. Adicionalmente,
en otro punto del mapa hay un Hunter y otro mástil como vehículo de suministros y
activador de teletransporte, también para el bando Blufor.

Para el teletransporte, acercáos a la bandera y en el menú de acciones aparecerán en rojo
tres entradas de teletransporte, una para cada vehículo.

También tenéis varios vehículos que no son de suministros con los que podéis probar las
reparaciones y las recargas de munición y combustible. Para repararlos y recargarlos,
se pone el vehículo a reparar cerca del de suministros y apuntando hacia él y saldrá en
el menú de acciones la opción de Recargar y reparar (Resupply and repair). Selecciónala y
en unos segundos el vehículo estará reparado y recargado.

Para que la acción tenga lugar, ambos vehículos (el de suministros y el reparable) han de
estar parados (menos de 3km/h) y aterrizados (en el caso de vehículos aéreos).

Un vehículo de suministros de un bando puede reparar y recargar vehículos de cualquier
bando. Sin embargo, en el mapa, sólo salen señalados los vehículos de suministros del lado
propio (si el parámetro correspondiente está activado).

Si activas el teletransporte, puedes teletransportar vehículos completos: Súbete como
conductor y llévalo hasta el punto de teletransporte. Si activas la opción de teletransopote,
llevará al destino el vehículo que conduces con sus ocupantes.

Parámetros:
-----------
Al iniciar la misión se pueden cambiar los siguientes parámetros:

* Support vehicle deserted respawn delay (minutes): Retardo desde que se deja un
vehículo de suministros hasta que se considera abandonado y se devuelve al punto
en el que estaba cuando se inició la misión. Poner a 0 para desactivar. (Esta
funcionalidad no funciona todavía).
* Support vehicle destroyed respawn delay (seconds): Retardo en segundos desde que
el vehículo es destruido hasta que se repone en una posición cercana a la que
tenía cuando ha sido destruido. Poner a cero para que los vehículos no resuciten.
* Ammobox included in support vehicle: Aquí puedes seleccionar el tipo de ammobox
que los vehículos de suministros incluyen. Puede ser NONE (ninguno), ARSENAL,
VIRTUAL AMMOBOX SYSTEM ó BOTH (ambos). Si vas a usar el VIRTUAL AMMOBOX SYSTEM
debes incluirlo en la misión (Está incluido en la de prueba).
* Support vehicle marker shown in map: Si lo pones a YES, se mostrará una marca
en el mapa con la posición de cada vehículo de suministros sólo visible para
jugadores del mismo bando que el vehículo.

Changelog:
----------

* 2013-10-19 Version 0.1:
	* Primera versión pública.
* 2013-12-09 Version 0.2:
	* Reescrito gran parte del código.
	* Se añade la posibilidad de mostrar en pantalla un tag del jugador al que se apunta, basado en el script NameDisplay para ArmA II por Melbo.
	* Se añade la posibilidad de mostrar marcadores con los nombres de los jugadores de la unidad en el mapa.
	* Ahora el teletransporte funciona también con vehículos completos si lo activa el conductor.
* 2015-03-07 Version 1.0:
	* Reescrito desde cero.
	* Ahora tanto las unidades a considerar como vehículos de suministros como los puntos de teletransporte se configuran con una sentencia en el init del objeto en el editor.
	* Parámetros configurables al iniciar misión.
	* Eliminado el código que pone etiquetas a los demás jugadores. Se escribirá un script aparte para esta funcionalidad.

Créditos y agradecimentos:
--------------------------

Las versiones anteriores de este script estában basadas en el excelente =BTC= Revive
de =BTC= Giallustio y contenían código basado en el script NameDisplay para ArmA II por Melbo.

A partir de la versión 1.0 se ha reescrito desde cero sin base clara en ningún otro
código y se ha eliminado los tags de los players por no estar relacionado con la
funcionalidad del script.
