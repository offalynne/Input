var _string = "";
_string += concat("paddle1  = ", input_check("up"     ), "\n");
_string += concat("paddle2  = ", input_check("down"   ), "\n");
_string += concat("paddle3  = ", input_check("left"   ), "\n");
_string += concat("paddle4  = ", input_check("right"  ), "\n");
_string += concat("touchpad = ", input_check("accept" ), "\n");
_string += concat("guide    = ", input_check("action" ), "\n");
_string += concat("misc1    = ", input_check("special"), "\n");
draw_text(10, 10, _string);