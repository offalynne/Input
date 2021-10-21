var _string  = "Left  = " + string(input_value("left"   )) + "    " + string(input_binding_get("left"   )) + "\n";
    _string += "Right = " + string(input_value("right"  )) + "    " + string(input_binding_get("right"  )) + "\n";
    _string += "Up    = " + string(input_value("up"     )) + "    " + string(input_binding_get("up"     )) + "\n";
    _string += "Down  = " + string(input_value("down"   )) + "    " + string(input_binding_get("down"   )) + "\n";

draw_text(10, 10, _string);