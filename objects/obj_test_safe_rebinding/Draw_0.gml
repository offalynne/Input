var _string = "";

if (rebinding)
{
    _string += "Rebinding alt=" + string(rebinding_alt) + "\n\n";
}
else
{
    _string += "\n\n";
}

_string += "Left  = " + string(input_value(VERB.LEFT )) + "\n";
_string += "Right = " + string(input_value(VERB.RIGHT)) + "\n";
_string += "Up    = " + string(input_value(VERB.UP   )) + "\n";
_string += "Down  = " + string(input_value(VERB.DOWN )) + "\n";
_string += "\n";
_string += "Left alt 0  = " + string(input_binding_get_name(input_binding_get(VERB.LEFT,  undefined, 0, 0))) + "\n";
_string += "Right alt 0 = " + string(input_binding_get_name(input_binding_get(VERB.RIGHT, undefined, 0, 0))) + "\n";
_string += "Up alt 0    = " + string(input_binding_get_name(input_binding_get(VERB.UP,    undefined, 0, 0))) + "\n";
_string += "Down alt 0  = " + string(input_binding_get_name(input_binding_get(VERB.DOWN,  undefined, 0, 0))) + "\n";
_string += "\n";
_string += "Left alt 1  = " + string(input_binding_get_name(input_binding_get(VERB.LEFT,  undefined, 0, 1))) + "\n";
_string += "Right alt 1 = " + string(input_binding_get_name(input_binding_get(VERB.RIGHT, undefined, 0, 1))) + "\n";
_string += "Up alt 1    = " + string(input_binding_get_name(input_binding_get(VERB.UP,    undefined, 0, 1))) + "\n";
_string += "Down alt 1  = " + string(input_binding_get_name(input_binding_get(VERB.DOWN,  undefined, 0, 1))) + "\n";

draw_text(10, 10, _string);