//Uncomment if you want to test

/*

var _device = InputPlayerGetDevice();

var _string = "";
_string += $"Rebinding \"{InputDeviceGetDescription(_device)}\" = {InputDeviceGetRebinding(_device)? "true" : "false"}\n";
_string += $"[{InputVerbGetBindingName(INPUT_VERB.ACCEPT)}] = Start rebinding\n\n";

var _array = InputPlugInGetAllVerbs();
var _i = 0;
repeat(array_length(_array))
{
    var _verb = _array[_i];
    _string += (_verb == rebindingVerb)? "-->  " : "     ";
    _string += InputVerbGetExportName(_verb);
    _string += "  =  " + InputVerbGetBindingName(_verb);
    _string += "\n";
    ++_i;
}

_string += "\n";
_string += $"Verb Group .EXAMPLE_A, active = {InputVerbGroupGetActive(INPUT_VERB_GROUP.EXAMPLE_A)? "true" : "false"}\n";

var _array = InputVerbGroupGetVerbs(INPUT_VERB_GROUP.EXAMPLE_A);
var _i = 0;
repeat(array_length(_array))
{
    _string += InputVerbGetExportName(_array[_i]) + "\n";
    ++_i;
}

_string += "\n";
_string += $"Verb Group .EXAMPLE_B, active = {InputVerbGroupGetActive(INPUT_VERB_GROUP.EXAMPLE_B)? "true" : "false"}\n";

var _array = InputVerbGroupGetVerbs(INPUT_VERB_GROUP.EXAMPLE_B);
var _i = 0;
repeat(array_length(_array))
{
    _string += InputVerbGetExportName(_array[_i]) + "\n";
    ++_i;
}

draw_text(10, 10, _string);

//*/