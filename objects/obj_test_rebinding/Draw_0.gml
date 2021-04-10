var _string = "";

if (rebinding)
{
    _string += "Rebinding (source=" + input_source_get_name(rebinding_source) + ")\n\n";
}
else
{
    _string += "\n\n";
}

_string += "Left  = " + string(input_value(VERB.LEFT   )) + "    " + string(input_binding_get_name(input_binding_get(VERB.LEFT   ))) + "\n";
_string += "Right = " + string(input_value(VERB.RIGHT  )) + "    " + string(input_binding_get_name(input_binding_get(VERB.RIGHT  ))) + "\n";
_string += "Up    = " + string(input_value(VERB.UP     )) + "    " + string(input_binding_get_name(input_binding_get(VERB.UP     ))) + "\n";
_string += "Down  = " + string(input_value(VERB.DOWN   )) + "    " + string(input_binding_get_name(input_binding_get(VERB.DOWN   ))) + "\n";

draw_text(10, 10, _string);