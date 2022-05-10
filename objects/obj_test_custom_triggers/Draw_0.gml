var _string =  "Verb   State  Binding \n"; 
    _string += "Left   " + string(input_check_pressed("left" )) + " " + string(max(0, input_held_time("left" )) mod 10) + " " + string(input_check_released("left" )) + "  " + string(input_binding_get("left" )) + "\n";
    _string += "Right  " + string(input_check_pressed("right")) + " " + string(max(0, input_held_time("right")) mod 10) + " " + string(input_check_released("right")) + "  " + string(input_binding_get("right")) + "\n";
    _string += "Up     " + string(input_check_pressed("up"   )) + " " + string(max(0, input_held_time("up"   )) mod 10) + " " + string(input_check_released("up"   )) + "  " + string(input_binding_get("up"   )) + "\n";
    _string += "Down   " + string(input_check_pressed("down" )) + " " + string(max(0, input_held_time("down" )) mod 10) + " " + string(input_check_released("down" )) + "  " + string(input_binding_get("down" )) + "\n";

draw_text(10, 10, _string);