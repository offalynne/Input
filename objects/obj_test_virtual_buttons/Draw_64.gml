input_virtual_debug_draw();

var _string = concat(
    "accept = ", input_value("accept"), "\n",
    "right  = ", input_value("right" ), "\n",
    "up     = ", input_value("up"    ), "\n",
    "left   = ", input_value("left"  ), "\n",
    "down   = ", input_value("down"  ), "\n"
);

draw_text(10, 10, _string);