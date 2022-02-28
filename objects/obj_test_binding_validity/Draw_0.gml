var _verbs = ["invalid high key", "invalid low key", "tab key", "A key",
              "invalid high mouse", "invalid low mouse", "mouse button left", 
              "mouse button right", "mouse button middle", "mouse button back", 
              "mouse button forward", "mouse wheel down", "mouse wheel up",
              "invalid high gamepad button", "invalid low gamepad button",
              "gamepad button south", "gamepad trigger left", "gamepad dpad up",
              "invalid high gamepad axis", "invalid low gamepad axis",
              "gamepad thumbstick left"];

var _labels = "Source: ";
var _values = "Valid  Active" + "\n";

switch(input_player_source_get())
{
    case INPUT_SOURCE.KEYBOARD_AND_MOUSE: _labels += "Keyboard and Mouse" + "\n"; break;
    case INPUT_SOURCE.GAMEPAD:            _labels += "Gamepad"            + "\n"; break;
    default:                              _labels += "Unknown"            + "\n"; break;
}

var _i = 0;
repeat(array_length(_verbs))
{
    var _verb = _verbs[_i];
    var _binding = input_binding_get(_verb, input_player_source_get());
    
    //Name column
    _labels += "\n" + _verb;
    
    //Valid column
    _values += "\n" + string(input_binding_is_valid(_binding));
    
    //Active column
    _values += string_repeat(" ", 6) + string(input_check(_verb));
    
    ++_i;
}

draw_text( 10, 10, _labels);
draw_text(330, 10, _values);
