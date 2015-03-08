/*
   Author:
	patxi
    
   Description:
    returns the index of the given string in array (-1 if not found)
    
   Parameter(s):
    _this select 0: array
    _this select 1: string to find
    
   Returns:
    index
*/
_array = _this select 0;
_str = _this select 1;
_result = -1;
_i = 0;

{
	if (_x == _str) then {_result = _i;};
	_i = _i + 1;
} foreach _array;

_result;
