var _string = "";

if (rebinding)
{
    _string += "Rebinding alt=" + string(rebinding_alt) + "\n\n";
}
else
{
    _string += "\n\n";
}

_string += "Left  = " + string(input_value("left" )) + "\n";
_string += "Right = " + string(input_value("right")) + "\n";
_string += "Up    = " + string(input_value("up"   )) + "\n";
_string += "Down  = " + string(input_value("down" )) + "\n";
_string += "\n";
_string += "Left alt 0  = " + string(input_binding_get_name(input_binding_get("left",  0, 0))) + "\n";
_string += "Right alt 0 = " + string(input_binding_get_name(input_binding_get("right", 0, 0))) + "\n";
_string += "Up alt 0    = " + string(input_binding_get_name(input_binding_get("up",    0, 0))) + "\n";
_string += "Down alt 0  = " + string(input_binding_get_name(input_binding_get("down",  0, 0))) + "\n";
_string += "\n";
_string += "Left alt 1  = " + string(input_binding_get_name(input_binding_get("left",  0, 1))) + "\n";
_string += "Right alt 1 = " + string(input_binding_get_name(input_binding_get("right", 0, 1))) + "\n";
_string += "Up alt 1    = " + string(input_binding_get_name(input_binding_get("up",    0, 1))) + "\n";
_string += "Down alt 1  = " + string(input_binding_get_name(input_binding_get("down",  0, 1))) + "\n";

draw_text(10, 10, _string);