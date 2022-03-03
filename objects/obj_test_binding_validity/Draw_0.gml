var _string = "Source: ";

switch(input_player_source_get())
{
    case INPUT_SOURCE.KEYBOARD_AND_MOUSE: _string += "Keyboard and Mouse"; break;
    case INPUT_SOURCE.GAMEPAD:            _string += "Gamepad";            break;
    default:                              _string += "Unknown";            break;
}

_string += "\n";
_string += "\n" + "Verb                    Valid Active";

var _gap = string_repeat(" ", 6);

_string += "\n" + "invalid high key            " + string(input_binding_is_valid(input_binding_get("invalid high key", INPUT_SOURCE.KEYBOARD_AND_MOUSE))) + _gap + string(input_check("invalid high key"));
_string += "\n" + "invalid low key             " + string(input_binding_is_valid(input_binding_get("invalid low key",  INPUT_SOURCE.KEYBOARD_AND_MOUSE))) + _gap + string(input_check("invalid low key"));
_string += "\n" + "tab key                     " + string(input_binding_is_valid(input_binding_get("tab key",          INPUT_SOURCE.KEYBOARD_AND_MOUSE))) + _gap + string(input_check("tab key"));
_string += "\n" + "A key                       " + string(input_binding_is_valid(input_binding_get("A key",            INPUT_SOURCE.KEYBOARD_AND_MOUSE))) + _gap + string(input_check("A key"));

_string += "\n" + "invalid high mouse          " + string(input_binding_is_valid(input_binding_get("invalid high mouse",   INPUT_SOURCE.KEYBOARD_AND_MOUSE))) + _gap + string(input_check("invalid high mouse"));
_string += "\n" + "invalid low mouse           " + string(input_binding_is_valid(input_binding_get("invalid low mouse",    INPUT_SOURCE.KEYBOARD_AND_MOUSE))) + _gap + string(input_check("invalid low mouse"));
_string += "\n" + "mouse button left           " + string(input_binding_is_valid(input_binding_get("mouse button left",    INPUT_SOURCE.KEYBOARD_AND_MOUSE))) + _gap + string(input_check("mouse button left"));
_string += "\n" + "mouse button right          " + string(input_binding_is_valid(input_binding_get("mouse button right",   INPUT_SOURCE.KEYBOARD_AND_MOUSE))) + _gap + string(input_check("mouse button right"));
_string += "\n" + "mouse button middle         " + string(input_binding_is_valid(input_binding_get("mouse button middle",  INPUT_SOURCE.KEYBOARD_AND_MOUSE))) + _gap + string(input_check("mouse button middle"));
_string += "\n" + "mouse button back           " + string(input_binding_is_valid(input_binding_get("mouse button back",    INPUT_SOURCE.KEYBOARD_AND_MOUSE))) + _gap + string(input_check("mouse button back"));
_string += "\n" + "mouse button forward        " + string(input_binding_is_valid(input_binding_get("mouse button forward", INPUT_SOURCE.KEYBOARD_AND_MOUSE))) + _gap + string(input_check("mouse button forward"));

_string += "\n" + "mouse wheel down            " + string(input_binding_is_valid(input_binding_get("mouse wheel down", INPUT_SOURCE.KEYBOARD_AND_MOUSE))) + _gap + string(input_check("mouse wheel down"));
_string += "\n" + "mouse wheel up              " + string(input_binding_is_valid(input_binding_get("mouse wheel up",   INPUT_SOURCE.KEYBOARD_AND_MOUSE))) + _gap + string(input_check("mouse wheel up"));

_string += "\n" + "invalid high gamepad button " + string(input_binding_is_valid(input_binding_get("invalid high gamepad button", INPUT_SOURCE.GAMEPAD))) + _gap + string(input_check("invalid high gamepad button"));
_string += "\n" + "invalid low gamepad button  " + string(input_binding_is_valid(input_binding_get("invalid low gamepad button",  INPUT_SOURCE.GAMEPAD))) + _gap + string(input_check("invalid low gamepad button"));
_string += "\n" + "gamepad button south        " + string(input_binding_is_valid(input_binding_get("gamepad button south",        INPUT_SOURCE.GAMEPAD))) + _gap + string(input_check("gamepad button south"));
_string += "\n" + "gamepad trigger left        " + string(input_binding_is_valid(input_binding_get("gamepad trigger left",        INPUT_SOURCE.GAMEPAD))) + _gap + string(input_check("gamepad trigger left"));
_string += "\n" + "gamepad dpad up             " + string(input_binding_is_valid(input_binding_get("gamepad dpad up",             INPUT_SOURCE.GAMEPAD))) + _gap + string(input_check("gamepad dpad up"));

_string += "\n" + "invalid high gamepad axis   " + string(input_binding_is_valid(input_binding_get("invalid high gamepad axis", INPUT_SOURCE.GAMEPAD))) + _gap + string(input_check("invalid high gamepad axis"));
_string += "\n" + "invalid low gamepad axis    " + string(input_binding_is_valid(input_binding_get("invalid low gamepad axis",  INPUT_SOURCE.GAMEPAD))) + _gap + string(input_check("invalid low gamepad axis"));
_string += "\n" + "gamepad thumbstick left     " + string(input_binding_is_valid(input_binding_get("gamepad thumbstick left",   INPUT_SOURCE.GAMEPAD))) + _gap + string(input_check("gamepad thumbstick left"));

draw_text(10, 10, _string);

