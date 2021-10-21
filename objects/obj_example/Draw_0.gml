var _string  = "Left          = " + string(input_value("left"   )) + "    " + string(input_binding_get_name(input_binding_get("left"   ))) + "\n";
    _string += "Right         = " + string(input_value("right"  )) + "    " + string(input_binding_get_name(input_binding_get("right"  ))) + "\n";
    _string += "Up            = " + string(input_value("up"     )) + "    " + string(input_binding_get_name(input_binding_get("up"     ))) + "\n";
    _string += "Down          = " + string(input_value("down"   )) + "    " + string(input_binding_get_name(input_binding_get("down"   ))) + "\n";
    _string += "Confirm       = " + string(input_value("confirm")) + "    " + string(input_binding_get_name(input_binding_get("confirm"))) + "\n";
    _string += "Cancel        = " + string(input_value("cancel" )) + "    " + string(input_binding_get_name(input_binding_get("cancel" ))) + "\n";
    _string += "Pause         = " + string(input_value("pause"  )) + "    " + string(input_binding_get_name(input_binding_get("pause"  ))) + "\n";
    _string += "Recent (all)  = " + string(input_check_press_most_recent()) + "\n";
    _string += "Recent (4dir) = " + string(input_check_press_most_recent(["left", "right", "up", "down"])) + "\n";
    _string += "Repeat        = " + string(input_check_repeat("up"));

draw_text(10, 10, _string);