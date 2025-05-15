var _device = InputPlayerGetDevice();
var _isGamepad = InputDeviceIsGamepad(_device);

var _string = "";
_string += string_concat("Rebinding \"", InputDeviceGetDescription(_device), "\" = ", InputDeviceGetRebinding(_device)? "true" : "false", "\n");
_string += "[space] = Start rebinding\n\n";

var _array = InputPlugInGetAllVerbs();
var _i = 0;
repeat(array_length(_array))
{
    var _verb = _array[_i];
    _string += (_verb == rebindingVerb)? "-->  " : "     ";
    _string += InputVerbGetExportName(_verb);
    _string += "  =  " + InputGetBindingName(InputBindingGet(_isGamepad, _verb), _isGamepad);
    _string += "\n";
    ++_i;
}

_string += "\n";
_string += $"Verb Group .EXAMPLE, active = {InputVerbGroupGetActive(INPUT_VERB_GROUP.EXAMPLE)? "true" : "false"}\n";

var _array = InputVerbGroupGetVerbs(INPUT_VERB_GROUP.EXAMPLE);
var _i = 0;
repeat(array_length(_array))
{
    _string += InputVerbGetExportName(_array[_i]) + "\n";
    ++_i;
}

draw_text(10, 10, _string);