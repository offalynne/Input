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
_string += "Left alt 0  = " + string(input_binding_get_name(input_binding_get("left",  undefined, 0, 0))) + "\n";
_string += "Right alt 0 = " + string(input_binding_get_name(input_binding_get("right", undefined, 0, 0))) + "\n";
_string += "Up alt 0    = " + string(input_binding_get_name(input_binding_get("up",    undefined, 0, 0))) + "\n";
_string += "Down alt 0  = " + string(input_binding_get_name(input_binding_get("down",  undefined, 0, 0))) + "\n";
_string += "\n";
_string += "Left alt 1  = " + string(input_binding_get_name(input_binding_get("left",  undefined, 0, 1))) + "\n";
_string += "Right alt 1 = " + string(input_binding_get_name(input_binding_get("right", undefined, 0, 1))) + "\n";
_string += "Up alt 1    = " + string(input_binding_get_name(input_binding_get("up",    undefined, 0, 1))) + "\n";
_string += "Down alt 1  = " + string(input_binding_get_name(input_binding_get("down",  undefined, 0, 1))) + "\n";

draw_text(10, 10, _string);