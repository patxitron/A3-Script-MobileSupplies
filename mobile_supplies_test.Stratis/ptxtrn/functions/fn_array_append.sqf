/*
   Author:
    rübe
    
   Description:
    appends an array onto another one, modifying the
    original array (which is faster than creating a
    new list alltogether)
    
   Parameter(s):
    _this select 0: original list (array)
    _this select 1: items (array)
    
   Returns:
    original list (array)
*/

private ["_n"];

_n = count (_this select 0);

{
   (_this select 0) set [_n, _x];
   _n = _n + 1;
} forEach (_this select 1);

(_this select 0)
